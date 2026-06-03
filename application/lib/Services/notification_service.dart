import 'dart:developer' as developer;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Model: item history notifikasi
// ─────────────────────────────────────────────────────────────────────────────
class NotificationHistoryItem {
  final String? messageId;
  final String title;
  final String body;
  final Map<String, dynamic> data;
  final DateTime receivedAt;
  final NotificationSource source;
  bool isRead;

  NotificationHistoryItem({
    this.messageId,
    required this.title,
    required this.body,
    required this.data,
    required this.receivedAt,
    required this.source,
    this.isRead = false,
  });
}

/// Sumber dari mana notifikasi diterima.
enum NotificationSource { foreground, background, terminated }

// ─────────────────────────────────────────────────────────────────────────────
// Background message handler (harus top-level function, bukan method class)
// Dipanggil ketika aplikasi berada di background atau terminated.
// ─────────────────────────────────────────────────────────────────────────────
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  developer.log(
    '[FCM] Background/Terminated message diterima',
    name: 'NotificationService',
  );
  developer.log(
    '  ▸ Message ID : ${message.messageId}',
    name: 'NotificationService',
  );
  developer.log(
    '  ▸ Title      : ${message.notification?.title ?? "-"}',
    name: 'NotificationService',
  );
  developer.log(
    '  ▸ Body       : ${message.notification?.body ?? "-"}',
    name: 'NotificationService',
  );
  developer.log(
    '  ▸ Data       : ${message.data}',
    name: 'NotificationService',
  );

  // Simpan ke history saat background (instance sudah aktif di isolate baru).
  NotificationService.instance._addToHistory(
    message,
    NotificationSource.background,
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// NotificationService
// ─────────────────────────────────────────────────────────────────────────────
class NotificationService {
  NotificationService._(); // Private constructor — gunakan sebagai singleton.

  static final NotificationService instance = NotificationService._();

  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  /// Channel ID untuk notifikasi lokal di Android.
  static const String _channelId = 'fcm_high_importance';
  static const String _channelName = 'Notifikasi Penting';
  static const String _channelDesc =
      'Channel untuk notifikasi Firebase Cloud Messaging';

  /// FCM token saat ini (nullable sampai berhasil diambil).
  String? _fcmToken;
  String? get fcmToken => _fcmToken;

  // ───────────────────────────── HISTORY ─────────────────────────────────────

  /// List history notifikasi yang diterima selama session ini.
  /// UI dapat listen perubahan via [historyNotifier].
  final List<NotificationHistoryItem> _history = [];

  List<NotificationHistoryItem> get history =>
      List.unmodifiable(_history.reversed.toList());

  /// ValueNotifier untuk trigger rebuild UI saat ada notif baru.
  final ValueNotifier<int> historyNotifier = ValueNotifier(0);

  /// Jumlah notifikasi yang belum dibaca.
  int get unreadCount => _history.where((n) => !n.isRead).length;

  /// Tandai semua notifikasi sebagai sudah dibaca.
  void markAllAsRead() {
    for (final item in _history) {
      item.isRead = true;
    }
    historyNotifier.value++;
  }

  /// Tandai satu notifikasi sebagai sudah dibaca berdasarkan index.
  void markAsRead(int index) {
    final reversedList = _history.reversed.toList();
    if (index < reversedList.length) {
      reversedList[index].isRead = true;
      historyNotifier.value++;
    }
  }

  /// Hapus semua history notifikasi.
  void clearHistory() {
    _history.clear();
    historyNotifier.value++;
  }

  /// Internal: tambah item ke history dan notifikasi listener.
  void _addToHistory(RemoteMessage message, NotificationSource source) {
    _history.add(
      NotificationHistoryItem(
        messageId: message.messageId,
        title: message.notification?.title ?? '(Tanpa Judul)',
        body: message.notification?.body ?? '(Tanpa Isi)',
        data: Map<String, dynamic>.from(message.data),
        receivedAt: message.sentTime ?? DateTime.now(),
        source: source,
      ),
    );
    historyNotifier.value++;
    developer.log(
      ' [FCM] Ditambahkan ke history (total: ${_history.length})',
      name: 'NotificationService',
    );
  }

  // ───────────────────────────── PUBLIC API ──────────────────────────────────

  /// Inisialisasi lengkap: permission + local notifications + FCM handlers.
  /// Panggil sekali pada `main()` setelah `Firebase.initializeApp()`.
  static Future<void> initialize() async {
    await instance._init();
  }

  /// Paksa refresh FCM token (misalnya setelah login ulang).
  Future<void> refreshToken() async {
    developer.log(
      ' [FCM] Meminta refresh token...',
      name: 'NotificationService',
    );
    await _messaging.deleteToken();
    _fcmToken = await _messaging.getToken();
    developer.log(' [FCM] Token baru: $_fcmToken', name: 'NotificationService');
  }

  // ──────────────────────────── PRIVATE INIT ─────────────────────────────────

  Future<void> _init() async {
    await _requestPermission();
    await _initLocalNotifications();
    await _fetchAndStoreToken();
    _registerFCMHandlers();
  }

  /// Minta izin notifikasi (Android 13+ / iOS).
  Future<void> _requestPermission() async {
    final NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    developer.log(
      ' [FCM] Status izin notifikasi: ${settings.authorizationStatus.name}',
      name: 'NotificationService',
    );

    if (settings.authorizationStatus == AuthorizationStatus.denied) {
      developer.log(
        ' [FCM] Izin notifikasi ditolak oleh pengguna.',
        name: 'NotificationService',
      );
    }
  }

  /// Setup flutter_local_notifications (channel Android + handler iOS).
  Future<void> _initLocalNotifications() async {
    // Android: buat high-importance channel agar heads-up notification muncul.
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      _channelId,
      _channelName,
      description: _channelDesc,
      importance: Importance.high,
      playSound: true,
      enableVibration: true,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);

    // Inisialisasi plugin untuk masing-masing platform.
    const InitializationSettings initSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: false, // sudah diminta via firebase_messaging
        requestBadgePermission: false,
        requestSoundPermission: false,
      ),
    );

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTap,
      onDidReceiveBackgroundNotificationResponse: _onBackgroundNotificationTap,
    );

    developer.log(
      '[FCM] LocalNotifications berhasil diinisialisasi.',
      name: 'NotificationService',
    );
  }

  /// Ambil FCM token dan simpan ke state internal.
  Future<void> _fetchAndStoreToken() async {
    try {
      _fcmToken = await _messaging.getToken();
      developer.log(
        ' [FCM] Token berhasil diambil:',
        name: 'NotificationService',
      );
      developer.log('  $_fcmToken', name: 'NotificationService');
    } catch (e) {
      developer.log(
        ' [FCM] Gagal mengambil token: $e',
        name: 'NotificationService',
      );
    }

    // Listener untuk token refresh otomatis (misal token expired/rotated).
    _messaging.onTokenRefresh.listen((newToken) {
      _fcmToken = newToken;
      developer.log(
        ' [FCM] Token di-refresh oleh Firebase:',
        name: 'NotificationService',
      );
      developer.log('  $newToken', name: 'NotificationService');
    });
  }

  /// Daftarkan semua FCM event handlers.
  void _registerFCMHandlers() {
    // 1. FOREGROUND — aplikasi aktif di layar.
    FirebaseMessaging.onMessage.listen(_onForegroundMessage);

    // 2. BACKGROUND TAP — notifikasi di-tap saat app di background (resume).
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);

    // 3. TERMINATED TAP — cek apakah app dibuka dari notifikasi saat tertutup.
    _messaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        developer.log(
          ' [FCM] App dibuka dari terminated state via notifikasi:',
          name: 'NotificationService',
        );
        _logMessage(message);
        _addToHistory(message, NotificationSource.terminated);
      }
    });

    developer.log(
      ' [FCM] Semua FCM handler terdaftar.',
      name: 'NotificationService',
    );
  }

  // ─────────────────────────── EVENT HANDLERS ────────────────────────────────

  /// Handler: pesan masuk saat app FOREGROUND.
  Future<void> _onForegroundMessage(RemoteMessage message) async {
    developer.log(
      '[FCM] Foreground message diterima:',
      name: 'NotificationService',
    );
    _logMessage(message);
    _addToHistory(message, NotificationSource.foreground);

    // Tampilkan notifikasi lokal karena FCM tidak auto-show saat foreground.
    await _showLocalNotification(message);
  }

  /// Handler: pengguna tap notifikasi saat app BACKGROUND (resume).
  void _onMessageOpenedApp(RemoteMessage message) {
    developer.log(
      '[FCM] Notifikasi di-tap (background → resume):',
      name: 'NotificationService',
    );
    _logMessage(message);
    _addToHistory(message, NotificationSource.background);
    // TODO: Navigasi ke halaman spesifik berdasarkan message.data jika diperlukan.
  }

  /// Tampilkan notifikasi lokal (dipakai saat foreground).
  Future<void> _showLocalNotification(RemoteMessage message) async {
    final RemoteNotification? notification = message.notification;
    if (notification == null) return;

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          _channelId,
          _channelName,
          channelDescription: _channelDesc,
          importance: Importance.high,
          priority: Priority.high,
          showWhen: true,
          icon: '@mipmap/ic_launcher',
        );

    const NotificationDetails notifDetails = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    await _localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.body,
      notifDetails,
      payload: message.data.toString(),
    );

    developer.log(
      '[FCM] Notifikasi lokal ditampilkan: "${notification.title}"',
      name: 'NotificationService',
    );
  }

  // ─────────────────────────── STATIC CALLBACKS ──────────────────────────────

  /// Callback saat pengguna tap notifikasi lokal (foreground tap).
  static void _onNotificationTap(NotificationResponse response) {
    developer.log(
      '[LocalNotif] Notifikasi di-tap:',
      name: 'NotificationService',
    );
    developer.log('  ▸ ID      : ${response.id}', name: 'NotificationService');
    developer.log(
      '  ▸ Payload : ${response.payload}',
      name: 'NotificationService',
    );
    developer.log(
      '  ▸ Action  : ${response.actionId ?? "-"}',
      name: 'NotificationService',
    );
    // TODO: Navigasi ke halaman spesifik berdasarkan payload jika diperlukan.
  }

  /// Callback saat tap notifikasi lokal di background (top-level).
  @pragma('vm:entry-point')
  static void _onBackgroundNotificationTap(NotificationResponse response) {
    developer.log(
      ' [LocalNotif] Background notification di-tap:',
      name: 'NotificationService',
    );
    developer.log('  ▸ ID      : ${response.id}', name: 'NotificationService');
    developer.log(
      '  ▸ Payload : ${response.payload}',
      name: 'NotificationService',
    );
  }

  // ──────────────────────────── UTILITY ─────────────────────────────────────

  /// Log detail RemoteMessage secara terstruktur.
  void _logMessage(RemoteMessage message) {
    developer.log(
      '  ▸ Message ID   : ${message.messageId ?? "-"}',
      name: 'NotificationService',
    );
    developer.log(
      '  ▸ Sent Time    : ${message.sentTime ?? "-"}',
      name: 'NotificationService',
    );
    developer.log(
      '  ▸ Title        : ${message.notification?.title ?? "-"}',
      name: 'NotificationService',
    );
    developer.log(
      '  ▸ Body         : ${message.notification?.body ?? "-"}',
      name: 'NotificationService',
    );
    developer.log(
      '  ▸ Data Payload : ${message.data}',
      name: 'NotificationService',
    );
  }
}
