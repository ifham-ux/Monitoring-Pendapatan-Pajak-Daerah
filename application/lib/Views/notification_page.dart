import 'package:flutter/material.dart';
import 'package:monitoring_pendapatan_pajak_daerah/Services/notification_service.dart';
import 'package:monitoring_pendapatan_pajak_daerah/Utils/utils.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  // ── Label singkat untuk sumber notifikasi ──────────────────────────────────
  String _sourceLabel(NotificationSource source) {
    switch (source) {
      case NotificationSource.foreground:
        return 'Foreground';
      case NotificationSource.background:
        return 'Background';
      case NotificationSource.terminated:
        return 'Terminated';
    }
  }

  // ── Warna dot indikator berdasarkan sumber ─────────────────────────────────
  Color _sourceColor(NotificationSource source) {
    switch (source) {
      case NotificationSource.foreground:
        return AppColors.green;
      case NotificationSource.background:
        return AppColors.orange;
      case NotificationSource.terminated:
        return AppColors.blue;
    }
  }

  // ── Format timestamp ────────────────────────────────────────────────────────
  String _formatTime(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);

    if (diff.inSeconds < 60) return 'Baru saja';
    if (diff.inMinutes < 60) return '${diff.inMinutes} menit lalu';
    if (diff.inHours < 24) return '${diff.inHours} jam lalu';

    final day = dt.day.toString().padLeft(2, '0');
    final month = dt.month.toString().padLeft(2, '0');
    final year = dt.year;
    final hh = dt.hour.toString().padLeft(2, '0');
    final mm = dt.minute.toString().padLeft(2, '0');
    return '$day/$month/$year $hh:$mm';
  }

  @override
  Widget build(BuildContext context) {
    final service = NotificationService.instance;

    return Scaffold(
      backgroundColor: AppColors.blackOne,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.whiteOne),
        title: const Text(
          'Notifikasi',
          style: TextStyle(
            color: AppColors.whiteOne,
            fontFamily: 'PlusJakartaSans',
            fontSize: 18,
          ),
        ),
        actions: [
          // Tombol "Tandai semua sudah dibaca"
          ValueListenableBuilder<int>(
            valueListenable: service.historyNotifier,
            builder: (_, __, ___) {
              if (service.unreadCount == 0) return const SizedBox.shrink();
              return TextButton(
                onPressed: service.markAllAsRead,
                child: const Text(
                  'Baca semua',
                  style: TextStyle(
                    color: AppColors.blue,
                    fontFamily: 'PlusJakartaSans',
                    fontSize: 13,
                  ),
                ),
              );
            },
          ),

          // Tombol hapus history
          ValueListenableBuilder<int>(
            valueListenable: service.historyNotifier,
            builder: (_, __, ___) {
              if (service.history.isEmpty) return const SizedBox.shrink();
              return IconButton(
                tooltip: 'Hapus semua',
                icon: const Icon(Icons.delete_outline, color: AppColors.whiteThree),
                onPressed: () => _confirmClear(context, service),
              );
            },
          ),
        ],
      ),

      body: ValueListenableBuilder<int>(
        valueListenable: service.historyNotifier,
        builder: (context, _, __) {
          final history = service.history;

          // ── Empty state ──────────────────────────────────────────────────
          if (history.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.notifications_off_outlined,
                    size: 64,
                    color: AppColors.blackFour,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Belum ada notifikasi',
                    style: TextStyle(
                      color: AppColors.whiteThree,
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Notifikasi yang masuk akan tampil di sini',
                    style: TextStyle(
                      color: AppColors.blackFour,
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            );
          }

          // ── Unread count banner ──────────────────────────────────────────
          return Column(
            children: [
              if (service.unreadCount > 0)
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.blackThree,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${service.unreadCount} notifikasi belum dibaca',
                    style: const TextStyle(
                      color: AppColors.whiteTwo,
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 13,
                    ),
                  ),
                ),

              // ── List ──────────────────────────────────────────────────
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 80),
                  itemCount: history.length,
                  itemBuilder: (context, index) {
                    final item = history[index];
                    final sourceColor = _sourceColor(item.source);
                    final isUnread = !item.isRead;

                    return GestureDetector(
                      onTap: () => service.markAsRead(index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: isUnread
                              ? AppColors.blackThree
                              : AppColors.blackTwo,
                          borderRadius: BorderRadius.circular(12),
                          border: isUnread
                              ? Border.all(
                                  color: sourceColor.withOpacity(0.35),
                                  width: 1,
                                )
                              : null,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ── Icon bulat ─────────────────────────────
                              Container(
                                width: 42,
                                height: 42,
                                decoration: BoxDecoration(
                                  color: sourceColor.withOpacity(0.12),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.notifications_rounded,
                                  color: sourceColor,
                                  size: 22,
                                ),
                              ),

                              const SizedBox(width: 12),

                              // ── Konten ─────────────────────────────────
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Judul + badge unread
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            item.title,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: AppColors.whiteOne,
                                              fontFamily: 'PlusJakartaSans',
                                              fontSize: 14,
                                              fontWeight: isUnread
                                                  ? FontWeight.w700
                                                  : FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        if (isUnread)
                                          Container(
                                            width: 8,
                                            height: 8,
                                            margin: const EdgeInsets.only(left: 6),
                                            decoration: BoxDecoration(
                                              color: sourceColor,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                      ],
                                    ),

                                    const SizedBox(height: 4),

                                    // Body
                                    Text(
                                      item.body,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: AppColors.whiteTwo,
                                        fontFamily: 'PlusJakartaSans',
                                        fontSize: 13,
                                      ),
                                    ),

                                    const SizedBox(height: 8),

                                    // Timestamp + source badge
                                    Row(
                                      children: [
                                        Text(
                                          _formatTime(item.receivedAt),
                                          style: const TextStyle(
                                            color: AppColors.whiteThree,
                                            fontFamily: 'PlusJakartaSans',
                                            fontSize: 11,
                                          ),
                                        ),
                                        const Spacer(),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: sourceColor.withOpacity(0.15),
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: Text(
                                            _sourceLabel(item.source),
                                            style: TextStyle(
                                              color: sourceColor,
                                              fontFamily: 'PlusJakartaSans',
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // ── Dialog konfirmasi hapus semua ──────────────────────────────────────────
  void _confirmClear(BuildContext context, NotificationService service) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.blackThree,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: const Text(
          'Hapus semua notifikasi?',
          style: TextStyle(
            color: AppColors.whiteOne,
            fontFamily: 'PlusJakartaSans',
            fontSize: 16,
          ),
        ),
        content: const Text(
          'History notifikasi akan dihapus permanen dari sesi ini.',
          style: TextStyle(
            color: AppColors.whiteTwo,
            fontFamily: 'PlusJakartaSans',
            fontSize: 13,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(
              'Batal',
              style: TextStyle(
                color: AppColors.whiteThree,
                fontFamily: 'PlusJakartaSans',
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              service.clearHistory();
              Navigator.pop(ctx);
            },
            child: const Text(
              'Hapus',
              style: TextStyle(
                color: AppColors.red,
                fontFamily: 'PlusJakartaSans',
              ),
            ),
          ),
        ],
      ),
    );
  }
}