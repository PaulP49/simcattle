package configuration

import (
	"net/http"

	"github.com/labstack/echo/v4"
)

// The Controller handles all API requests related to the simulator
// configuration.
type Controller struct {
	service Service
}

// NewController creates a new Controller.
func NewController() *Controller {
	return &Controller{
		service: NewService(),
	}
}

// Get gets the configuration.
func (c *Controller) Get(ctx echo.Context) error {
	config, err := c.service.Get(ctx.Request().Context())
	if err != nil {
		return ctx.JSON(err.StatusCode, err.Msg)
	}

	return ctx.JSON(http.StatusOK, config)
}

// Put updates the configuration.
func (c *Controller) Put(ctx echo.Context) error {
	config := &Config{}
	if err := ctx.Bind(config); err != nil {
		return err
	}

	if err := c.service.Put(ctx.Request().Context(), config); err != nil {
		return ctx.JSON(err.StatusCode, err.Msg)
	}

	return ctx.NoContent(http.StatusOK)
}
