package smartspec

import "time"

// Config holds the SmartSPEC configuration.
type Config struct {
	ID          int
	Sensors     string
	Spaces      string
	Metasensors string
	LearnConf   string
	GenConf     string
}

func (Config) TableName() string {
	return "smartspec_conf"
}

// Location holds the result of the Scenario-Generation, which are locations.
type Location struct {
	CattleID  string
	Latitude  float64
	Longitude float64
	SpaceID   string
	StartTime *time.Time
	EndTime   *time.Time
}

func (Location) TableName() string {
	return "location"
}

// Coordinates hold latitude and longitude.
type Coordinates struct {
	Latitude  float64
	Longitude float64
}
