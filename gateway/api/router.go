package api

import (
	"context"
	"errors"
	"net/http"
	"os"
	"os/signal"
	"strconv"
	"syscall"
	"time"

	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
	"github.com/labstack/gommon/log"
)

const port = 8080
const serviceName = "gateway"

// Run starts the service.
func Run() {
	router := echo.New()
	router.HideBanner = true

	router.Pre(middleware.RemoveTrailingSlash())
	router.Use(middleware.Recover())

	corsConfig := middleware.DefaultCORSConfig
	router.Use(middleware.CORSWithConfig(corsConfig))

	setRoutes(router)

	StartRouter(router)
}

// StartRouter starts the http server in the background and handles the
// shutdown.
func StartRouter(router *echo.Echo) {
	log.Infof("Starting gateway on port %d.", port)

	go func() {
		if err := router.Start(":" + strconv.Itoa(port)); err != nil && !errors.Is(err, http.ErrServerClosed) {
			log.Fatalf("Shutting down gateway: %s", err.Error())
		}
	}()

	done := make(chan os.Signal, 1)
	signal.Notify(done, syscall.SIGINT, syscall.SIGTERM, syscall.SIGQUIT, syscall.SIGABRT, os.Interrupt)
	<-done

	log.Infof("Gracefully shutting down gateway")
	ctx, cancel := context.WithTimeout(context.Background(), time.Minute)
	defer cancel()

	if err := router.Shutdown(ctx); err != nil {
		log.Fatal(err)
	}
}
