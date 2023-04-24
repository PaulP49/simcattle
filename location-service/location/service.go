package location

import (
	"context"
	"net/http"
	"simcattle/location-service/errors"
	"time"
)

// The Service separates the business logic from the controller.
type Service interface {
	// Get fetches the location data from the repository.
	Get(ctx context.Context, req *GetRequest) ([]*Location, *errors.Error)
}

type service struct {
	repository Repository
}

func NewService() Service {
	return &service{
		repository: NewRepository(),
	}
}

func (s *service) Get(ctx context.Context, req *GetRequest) ([]*Location, *errors.Error) {
	startTime := time.Unix(req.StartTime, 0)
	endTime := time.Unix(req.EndTime, 0)
	locations, err := s.repository.Get(ctx, &startTime, &endTime)
	if err != nil {
		return nil, errors.New(http.StatusInternalServerError, err.Error())
	}

	return locations, nil
}
