import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/constants/app_colors.dart';
import 'all_cases_screen.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('cases').get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return const Center(child: Text('Error loading cases.'));
        }

        int totalCases = snapshot.data!.docs.length;
        int pendingCases = snapshot.data!.docs.where((doc) => doc['status'] == 'Pending').length;
        int resolvedCases = totalCases - pendingCases;

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildDashboardCard(
                context,
                title: 'Total Cases',
                count: totalCases,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AllCasesScreen()),
                ),
                color: AppColors.brightBlue,
              ),
              _buildDashboardCard(
                context,
                title: 'Pending Cases',
                count: pendingCases,
                color: AppColors.coralRed,
              ),
              _buildDashboardCard(
                context,
                title: 'Resolved Cases',
                count: resolvedCases,
                color: AppColors.lightBlue,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDashboardCard(BuildContext context,
      {required String title, required int count, VoidCallback? onTap, required Color color}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [color.withOpacity(0.8), color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
              Text(
                count.toString(),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
