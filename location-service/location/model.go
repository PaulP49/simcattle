package location

import "time"

// GetRequest is used to handle a get request.
type GetRequest struct {
	StartTime int64 `query:"start"`
	EndTime   int64 `query:"end"`
}

// Location holds the result of the Scenario-Generation, which are locations.
type Location struct {
	CattleID  string     `json:"cattleID"`
	Latitude  float64    `json:"latitude"`
	Longitude float64    `json:"longitude"`
	SpaceID   string     `json:"spaceID"`
	StartTime *time.Time `json:"startTime"`
	EndTime   *time.Time `json:"endTime"`
}

func (Location) TableName() string {
	return "location"
}
