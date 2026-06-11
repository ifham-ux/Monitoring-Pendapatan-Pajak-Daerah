# Monitoring Pendapatan Pajak Daerah (PBB)

Mobile Executive Dashboard untuk monitoring realisasi Pajak Bumi dan Bangunan (PBB) berbasis Flutter yang terintegrasi dengan sistem SimPBB melalui backend Go dan protokol oRPC.

---

## Deskripsi Proyek

Badan Pendapatan Daerah (Bapenda) membutuhkan sarana pemantauan realisasi Pajak Bumi dan Bangunan (PBB) yang dapat diakses secara fleksibel melalui perangkat mobile.

Aplikasi ini dikembangkan sebagai **Mobile Dashboard Eksekutif** yang memungkinkan pimpinan memantau capaian penerimaan daerah secara real-time melalui visualisasi data, pemetaan wilayah, monitoring aktivitas lapangan, simulasi kebijakan tarif, serta notifikasi kinerja wilayah.

---

## Tim Pengembang

| Nama                   | NIM                 |
| ---------------------- | ------------------- |
| M. Dafa ‘Izzul Iman A. | 24/535342/PA/22711  |
| Hegel Al Rafli         | 25/575250/NPA/20024 |
| Ifham Syafwan Fikri    | 24/545184/PA/23161  |

---

## Fitur Utama

### Executive Dashboard

* KPI Realisasi PBB
* Target Pendapatan
* Persentase Capaian
* Tren Pendapatan

### GIS Monitoring

* Visualisasi wilayah berbasis peta
* Monitoring kecamatan dan kelurahan
* Indikator performa wilayah

### Field Monitoring

* Monitoring aktivitas petugas lapangan
* Rekap survei objek pajak
* Rekap pembaruan data NJOP

### Push Notification

* Pengiriman notifikasi manual
* Alert wilayah dengan performa rendah

### Kalkulator Tarif

* Simulasi perubahan tarif
* Proyeksi Pendapatan Asli Daerah (PAD)

### Local Caching

* Hive Database
* Offline data access
* Faster loading experience

---

## Arsitektur Sistem

```text
┌─────────────────┐
│ Flutter Mobile  │
│    Client App   │
└────────┬────────┘
         │ oRPC
         ▼
┌─────────────────┐
│   Go Backend    │
│ Integration API │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ SimPBB (Traxia) │
│ External System │
└─────────────────┘
```

---

## Teknologi yang Digunakan

### Frontend

* Flutter SDK 3.22+
* Dart SDK 3.x

### Backend

* Golang
* oRPC Protocol

### Database & Storage

* Hive Database

### Development Tools

* Visual Studio Code
* Git
* GitHub
* Postman

### Deployment

* Vercel

---

## Screenshot Aplikasi

### Login Page

![Login](docs/images/login.jpeg)

### Dashboard

![Dashboard](docs/images/dashboard.jpeg)

### Activity Monitoring

![Activity](docs/images/activity1.jpeg)

### GIS & Monitoring

![Overdue](docs/images/overdue.jpeg)

---

## Video Demonstrasi

Video demonstrasi menampilkan:

* Login aplikasi
* Dashboard KPI
* GIS Monitoring
* Activity Monitoring
* Push Notification
* Kalkulator Tarif
* Caching menggunakan Hive

### Link Video

> 🚧 Placeholder – akan diperbarui setelah video final tersedia

```text
https://youtu.be/VIDEO_DEMO_FINAL
```

---

## Struktur Repository

```text
lib/
├── Views/
│   ├── login/
│   ├── dashboard/
│   ├── activity/
│   ├── overdue/
│   ├── calculator/
│   └── settings/
│
├── services/
│   ├── api_service.dart
│   ├── notification_service.dart
│   └── hive_service.dart
│
├── models/
├── widgets/
└── main.dart
```

---

## Development Branches

### version-1

* Login Page
* API Fetching Experiment
* Frontend Prototype

### version-2

* Dashboard Development
* Main Feature Integration

### version-3

* Backend Integration
* Deployment to Vercel
* Project Refactoring

### version-4

* Hive Local Storage
* Performance Optimization
* Final Stabilization

---

## Pengujian

### Functional Testing

| ID    | Feature            | Status |
| ----- | ------------------ | ------ |
| FR-01 | Login              | ✅      |
| FR-02 | Dashboard          | ✅      |
| FR-03 | GIS Monitoring     | ✅      |
| FR-04 | Field Monitoring   | ✅      |
| FR-05 | Push Notification  | ✅      |
| FR-06 | Tariff Simulation  | ✅      |
| FR-07 | Profile & Settings | ✅      |

### Non Functional Testing

| Test Case            | Result |
| -------------------- | ------ |
| Dashboard Loading    | 1.65 s |
| GIS Loading          | 2.38 s |
| Data Synchronization | 100%   |
| Hive Cache Retrieval | < 1 s  |

---

## Dokumentasi Pendukung

### UX Board

https://www.figma.com/board/wPwlUSJGc211bsj14YV46V/UX-Monitoring-Pendapatan-Pajak-Daerah

### UI Design

https://www.figma.com/design/TwDCYzXnWOPllBSjJ2pFtA/UI-Monitoring-Pendapatan-Pajak-Daerah

---

## Cara Menjalankan Project

```bash
git clone https://github.com/ifham-ux/Monitoring-Pendapatan-Pajak-Daerah.git

cd Monitoring-Pendapatan-Pajak-Daerah

flutter pub get

flutter run
```

---

