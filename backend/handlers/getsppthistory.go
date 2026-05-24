package handlers

import (
	"bytes"
	"encoding/json"
	"io"
	"net/http"
)

type GetSPPTHistoryRequestBody struct {
	Json struct {
		KdPropinsi  string `json:"kdPropinsi"`
		KdDati2     string `json:"kdDati2"`
		KdKecamatan string `json:"kdKecamatan"`
		KdKelurahan string `json:"kdKelurahan"`
		KdBlok      string `json:"kdBlok"`
		NoUrut      string `json:"noUrut"`
		KdJnsOp     string `json:"kdJnsOp"`
	} `json:"json"`
}

func GetSPPTHistory(w http.ResponseWriter, r *http.Request) {
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

	var reqBody GetSPPTHistoryRequestBody

	if err := json.NewDecoder(r.Body).Decode(&reqBody); err != nil {
		http.Error(w, "Invalid request body", http.StatusBadRequest)
		return
	}

	payload := map[string]interface{}{
		"json": map[string]interface{}{
			"kdPropinsi":  reqBody.Json.KdPropinsi,
			"kdDati2":     reqBody.Json.KdDati2,
			"kdKecamatan": reqBody.Json.KdKecamatan,
			"kdKelurahan": reqBody.Json.KdKelurahan,
			"kdBlok":      reqBody.Json.KdBlok,
			"noUrut":      reqBody.Json.NoUrut,
			"kdJnsOp":     reqBody.Json.KdJnsOp,
		},
	}

	jsonData, err := json.Marshal(payload)
	if err != nil {
		http.Error(w, "Failed to marshal request", http.StatusInternalServerError)
		return
	}

	resp, err := http.Post(
		"https://simpbb.technosmart.id/api/rpc/objekPajak/getSpptHistory",
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
