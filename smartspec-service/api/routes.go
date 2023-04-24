package api

import (
	"simcattle/smartspec-service/smartspec"

	"github.com/labstack/echo/v4"
)

// setRoutes sets the available routes for the endpoints of the service.
func setRoutes(router *echo.Echo) {
	controller := smartspec.NewController()

	api := router.Group("/api")

	learning := api.Group("/learning")
	learning.POST("/start", controller.Learn)
	learning.GET("/status", controller.LearningStatus)

	generation := api.Group("/generation")
	generation.POST("/start", controller.Generate)
	generation.GET("/status", controller.GenerationStatus)
	generation.POST("/persist", controller.GenerationPersist)
}
