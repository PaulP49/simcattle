package api

import (
	"github.com/labstack/echo/v4"
)

// setRoutes sets the routes to the services endpoints.
func setRoutes(router *echo.Echo) {
	api := router.Group("/api")

	learning := api.Group("/learning")
	learning.POST("/start", proxy(smartspecService))
	learning.GET("/status", proxy(smartspecService))

	generation := api.Group("/generation")
	generation.POST("/start", proxy(smartspecService))
	generation.GET("/status", proxy(smartspecService))
	generation.POST("/persist", proxy(smartspecService))

	configuration := api.Group("/configuration")
	configuration.GET("", proxy(configurationService))
	configuration.PUT("", proxy(configurationService))

	locations := api.Group("/locations")
	locations.GET("", proxy(locationService))

	router.GET("/*", proxy(webUI))
}
