import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/constants/app_colors.dart';

class TrackCasesScreen extends StatelessWidget {
  const TrackCasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController caseIdController = TextEditingController();

    Future<void> trackCase(BuildContext context) async {
      String caseId = caseIdController.text.trim();

      try {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('cases')
            .where('caseNumber', isEqualTo: caseId)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          var caseData = querySnapshot.docs.first.data() as Map<String, dynamic>?;
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) {
              return _buildCaseDetailsCard(context, caseData!);
            },
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Case Not Found for ID: $caseId')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching case: $e')),
        );
      }
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.themeGradientBackground,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: AppColors.paleAqua,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Track Your Case',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: AppColors.charcoalBlue,
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: caseIdController,
                        decoration: InputDecoration(
                          labelText: 'Enter Case ID',
                          labelStyle: const TextStyle(color: AppColors.brightBlue),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: () => trackCase(context),
                          style: ElevatedButton.styleFrom(
                            elevation: 3,
                            backgroundColor: AppColors.brightBlue,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            shadowColor: AppColors.brightBlue.withOpacity(0.4),
                          ),
                          child: const Text(
                            'Track Case',
                            style: TextStyle(color: AppColors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Modify _buildCaseDetailsCard to accept BuildContext as a parameter
  Widget _buildCaseDetailsCard(BuildContext context, Map<String, dynamic> caseData) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Card(
        color: AppColors.white,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                caseData['title'] ?? 'Untitled Case',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.charcoalBlue,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Case Number: ${caseData['caseNumber'] ?? 'N/A'}',
                style: const TextStyle(fontSize: 16, color: AppColors.charcoalBlue),
              ),
              const SizedBox(height: 8),
              Text(
                'Status: ${caseData['status'] ?? 'Unknown'}',
                style: TextStyle(
                  fontSize: 16,
                  color: caseData['status'] == 'Closed' ? Colors.redAccent : AppColors.brightBlue,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Divider(height: 20, thickness: 1.2),
              Text(
                'Description:',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.charcoalBlue),
              ),
              const SizedBox(height: 6),
              Text(
                caseData['description'] ?? 'No description available.',
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.check_circle, color: AppColors.brightBlue),
                  label: const Text(
                    'Close',
                    style: TextStyle(color: AppColors.brightBlue, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
