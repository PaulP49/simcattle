package configuration

import (
	"context"
	"net/http"
	"simcattle/configuration-service/errors"
)

// The Service separates the business logic from the controller.
type Service interface {
	// Get fetches the smartspec configuration from the repository.
	Get(ctx context.Context) (*Config, *errors.Error)

	// Put updates the smartspec configuration in the repository.
	Put(ctx context.Context, config *Config) *errors.Error
}

type service struct {
	repository Repository
}

func NewService() Service {
	return &service{
		repository: NewRepository(),
	}
}

func (s *service) Get(ctx context.Context) (*Config, *errors.Error) {
	config, err := s.repository.Get(ctx)
	if err != nil {
		return nil, errors.New(http.StatusInternalServerError, err.Error())
	}

	return config, nil
}

func (s *service) Put(ctx context.Context, config *Config) *errors.Error {
	if err := s.repository.Update(ctx, config); err != nil {
		return errors.New(http.StatusInternalServerError, err.Error())
	}

	return nil
}
