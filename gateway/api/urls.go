package api

import "fmt"

var (
	smartspecService     = getUrl("smartspec-service", 8090)
	configurationService = getUrl("configuration-service", 8091)
	locationService      = getUrl("location-service", 8092)
	webUI                = getUrl("web-ui", 3000)
)

// getUrl returns the url of a service running at a specific port.
func getUrl(service string, port int) string {
	return fmt.Sprintf("http://%s:%d", service, port)
}
