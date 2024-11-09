import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/constants/app_colors.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.themeGradientBackground,
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('cases').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError || !snapshot.hasData) {
              return const Center(child: Text('Error loading cases.'));
            }

            final userCases = snapshot.data!.docs;

            if (userCases.isEmpty) {
              return const Center(
                child: Text(
                  'No cases found.',
                  style: TextStyle(fontSize: 20, color: AppColors.charcoalBlue),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: userCases.length,
              itemBuilder: (context, index) {
                var caseData = userCases[index];
                var caseNumber = caseData['caseNumber'] ?? 'N/A';
                var title = caseData['title'] ?? 'No Title';
                var status = caseData['status'] ?? 'Unknown Status';
                var createdAt = (caseData['createdAt'] as Timestamp?)?.toDate();
                var createdAtText = createdAt != null
                    ? '${createdAt.day}/${createdAt.month}/${createdAt.year}'
                    : 'Unknown Date';

                return GestureDetector(
                  onTap: () {
                    // Implement detailed view navigation or interaction
                  },
                  child: Card(
                    elevation: 8,
                    shadowColor: AppColors.brightBlue.withOpacity(0.3),
                    color: AppColors.white,
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Case #$caseNumber',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.charcoalBlue,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.brightBlue,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Status: $status',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: AppColors.charcoalBlue,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: status == 'Resolved'
                                      ? Colors.greenAccent.shade100
                                      : AppColors.paleAqua,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  status,
                                  style: TextStyle(
                                    color: status == 'Resolved'
                                        ? Colors.green.shade800
                                        : AppColors.charcoalBlue,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Created on: $createdAtText',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
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
