import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:purple_pay_assignment/services/notification.service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NotificationService notificationService = NotificationService();
  final bool _notificationsEnabled = false;

  @override
  void initState() {
    super.initState();
    notificationService.initialiseNotifications();
    notificationService.isAndroidPermissionGranted().then((value) => {
          if (value)
            setState(() => {_notificationsEnabled: value})
          else
            notificationService.requestPermissions().then((otherValue) => {
                  if (otherValue)
                    setState(() => {_notificationsEnabled: otherValue})
                })
        });
  }

  void _sendNotification() {
    notificationService.sendNotification(
        'Payment has been completed', 'Payment has been completed');
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FilledButton(
                onPressed: _sendNotification, child: const Text('Completed'))
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
