import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class NotificationService extends GetxService {
  final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();

  Future<NotificationService> init() async {
    // Setup Android
    const AndroidInitializationSettings androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    // Setup iOS
    const DarwinInitializationSettings iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(settings);

    // Request permissions for Android 13+
    await _notifications
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    return this;
  }

  // Fungsi untuk memalsukan Email Masuk
  Future<void> showFakeEmailNotification(String otpCode) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'otp_channel',
      'Login Notifications',
      channelDescription: 'Notifikasi untuk OTP',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      styleInformation: BigTextStyleInformation(''),
    );

    const NotificationDetails details = NotificationDetails(android: androidDetails);

    await _notifications.show(
      0,
      '📧 Email Masuk: Verifikasi Login',
      'Kode OTP rahasia Anda adalah: $otpCode. Jangan berikan ke siapapun.',
      details,
    );
  }
}
