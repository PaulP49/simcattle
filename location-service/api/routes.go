package api

import (
	"simcattle/location-service/location"

	"github.com/labstack/echo/v4"
)

// setRoutes sets the available routes for the endpoints of the service.
func setRoutes(router *echo.Echo) {
	controller := location.NewController()

	api := router.Group("/api")

	locations := api.Group("/locations")
	locations.GET("", controller.Get)
}
