import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/constants/app_colors.dart';
import 'package:intl/intl.dart';  // To format timestamps

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  String formatTimestamp(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    return DateFormat('hh:mm a').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          gradient: AppColors.themeGradientBackground,
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('notifications')
              .where('type', isEqualTo: 'general') // Filter for general notifications only
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError || !snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.notifications_off,
                      size: 50,
                      color: AppColors.charcoalBlue,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'No notifications available.',
                      style: TextStyle(
                        color: AppColors.charcoalBlue,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }

            final notifications = snapshot.data!.docs;

            return ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                var notification = notifications[index].data() as Map<String, dynamic>;
                var timestamp = notification['timestamp'] is Timestamp
                    ? formatTimestamp(notification['timestamp'] as Timestamp)
                    : 'Just now';

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  color: AppColors.paleAqua,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4.0,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: const Icon(
                      Icons.notifications,
                      color: AppColors.charcoalBlue,
                    ),
                    title: Text(
                      notification['title'] ?? 'Notification',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.charcoalBlue,
                      ),
                    ),
                    subtitle: Text(
                      notification['message'] ?? 'No message provided.',
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.charcoalBlue,
                      ),
                    ),
                    trailing: Text(
                      timestamp,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.brightBlue,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
