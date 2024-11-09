import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class NotificationsPage extends StatelessWidget {
  NotificationsPage({super.key}); // Removed 'const' here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: AppColors.paleAqua,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Recent Notifications',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.deepBlue,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.separated(
                itemCount: notifications.length,
                separatorBuilder: (context, index) => const Divider(
                  height: 20,
                  color: AppColors.charcoalBlue,
                ),
                itemBuilder: (context, index) {
                  final notification = notifications[index];
                  return buildNotificationItem(notification);
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Real-time Case Updates',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.deepBlue,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.separated(
                itemCount: caseUpdates.length,
                separatorBuilder: (context, index) => const Divider(
                  height: 20,
                  color: AppColors.charcoalBlue,
                ),
                itemBuilder: (context, index) {
                  final update = caseUpdates[index];
                  return buildCaseUpdateItem(update);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable widget for notifications
  Widget buildNotificationItem(String notification) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      tileColor: AppColors.lightBlue.withOpacity(0.9), // Light background for notifications
      title: Text(
        notification,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      trailing: const Icon(Icons.notifications, color: AppColors.deepBlue),
    );
  }

  // Reusable widget for case updates
  Widget buildCaseUpdateItem(String update) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      tileColor: AppColors.paleAqua.withOpacity(0.9), // Light background for case updates
      title: Text(
        update,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      trailing: const Icon(Icons.assignment, color: AppColors.deepBlue),
    );
  }

  // Sample notifications
  final List<String> notifications = [
    'Your case "Case #12345" has been updated.',
    'Reminder: Court hearing on "Case #67890" is tomorrow.',
    'New message from your attorney regarding "Case #54321".',
    'A new document has been added to "Case #98765".',
  ];

  // Sample case updates
  final List<String> caseUpdates = [
    'Court Date Changed: "Case #12345" has a new date.',
    'New evidence submitted for "Case #67890".',
    'Your attorney has filed a motion for "Case #54321".',
    'Case "Case #98765" is now in review.',
  ];
}
