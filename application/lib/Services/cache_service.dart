import 'dart:convert';
import 'dart:developer' as developer;

import 'package:hive_flutter/hive_flutter.dart';

// ─────────────────────────────────────────────────────────────────────────────
// CacheService
//
// Singleton berbasis Hive yang menyimpan hasil API call per halaman/parameter.
// Strategi: "stale-while-revalidate" sederhana — data dikembalikan dari cache
// jika TTL belum habis; jika sudah/tidak ada, fetch ulang dan simpan lagi.
//
// Cara pakai di service layer:
//   final data = await CacheService.getOrFetch<Map<String,dynamic>>(
//     key: 'dashboard_2025',
//     fromJson: (j) => j as Map<String,dynamic>,
//     toJson: (d) => d,
//     fetch: () => DashboardService.loadDashboardData(2025),
//   );
// ─────────────────────────────────────────────────────────────────────────────
class CacheService {
  CacheService._();

  static const String _boxName = 'app_cache';
  static const String _tsBoxName = 'app_cache_ts'; // timestamps

  static late Box<String> _box;
  static late Box<int> _tsBox;

  static bool _initialized = false;

  // ── Inisialisasi — panggil sekali di main() setelah Hive.initFlutter() ────
  static Future<void> initialize() async {
    if (_initialized) return;
    await Hive.initFlutter();
    _box = await Hive.openBox<String>(_boxName);
    _tsBox = await Hive.openBox<int>(_tsBoxName);
    _initialized = true;
    developer.log(' [Cache] Hive cache diinisialisasi.', name: 'CacheService');
  }

  // ── Core: ambil dari cache atau fetch baru ─────────────────────────────────
  //
  // [key]      — kunci unik, sertakan parameter yang membedakan (misal tahun, kdKecamatan)
  // [fetch]    — fungsi async yang memanggil API
  // [toJson]   — konversi T → Object JSON-serializable (Map/List/primitive)
  // [fromJson] — konversi Object JSON → T
  // [ttl]      — opsional, durasi kedaluwarsa cache (null = tidak pernah expired dalam satu sesi)
  // [forceRefresh] — paksa fetch ulang meski cache masih valid
  // ─────────────────────────────────────────────────────────────────────────
  static Future<T> getOrFetch<T>({
    required String key,
    required Future<T> Function() fetch,
    required Object? Function(T data) toJson,
    required T Function(Object? json) fromJson,
    Duration? ttl,
    bool forceRefresh = false,
  }) async {
    assert(
      _initialized,
      'CacheService.initialize() belum dipanggil di main()!',
    );

    // Cek apakah cache ada dan masih valid
    if (!forceRefresh && _box.containsKey(key)) {
      final bool isExpired = _isExpired(key, ttl);

      if (!isExpired) {
        developer.log('[Cache] HIT: $key', name: 'CacheService');
        try {
          final jsonStr = _box.get(key)!;
          final decoded = jsonDecode(jsonStr);
          return fromJson(decoded);
        } catch (e) {
          developer.log(
            ' [Cache] Gagal decode cache "$key": $e — fetch ulang.',
            name: 'CacheService',
          );
          // Jatuh ke fetch ulang di bawah
        }
      } else {
        developer.log(' [Cache] EXPIRED: $key', name: 'CacheService');
      }
    } else {
      developer.log('[Cache] MISS: $key', name: 'CacheService');
    }

    // Fetch dari network
    final data = await fetch();

    // Simpan ke cache
    try {
      final encoded = jsonEncode(toJson(data));
      await _box.put(key, encoded);
      await _tsBox.put(key, DateTime.now().millisecondsSinceEpoch);
      developer.log(' [Cache] SAVED: $key', name: 'CacheService');
    } catch (e) {
      developer.log(
        '[Cache] Gagal menyimpan cache "$key": $e',
        name: 'CacheService',
      );
    }

    return data;
  }

  // ── Hapus satu entry ───────────────────────────────────────────────────────
  static Future<void> invalidate(String key) async {
    await _box.delete(key);
    await _tsBox.delete(key);
    developer.log('[Cache] Invalidated: $key', name: 'CacheService');
  }

  // ── Hapus semua cache (misal saat logout) ─────────────────────────────────
  static Future<void> clearAll() async {
    await _box.clear();
    await _tsBox.clear();
    developer.log('[Cache] Semua cache dihapus.', name: 'CacheService');
  }

  // ── Hapus cache dengan prefix tertentu (misal semua cache tahun 2025) ─────
  static Future<void> invalidatePrefix(String prefix) async {
    final keysToDelete = _box.keys
        .whereType<String>()
        .where((k) => k.startsWith(prefix))
        .toList();

    for (final k in keysToDelete) {
      await _box.delete(k);
      await _tsBox.delete(k);
    }
    developer.log(
      '[Cache] Invalidated prefix "$prefix": ${keysToDelete.length} entry.',
      name: 'CacheService',
    );
  }

  // ── Cek apakah key sudah expired ──────────────────────────────────────────
  static bool _isExpired(String key, Duration? ttl) {
    if (ttl == null) return false; // tanpa TTL = tidak pernah expired

    final ts = _tsBox.get(key);
    if (ts == null) return true;

    final savedAt = DateTime.fromMillisecondsSinceEpoch(ts);
    return DateTime.now().difference(savedAt) > ttl;
  }

  // ── Cek apakah cache ada (tanpa membaca nilainya) ─────────────────────────
  static bool has(String key) => _box.containsKey(key);
}
