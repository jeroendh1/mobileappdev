import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _notificationService = NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(
        android: initializationSettingsAndroid);

    tz.initializeTimeZones();
  }

  void scheduleNotificationForDeliveryDay(DateTime fromDate, String notificationTitle ,String notificationMessage) async {
    DateTime now = DateTime.now();

    Duration difference = now.isAfter(fromDate)
        ? now.difference(fromDate)
        : fromDate.difference(now);

    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        notificationTitle,
        notificationMessage,
        tz.TZDateTime.now(tz.local).add(difference),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                '1',
                'Auto-maat',
                channelDescription: 'Herinnering voor de reservering')
        ),
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);
  }
}