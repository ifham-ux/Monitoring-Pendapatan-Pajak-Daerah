package main

import (
	"backend/handlers"
	"log"
	"net/http"
)

func main() {
	http.HandleFunc("/wilayah/listKecamatan", handlers.GetKecamatan)
	http.HandleFunc("/wilayah/listKelurahan", handlers.GetKelurahan)
	http.HandleFunc("/sppt/list", handlers.GetSPPT)
	http.HandleFunc("/sppt/get", handlers.GetTahunSPPT)
	http.HandleFunc("/objekPajak/getHistory", handlers.GetSPPTHistory)
	http.HandleFunc("/objekPajak/getbyNop", handlers.GetByNop)
	http.HandleFunc("/objekPajak/listDetails", handlers.GetListDetails)

	log.Println("Server is running on :8080")
	log.Fatal(http.ListenAndServe(":8080", nil))
}
