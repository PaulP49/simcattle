package configuration

// Config holds the SmartSPEC configuration.
type Config struct {
	Sensors     *string `json:"sensors"`
	Spaces      *string `json:"spaces"`
	Metasensors *string `json:"metasensors"`
	LearnConf   *string `json:"learnConf"`
	GenConf     *string `json:"genConf"`
}

func (Config) TableName() string {
	return "smartspec_conf"
}
