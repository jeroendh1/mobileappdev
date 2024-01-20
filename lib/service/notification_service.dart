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

  void scheduleNotificationForDeliveryDay(int id, DateTime fromDate, String notificationTitle ,String notificationMessage) async {
    DateTime now = DateTime.now();

    Duration difference = now.isAfter(fromDate)
        ? now.difference(fromDate)
        : fromDate.difference(now);

    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        notificationTitle,
        notificationMessage,
        tz.TZDateTime.now(tz.local).add(difference),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                '0',
                'Auto-maat',
                channelDescription: 'Herinnering voor de reservering')
        ),
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);
  }

  void scheduleNotificationForReservation() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        1,
        'Reservering',
        'Maak vandaag nog een reservering!',
        tz.TZDateTime.now(tz.local).add(const Duration(hours: 1)),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                '1',
                'Reservering',
                channelDescription: 'reservering')
        ),
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);
  }
  void cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  getNotifications() async{
    final List<PendingNotificationRequest> pendingNotificationRequests =
    await flutterLocalNotificationsPlugin.pendingNotificationRequests();

    return pendingNotificationRequests;
  }

  void cancelMakeReservationNotification() async {
    final List<PendingNotificationRequest> pendingNotificationRequests = await getNotifications();

    for (var request in pendingNotificationRequests) {
      if (request.id == 1) {
        await flutterLocalNotificationsPlugin.cancel(request.id);
        print('Cancelled notification with ID 1');
      }
    }
  }
}