import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/constants/app_colors.dart';

class AddNewCaseScreen extends StatefulWidget {
  const AddNewCaseScreen({super.key});

  @override
  _AddNewCaseScreenState createState() => _AddNewCaseScreenState();
}

class _AddNewCaseScreenState extends State<AddNewCaseScreen> {
  final TextEditingController caseTitleController = TextEditingController();
  final TextEditingController caseDescriptionController = TextEditingController();
  String selectedStatus = 'Pending';

  Future<void> addNewCase() async {
    String title = caseTitleController.text.trim();
    String description = caseDescriptionController.text.trim();

    if (title.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    final now = DateTime.now();
    final random = Random();
    final randomDigits = random.nextInt(10000).toString().padLeft(4, '0');
    final caseNumber = 'CASE-${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}-$randomDigits';

    try {
      await FirebaseFirestore.instance.collection('cases').add({
        'caseNumber': caseNumber,
        'title': title,
        'description': description,
        'status': selectedStatus,
        'createdAt': Timestamp.now(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Case added successfully. Your case number is $caseNumber')),
      );
      caseTitleController.clear();
      caseDescriptionController.clear();
      setState(() {
        selectedStatus = 'Pending';
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add case: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Adjust content when keyboard appears
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.themeGradientBackground,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Card(
              color: AppColors.veryPaleBlue,
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Add New Case',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: AppColors.charcoalBlue,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: caseTitleController,
                      decoration: InputDecoration(
                        labelText: 'Case Title',
                        labelStyle: const TextStyle(color: AppColors.brightBlue),
                        filled: true,
                        fillColor: AppColors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: caseDescriptionController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: 'Case Description',
                        labelStyle: const TextStyle(color: AppColors.brightBlue),
                        filled: true,
                        fillColor: AppColors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: selectedStatus,
                      decoration: InputDecoration(
                        labelText: 'Case Status',
                        labelStyle: const TextStyle(color: AppColors.brightBlue),
                        filled: true,
                        fillColor: AppColors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      items: ['Pending', 'Open', 'Closed', 'In Progress', 'Resolved']
                          .map((status) => DropdownMenuItem(
                                value: status,
                                child: Text(status),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedStatus = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: addNewCase,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.brightBlue,
                          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
                          shape: const StadiumBorder(), // Makes the button fully rounded
                        ),
                        child: const Text(
                          'Add Case',
                          style: TextStyle(color: AppColors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
