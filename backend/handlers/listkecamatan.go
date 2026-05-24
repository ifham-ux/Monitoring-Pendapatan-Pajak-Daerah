package handlers

import (
	"bytes"
	"encoding/json"
	"io"
	"net/http"
)

type KecamatanRequesetBody struct {
	Json struct {
		KdPropinsi string `json:"kdPropinsi"`
		KdDati2    string `json:"kdDati2"`
	} `json:"json"`
}

func GetKecamatan(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Access-Control-Allow-Origin", "*")
	w.Header().Set("Access-Control-Allow-Methods", "POST, OPTIONS")
	w.Header().Set("Access-Control-Allow-Headers", "Content-Type")

	if r.Method == http.MethodOptions {
		w.WriteHeader(http.StatusOK)
		return
	}

	if r.Method != http.MethodPost {
		http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
		return
	}

	var reqBody KecamatanRequesetBody
	if err := json.NewDecoder(r.Body).Decode(&reqBody); err != nil {
		http.Error(w, "Invalid request body", http.StatusBadRequest)
		return
	}

	payload := map[string]interface{}{
		"json": map[string]string{
			"kdPropinsi": reqBody.Json.KdPropinsi,
			"kdDati2":    reqBody.Json.KdDati2,
		},
	}

	jsonData, err := json.Marshal(payload)
	if err != nil {
		http.Error(w, "Could not marshal request", http.StatusInternalServerError)
		return
	}

	resp, err := http.Post(
		"https://simpbb.technosmart.id/api/rpc/wilayah/listKecamatan",
		"application/json",
		bytes.NewBuffer(jsonData),
	)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	defer resp.Body.Close()

	body, err := io.ReadAll(resp.Body)
	if err != nil {
		http.Error(w, "Failed to read response", http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	w.Write(body)
}
