package smartspec

import (
	"context"
	"encoding/csv"
	"io"
	"net/http"
	"os"
	"time"

	"simcattle/smartspec-service/errors"

	"github.com/labstack/gommon/log"
)

// The Service separates the business logic from the controller.
type Service interface {
	// Learn executes Scenario-Learning.
	Learn(ctx context.Context) *errors.Error

	// Generate executes Scenario-Generation.
	Generate(ctx context.Context) *errors.Error

	// LearningStatus returns the status of Scenario-Learning.
	LearningStatus(ctx context.Context) (string, *errors.Error)

	// GenerationStatus returns the status of Scenario-Generation.
	GenerationStatus(ctx context.Context) (string, *errors.Error)

	// GenerationPersist stores the result of Scenario-Generation in the
	// database.
	GenerationPersist(ctx context.Context) *errors.Error
}

type service struct {
	repository Repository
	utils      Utils
}

func NewService() Service {
	return &service{
		repository: NewRepository(),
		utils:      NewUtils(),
	}
}

func (s *service) Learn(ctx context.Context) *errors.Error {
	log.Infof("Starting Scenario-Learning.")

	if err := s.utils.StartLearning(); err != nil {
		return errors.New(http.StatusServiceUnavailable, err.Error())
	}

	if err := s.fetchConfig(ctx); err != nil {
		learnInProgress = false
		return errors.New(http.StatusInternalServerError, err.Error())
	}

	go func() {
		defer s.utils.StopLearning()

		_, err := s.utils.RunBashCommand(servicePath, "make", "learn")
		if err != nil {
			log.Errorf("Scenario-Learning failed: %s", err.Error())
		}

		log.Infof("Scenario-Learning completed.")
	}()

	return nil
}

func (s *service) Generate(ctx context.Context) *errors.Error {
	log.Infof("Starting Scenario-Generation.")

	if err := s.utils.StartGenerating(); err != nil {
		return errors.New(http.StatusServiceUnavailable, err.Error())
	}

	if err := s.fetchConfig(ctx); err != nil {
		genInProgress = false
		return errors.New(http.StatusInternalServerError, err.Error())
	}

	go func() {
		defer s.utils.StopGenerating()

		_, err := s.utils.RunBashCommand(servicePath, "make", "generate")
		if err != nil {
			log.Errorf("Scenario-Generation failed: %s", err.Error())
		}

		log.Infof("Scenario-Generation completed.")
	}()

	return nil
}

func (s *service) LearningStatus(ctx context.Context) (string, *errors.Error) {
	if learnInProgress {
		return statusInProgress, nil
	}

	exists, err := s.utils.FileExists(dataPath + "/learn.conf")
	if err != nil {
		return "", errors.New(http.StatusInternalServerError, err.Error())
	}
	if !exists {
		return statusNotStarted, nil
	}

	exists, err = s.utils.FileExists(outputPath + "/Events.json")
	if err != nil {
		return "", errors.New(http.StatusInternalServerError, err.Error())
	}
	if !exists {
		return statusFailed, nil
	}

	return statusCompleted, nil
}

func (s *service) GenerationStatus(ctx context.Context) (string, *errors.Error) {
	if genInProgress {
		return statusInProgress, nil
	}

	exists, err := s.utils.FileExists(outputPath + "/data.csv")
	if err != nil {
		return "", errors.New(http.StatusInternalServerError, err.Error())
	}
	if exists {
		return statusCompleted, nil
	}

	return statusNotStarted, nil
}

func (s *service) GenerationPersist(ctx context.Context) *errors.Error {
	status, svcErr := s.GenerationStatus(ctx)
	if svcErr != nil {
		return svcErr
	}
	if status != statusCompleted {
		return errors.New(http.StatusBadRequest, "Scenario-Generation needs to be completed before persisting result")
	}

	if err := s.fetchConfig(ctx); err != nil {
		return errors.New(http.StatusInternalServerError, err.Error())
	}

	dataFile, err := os.Open(outputPath + "/data.csv")
	if err != nil {
		return errors.New(http.StatusInternalServerError, err.Error())
	}
	defer dataFile.Close()

	reader := csv.NewReader(dataFile)
	if _, err := reader.Read(); err != nil { // Discard header line
		return errors.New(http.StatusInternalServerError, err.Error())
	}

	results := []*Location{}
	coordStore := map[string]*Coordinates{}

	for {
		line, err := reader.Read()
		if err == io.EOF {
			break
		}
		if err != nil {
			return errors.New(http.StatusInternalServerError, err.Error())
		}

		spaceID := line[idxSpaceID]
		if spaceID == "0" { // data in outside space gets skipped
			continue
		}

		latitude := 0.0
		longitude := 0.0
		coords, exists := coordStore[spaceID]
		if exists {
			latitude = coords.Latitude
			longitude = coords.Longitude
		} else {
			latitude, longitude, err = s.utils.GetCoordinatesOfSpace(spaceID)
			if err != nil {
				return errors.New(http.StatusInternalServerError, err.Error())
			}
			coordStore[spaceID] = &Coordinates{Latitude: latitude, Longitude: longitude}
		}

		startTime, err := time.Parse(dateTimeFormat, line[idxStartTime])
		if err != nil {
			return errors.New(http.StatusInternalServerError, err.Error())
		}
		endTime, err := time.Parse(dateTimeFormat, line[idxEndTime])
		if err != nil {
			return errors.New(http.StatusInternalServerError, err.Error())
		}

		results = append(results, &Location{
			CattleID:  line[idxCattleID],
			Latitude:  latitude,
			Longitude: longitude,
			SpaceID:   line[idxSpaceID],
			StartTime: &startTime,
			EndTime:   &endTime,
		})
	}

	log.Infof("Storing %d results.", len(results))

	if err := s.repository.DeleteAllResults(ctx); err != nil {
		return errors.New(http.StatusInternalServerError, err.Error())
	}

	if err := s.repository.SaveResults(ctx, results); err != nil {
		return errors.New(http.StatusInternalServerError, err.Error())
	}

	return nil
}

// fetchConfig fetches the SmartSPEC configuration and stores it in files.
func (s *service) fetchConfig(ctx context.Context) error {
	config, err := s.repository.GetConfiguration(ctx)
	if err != nil {
		return err
	}

	sensorsConfig, err := s.utils.PrettyPrintJSON(config.Sensors)
	if err != nil {
		return err
	}
	spacesConfig, err := s.utils.PrettyPrintJSON(config.Spaces)
	if err != nil {
		return err
	}
	metasensorsConfig, err := s.utils.PrettyPrintJSON(config.Metasensors)
	if err != nil {
		return err
	}
	learnConf := []byte(config.LearnConf + learnPaths)
	genConf := []byte(config.GenConf + genPaths)

	if err = os.WriteFile(dataPath+"/Sensors.json", sensorsConfig, 0644); err != nil {
		return err
	}
	if err = os.WriteFile(dataPath+"/Spaces.json", spacesConfig, 0644); err != nil {
		return err
	}
	if err = os.WriteFile(dataPath+"/MetaSensors.json", metasensorsConfig, 0644); err != nil {
		return err
	}
	if err = os.WriteFile(dataPath+"/learn.conf", learnConf, 0644); err != nil {
		return err
	}
	if err = os.WriteFile(dataPath+"/gen.conf", genConf, 0644); err != nil {
		return err
	}

	return nil
}
