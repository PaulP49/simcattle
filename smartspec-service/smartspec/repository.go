package smartspec

import (
	"context"
	"simcattle/smartspec-service/db"

	"github.com/labstack/gommon/log"
)

type Repository interface {
	// GetConfiguration gets the configuration for running SmartSPEC.
	GetConfiguration(ctx context.Context) (*Config, error)

	// DeleteAllResults deletes all results.
	DeleteAllResults(ctx context.Context) error

	// SaveResults saves the result of the Scenario-Generation.
	SaveResults(ctx context.Context, results []*Location) error
}

type repository struct{}

func NewRepository() Repository {
	return &repository{}
}

func (r *repository) GetConfiguration(ctx context.Context) (*Config, error) {
	config := []*Config{}
	response := db.DB.WithContext(ctx).Find(&config)

	if response.Error != nil {
		log.Errorf("Failed to fetch SmartSPEC configuration: %s", response.Error.Error())
		return nil, response.Error
	}

	return config[0], nil
}

func (r *repository) DeleteAllResults(ctx context.Context) error {
	response := db.DB.WithContext(ctx).Where("1=1").Delete(&Location{})

	if response.Error != nil {
		log.Errorf("Failed to delete results: %s", response.Error.Error())
		return response.Error
	}

	return nil
}

func (r *repository) SaveResults(ctx context.Context, results []*Location) error {
	response := db.DB.WithContext(ctx).CreateInBatches(&results, 100)

	if response.Error != nil {
		log.Errorf("Failed to store results: %s", response.Error.Error())
		return response.Error
	}

	return nil
}
