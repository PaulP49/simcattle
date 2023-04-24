package api

import (
	"simcattle/configuration-service/configuration"

	"github.com/labstack/echo/v4"
)

// setRoutes sets the available routes for the endpoints of the service.
func setRoutes(router *echo.Echo) {
	controller := configuration.NewController()

	api := router.Group("/api")

	configuration := api.Group("/configuration")
	configuration.GET("", controller.Get)
	configuration.PUT("", controller.Put)
}
