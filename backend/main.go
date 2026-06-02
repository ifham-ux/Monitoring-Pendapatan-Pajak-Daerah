package main

import (
	"backend/handlers"
	"log"
	"net/http"
	"os"
)

func main() {

	http.HandleFunc("/objekPajak/listDetails", handlers.GetListDetails)
	http.HandleFunc("/objekPajak/getSpptHistory", handlers.GetSPPTHistory)
	http.HandleFunc("/objekPajak/getByNop", handlers.GetByNop)

	http.HandleFunc("/wilayah/listDati2", handlers.GetDati2)
	http.HandleFunc("/wilayah/listKecamatan", handlers.GetKecamatan)
	http.HandleFunc("/wilayah/listKelurahan", handlers.GetKelurahan)

	http.HandleFunc("/sppt/list", handlers.GetSPPT)
	http.HandleFunc("/sppt/get", handlers.GetTahunSPPT)

	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}

	log.Printf("Server is running on :%s", port)
	log.Fatal(http.ListenAndServe(":"+port, nil))

}
