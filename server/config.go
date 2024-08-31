package main

import (
	"os"
	"time"

	"github.com/gookit/config/v2"
	"github.com/gookit/config/v2/yaml"
	"github.com/rs/zerolog"
	"github.com/rs/zerolog/log"
)

var appConfig AppConfig

type Redis struct {
	Address string `mapstructure:"address" default:"localhost:6379"`
	Auth    string `mapstructure:"auth"`
}

type Server struct {
	Address string `mapstructure:"address" default:":50051"`
}

type Limit struct {
	MaxMessageInGetRequest int `mapstructure:"maxMessageInGetRequest" default:"50"`
}

type Token struct {
	JWTSecret  string        `mapstructure:"jwtSecret"`
	Expiration time.Duration `mapstructure:"expiration"`
}

type Log struct {
	Level string `mapstructure:"level" default:"trace"`
}
type AppConfig struct {
	Redis  Redis  `mapstructure:"redis"`
	Token  Token  `mapstructure:"token"`
	Limit  Limit  `mapstructure:"limit"`
	Server Server `mapstructure:"server"`
	Log    Log    `mapstructure:"log"`
}

func parseConfig() *AppConfig {
	// config.ParseEnv: will parse env var in string value. eg: shell: ${SHELL}
	config.WithOptions(config.ParseEnv, config.ParseTime, config.ParseDefault)

	// add driver for support yaml content
	config.AddDriver(yaml.Driver)

	err := config.LoadFiles("config.yaml")
	if err != nil {
		panic(err)
	}

	c := AppConfig{}
	err = config.Decode(&c)

	if err != nil {
		panic(err)
	}

	log.Logger = log.Output(zerolog.ConsoleWriter{Out: os.Stderr})

	level, err := zerolog.ParseLevel(c.Log.Level)

	if err != nil {
		log.Fatal().Err(err).Msg("unable to parse log level")
	}

	zerolog.SetGlobalLevel(level)

	log.Trace().Msgf("CONFIG: %+v", c)

	appConfig = c

	return &c

}
