import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/constants/app_colors.dart';
import 'package:intl/intl.dart';

class CaseUpdatesScreen extends StatelessWidget {
  const CaseUpdatesScreen({super.key});

  String formatTimestamp(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    return DateFormat('MMM d, y • hh:mm a').format(date); // Friendly date format
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
          stream: FirebaseFirestore.instance.collection('case_updates').snapshots(),
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
                      Icons.update_disabled,
                      size: 50,
                      color: AppColors.charcoalBlue,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'No case updates available.',
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

            final caseUpdates = snapshot.data!.docs;

            return ListView.builder(
              itemCount: caseUpdates.length,
              itemBuilder: (context, index) {
                var update = caseUpdates[index].data() as Map<String, dynamic>;
                var timestamp = update['timestamp'] is Timestamp
                    ? formatTimestamp(update['timestamp'] as Timestamp)
                    : 'Just now';
                var statusColor = update['status'] == 'Resolved'
                    ? Colors.greenAccent
                    : (update['status'] == 'Pending' ? Colors.amberAccent : Colors.blueAccent);

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 4.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 6,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.paleAqua, AppColors.charcoalBlue.withOpacity(0.1)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      leading: Icon(
                        Icons.update,
                        color: statusColor,
                        size: 40,
                      ),
                      title: Text(
                        update['title'] ?? 'Case Update',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.charcoalBlue,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 6.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              update['updateMessage'] ?? 'No message provided.',
                              style: const TextStyle(
                                fontSize: 15,
                                color: AppColors.charcoalBlue,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: statusColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    update['status'] ?? 'Unknown',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  timestamp,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.brightBlue,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
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
