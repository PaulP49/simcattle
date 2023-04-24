package db

import (
	"database/sql"
	"fmt"
	"log"
	"os"
	"time"

	"gorm.io/driver/mysql"
	"gorm.io/gorm"
)

var DB *gorm.DB

// Connect establishes a connection to the MySQL database.
func Connect() error {
	host, _ := os.LookupEnv("MYSQL_HOST")
	database, _ := os.LookupEnv("MYSQL_DATABASE")
	user, _ := os.LookupEnv("MYSQL_USER")
	password, _ := os.LookupEnv("MYSQL_PASSWORD")

	connData := fmt.Sprintf("%s:%s@(%s)/%s", user, password, host, database+"?parseTime=true")

	db, err := sql.Open("mysql", connData)
	if err != nil {
		log.Fatalf("Could not connect to mysql: %s", err.Error())
		return err
	}

	waitForDB(db)

	DB, err = gorm.Open(
		mysql.New(mysql.Config{Conn: db}),
		&gorm.Config{},
	)
	if err != nil {
		log.Fatalf("Could not connect to mysql: %s", err.Error())
		return err
	}

	return nil
}

// waitForDB is used to wait for the database to be available before starting
// the service.
func waitForDB(db *sql.DB) {
	for retries := 30; retries >= 0; retries-- {
		err := db.Ping()
		if err != nil {
			if retries == 0 {
				log.Fatal("Could not connect to mysql")
			}

			log.Printf("Could not connect to mysql: %d retries left.", retries)
			time.Sleep(time.Second * 2)

			continue
		}

		break
	}
}
