package configuration

import (
	"context"
	"simcattle/configuration-service/db"

	"github.com/labstack/gommon/log"
)

type Repository interface {
	// Get gets the SmartSPEC configuration.
	Get(ctx context.Context) (*Config, error)

	// Update updates the SmartSPEC configuration with all entries of config
	// which are not nil.
	Update(ctx context.Context, config *Config) error
}

type repository struct{}

func NewRepository() Repository {
	return &repository{}
}

func (r *repository) Get(ctx context.Context) (*Config, error) {
	config := []*Config{}
	response := db.DB.WithContext(ctx).Find(&config)

	if response.Error != nil {
		log.Errorf("Failed to fetch SmartSPEC configuration: %s", response.Error.Error())
		return nil, response.Error
	}

	return config[0], nil
}

func (r *repository) Update(ctx context.Context, config *Config) error {
	updates := r.getUpdates(config)

	response := db.DB.WithContext(ctx).Model(config).Where("1=1").Select(updates).Updates(config)

	if response.Error != nil {
		log.Errorf("Failed to update SmartSPEC configuration: %s", response.Error.Error())
		return response.Error
	}

	return nil
}

// getUpdates returns the db fields which need to be updated.
func (r *repository) getUpdates(config *Config) []string {
	updates := []string{}
	if config.Sensors != nil {
		updates = append(updates, "sensors")
	}
	if config.Spaces != nil {
		updates = append(updates, "spaces")
	}
	if config.Metasensors != nil {
		updates = append(updates, "metasensors")
	}
	if config.LearnConf != nil {
		updates = append(updates, "learn_conf")
	}
	if config.GenConf != nil {
		updates = append(updates, "gen_conf")
	}

	return updates
}
