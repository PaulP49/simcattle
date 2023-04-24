package location

import (
	"context"
	"simcattle/location-service/db"
	"time"

	"github.com/labstack/gommon/log"
)

type Repository interface {
	// Get gets the location data between two different points in time.
	Get(ctx context.Context, startTime, endTime *time.Time) ([]*Location, error)
}

type repository struct{}

func NewRepository() Repository {
	return &repository{}
}

func (r *repository) Get(ctx context.Context, startTime, endTime *time.Time) ([]*Location, error) {
	locations := []*Location{}
	response := db.DB.WithContext(ctx).Where("start_time <= ?", endTime).Where("? <= end_time", startTime).Find(&locations)

	if response.Error != nil {
		log.Errorf("Failed to fetch locations: %s", response.Error.Error())
		return nil, response.Error
	}

	return locations, nil
}
