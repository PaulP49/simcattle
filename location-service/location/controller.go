package location

import (
	"net/http"

	"github.com/labstack/echo/v4"
)

// The Controller handles all API requests related to locations.
type Controller struct {
	service Service
}

// NewController creates a new Controller.
func NewController() *Controller {
	return &Controller{
		service: NewService(),
	}
}

// Get gets the locations between two points in time.
func (c *Controller) Get(ctx echo.Context) error {
	req := &GetRequest{}
	if err := ctx.Bind(req); err != nil {
		return err
	}

	locations, err := c.service.Get(ctx.Request().Context(), req)
	if err != nil {
		return ctx.JSON(err.StatusCode, err.Msg)
	}

	return ctx.JSON(http.StatusOK, locations)
}
