package smartspec

import (
	"net/http"

	"github.com/labstack/echo/v4"
)

// The Controller handles all API request related to SmartSPEC.
type Controller struct {
	service Service
}

// NewController creates a new Controller.
func NewController() *Controller {
	return &Controller{
		service: NewService(),
	}
}

// Learn executes the SmartSPEC scenario-learning component to create internal
// data for the scenario-generation component.
func (c *Controller) Learn(ctx echo.Context) error {
	if err := c.service.Learn(ctx.Request().Context()); err != nil {
		return ctx.JSON(err.StatusCode, err.Msg)
	}

	return ctx.JSON(http.StatusAccepted, "Scenario-Learning started.")
}

// Generate executes the SmartSPEC scenario-generation component to generate new
// location data based on learned data.
func (c *Controller) Generate(ctx echo.Context) error {
	if err := c.service.Generate(ctx.Request().Context()); err != nil {
		return ctx.JSON(err.StatusCode, err.Msg)
	}

	return ctx.JSON(http.StatusOK, "Scenario-Generation started.")
}

// LearningStatus returns the status of the Scenario-Learning execution.
func (c *Controller) LearningStatus(ctx echo.Context) error {
	status, err := c.service.LearningStatus(ctx.Request().Context())
	if err != nil {
		return ctx.JSON(err.StatusCode, err.Msg)
	}

	return ctx.JSON(http.StatusOK, status)
}

// GenerationStatus returns the status of the Scenario-Generation execution.
func (c *Controller) GenerationStatus(ctx echo.Context) error {
	status, err := c.service.GenerationStatus(ctx.Request().Context())
	if err != nil {
		return ctx.JSON(err.StatusCode, err.Msg)
	}

	return ctx.JSON(http.StatusOK, status)
}

// GenerationPersist persists the Scenario-Generation result.
func (c *Controller) GenerationPersist(ctx echo.Context) error {
	err := c.service.GenerationPersist(ctx.Request().Context())
	if err != nil {
		return ctx.JSON(err.StatusCode, err.Msg)
	}

	return ctx.NoContent(http.StatusOK)
}
