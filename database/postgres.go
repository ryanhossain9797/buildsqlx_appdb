package database

import (
	_ "database/sql"
	"fmt"
	"os"

	"github.com/arthurkushman/buildsqlx"
	"github.com/joho/godotenv"
	_ "github.com/lib/pq"
)

//Sample database credentials
//DB_CRED_SQLX = 'user=dbusername dbname=name_of_db password=dbpassword sslmode=disable'

var db *buildsqlx.DB

const DriverName = "postgres"

func init() {
	err := godotenv.Load()
	if err != nil {
		panic("err loading env")
	}
	DataSourceSqlx := os.Getenv("DB_CRED_SQLX")
	fmt.Println(DataSourceSqlx)
	db = buildsqlx.NewDb(buildsqlx.NewConnection(DriverName, DataSourceSqlx))
}

func DBUp() {
	//--------TEST TABLE
	_, err := db.Schema("public.test", func(table *buildsqlx.Table) {
		table.String("id", 128).NotNull().Unique("test_pkey")
		table.String("tp_id", 128).NotNull()
		table.String("time", 128).NotNull().Default("0")

	})
	if err != nil {
		fmt.Println(err.Error())
	}

	//--------QUESTION TABLE
	_, err = db.Schema("public.question", func(table *buildsqlx.Table) {
		table.BigInt("id").NotNull().Unique("question_pkey")
		table.String("title", 128).NotNull()
		table.String("test_id", 128).NotNull().ForeignKey("fkey_test_id_of_question", "public.test", "id")
		table.Integer("answer").NotNull()
	})
	if err != nil {
		fmt.Println(err.Error())
	}

	//--------USER TABLE
	_, err = db.Schema("public.user", func(table *buildsqlx.Table) {
		table.BigInt("id").NotNull().Unique("user_pkey")
		table.String("name", 128)
	})
	if err != nil {
		fmt.Println(err.Error())
	}

	//--------TESTSESSION TABLE
	_, err = db.Schema("public.testsession", func(table *buildsqlx.Table) {
		table.String("id", 128).NotNull().Unique("testsession_pkey")
		table.String("test_id", 128).NotNull().ForeignKey("fkey_test_id_of_test_session", "public.test", "id")
		table.String("topic_id", 128) //.ForeignKey("fkey_topic_id_of_test_session", "public.topic", "id")
		table.BigInt("uid").NotNull().ForeignKey("fkey_user_id_of_test_session", "public.user", "id")
		table.Integer("score").NotNull()
	})
	if err != nil {
		fmt.Println(err.Error())
	}

}
