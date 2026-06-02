package handler

import (
	"backend/handlers"
	"net/http"
)

func Handler(w http.ResponseWriter, r *http.Request) {

	switch r.URL.Path {

	case "/sppt/list":
		handlers.GetSPPT(w, r)

	case "/sppt/get":
		handlers.GetTahunSPPT(w, r)

	case "/objekPajak/listDetails":
		handlers.GetListDetails(w, r)

	case "/objekPajak/getSpptHistory":
		handlers.GetSPPTHistory(w, r)

	case "/objekPajak/getByNop":
		handlers.GetByNop(w, r)

	case "/wilayah/listDati2":
		handlers.GetDati2(w, r)

	case "/wilayah/listKecamatan":
		handlers.GetKecamatan(w, r)

	case "/wilayah/listKelurahan":
		handlers.GetKelurahan(w, r)

	default:
		http.NotFound(w, r)
	}
}
