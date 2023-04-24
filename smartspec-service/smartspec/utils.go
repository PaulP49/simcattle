package smartspec

import (
	"bytes"
	"encoding/json"
	"errors"
	"fmt"
	"os"
	"os/exec"

	"github.com/labstack/gommon/log"
)

type Utils interface {
	// PrettyPrintJSON converts a JSON string to a byte representation of it in a
	// pretty JSON format.
	PrettyPrintJSON(str string) ([]byte, error)

	// RunBashCommand runs a bash command given by name in the desired directory
	// with any args.
	RunBashCommand(dir string, name string, arg ...string) (string, error)

	// StartLearning notifies the system that Scenario-Learning will be
	// executed.
	StartLearning() error

	// StopLearning notifies the system that Scenario-Learning will be
	// stopped.
	StopLearning()

	// StartGenerating notifies the system that Scenario-Generation will be
	// executed.
	StartGenerating() error

	// StopGenerating notifies the system that Scenario-Generation will be
	// stopped.
	StopGenerating()

	// FileExists returns wether the file given by path exists.
	FileExists(path string) (bool, error)

	// GetCoordinatesOfSpace returns the x and y coordinates of a space.
	GetCoordinatesOfSpace(spaceID string) (float64, float64, error)
}

type utils struct{}

func NewUtils() Utils {
	return &utils{}
}

func (u *utils) PrettyPrintJSON(str string) ([]byte, error) {
	strBytes := []byte(str)
	buf := &bytes.Buffer{}
	if err := json.Indent(buf, strBytes, "", "  "); err != nil {
		return nil, err
	}

	return buf.Bytes(), nil
}

func (u *utils) RunBashCommand(dir string, name string, arg ...string) (string, error) {
	cmd := exec.Command(name, arg...)
	cmd.Dir = dir
	outputBytes, err := cmd.Output()
	if err != nil {
		log.Errorf("Command execution failed: %s", err.Error())
		return "", err
	}

	output := fmt.Sprintf("%s", outputBytes)
	return output, nil
}

func (u *utils) StartLearning() error {
	if learnInProgress {
		return errors.New("Scenario-Learning already in progress")
	}
	if genInProgress {
		return errors.New("Wait for Scenario-Generation to finish before starting Scenario-Learning.")
	}

	learnInProgress = true
	return nil
}

func (u *utils) StopLearning() {
	if learnInProgress {
		learnInProgress = false
		return
	}

	log.Errorf("Scenario-Learning already stopped")
}

func (u *utils) StartGenerating() error {
	if genInProgress {
		return errors.New("Scenario-Generation already in progress")
	}
	if learnInProgress {
		return errors.New("Wait for Scenario-Learning to finish before starting Scenario-Generation.")
	}

	genInProgress = true
	return nil
}

func (u *utils) StopGenerating() {
	if genInProgress {
		genInProgress = false
		return
	}

	log.Errorf("Scenario-Generation already stopped")
}

func (u *utils) FileExists(path string) (bool, error) {
	if _, err := os.Stat(path); err == nil {
		return true, nil
	} else if errors.Is(err, os.ErrNotExist) {
		return false, nil
	} else {
		return false, err
	}
}

func (u *utils) GetCoordinatesOfSpace(spaceID string) (float64, float64, error) {
	filter := fmt.Sprintf(jqFilterTemplate, spaceID)
	result := []float64{}

	output, err := u.RunBashCommand(dataPath, "jq", filter, "Spaces.json")
	if err != nil {
		return -1, -1, err
	}
	if err := json.Unmarshal([]byte(output), &result); err != nil {
		return -1, -1, err
	}

	return result[0], result[1], nil
}
