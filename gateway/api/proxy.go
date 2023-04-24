package api

import (
	"net/http/httputil"
	"net/url"

	"github.com/labstack/echo/v4"
)

// proxy creates a reverse proxy to a destined url in the docker cluster.
func proxy(rawUrl string) echo.HandlerFunc {
	url, err := url.Parse(rawUrl)
	if err != nil {
		return func(echo.Context) error {
			return err
		}
	}

	proxy := httputil.NewSingleHostReverseProxy(url)

	return func(ctx echo.Context) error {
		proxy.ServeHTTP(ctx.Response(), ctx.Request())
		return nil
	}
}