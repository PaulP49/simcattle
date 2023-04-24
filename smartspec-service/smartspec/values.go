package smartspec

// Indicates if Scenario-Learning is currently in progress.
var learnInProgress = false

// Indicates if Scenario-Generation is currently in progress.
var genInProgress = false

const servicePath = "/app/smartspec"
const dataPath = servicePath + "/data"
const outputPath = dataPath + "/output"

const learnPaths = `
[filepaths]
spaces     = data/Spaces.json
metaevents = data/output/MetaEvents.json
metapeople = data/output/MetaPeople.json
people     = data/output/People.json
events     = data/output/Events.json
plots      = data/output/plots`

const genPaths = `
[filepaths]
spaces          = data/Spaces.json
metasensors     = data/MetaSensors.json
sensors         = data/Sensors.json
metapeople      = data/output/MetaPeople.json
metaevents      = data/output/MetaEvents.json
people          = data/output/People.json
events          = data/output/Events.json
output          = data/output/
generated-files = data/output/
path-cache      = data/output/path-cache.csv`

// Possible Stati of Scenario-Learning and Scenario-Generation
const (
	statusNotStarted = "NOT_STARTED"
	statusInProgress = "IN_PROGRESS"
	statusCompleted  = "COMPLETED"
	statusFailed     = "FAILED"
)

const dateTimeFormat = "2006-01-02 15:04:05"

// Indices in data.csv
const (
	idxCattleID  = 0
	idxSpaceID   = 2
	idxStartTime = 3
	idxEndTime   = 4
)

const jqFilterTemplate = ".[] | select(.id == %s) | .geoCoordinates | .[0:2]"
