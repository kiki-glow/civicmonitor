import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/constants/app_colors.dart';

class AllCasesScreen extends StatefulWidget {
  const AllCasesScreen({super.key});

  @override
  _AllCasesScreenState createState() => _AllCasesScreenState();
}

class _AllCasesScreenState extends State<AllCasesScreen> {
  String sortBy = 'Most Recent';
  String selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.paleAqua,
        title: const Text(
          'All Cases',
          style: TextStyle(
            color: AppColors.deepBlue,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: AppColors.charcoalBlue),
        elevation: 0,
      ),
      body: Container(
        color: AppColors.lightBlue,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sort Section
            const Text(
              'Sort By',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.charcoalBlue,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 10,
              children: ['Most Recent', 'Oldest First', 'A-Z', 'Z-A']
                  .map((option) => ChoiceChip(
                        label: Text(option, style: const TextStyle(color: Colors.white)),
                        selected: sortBy == option,
                        selectedColor: AppColors.brightBlue,
                        backgroundColor: AppColors.lightBlue,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        onSelected: (selected) {
                          setState(() {
                            sortBy = option;
                          });
                        },
                      ))
                  .toList(),
            ),
            const SizedBox(height: 20),

            // Filter Section
            const Text(
              'Filter',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.charcoalBlue,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 10,
              children: ['All', 'Open', 'Closed', 'In Progress', 'Resolved']
                  .map((status) => ChoiceChip(
                        label: Text(status, style: const TextStyle(color: Colors.white)),
                        selected: selectedFilter == status,
                        selectedColor: AppColors.coralRed,
                        backgroundColor: AppColors.lightBlue,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        onSelected: (selected) {
                          setState(() {
                            selectedFilter = status;
                          });
                        },
                      ))
                  .toList(),
            ),
            const SizedBox(height: 20),

            // Cases List
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('cases').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError || !snapshot.hasData) {
                    return const Center(child: Text('Error loading cases.'));
                  }

                  var cases = snapshot.data!.docs;

                  // Apply filter based on the selected status
                  if (selectedFilter != 'All') {
                    cases = cases
                        .where((doc) => (doc.data() as Map<String, dynamic>)['status'] == selectedFilter)
                        .toList();
                  }

                  // Apply sorting logic
                  cases.sort((a, b) {
                    Map<String, dynamic> aData = a.data() as Map<String, dynamic>;
                    Map<String, dynamic> bData = b.data() as Map<String, dynamic>;

                    var createdAtA = aData['createdAt'] as Timestamp? ?? Timestamp.fromMillisecondsSinceEpoch(0);
                    var createdAtB = bData['createdAt'] as Timestamp? ?? Timestamp.fromMillisecondsSinceEpoch(0);

                    if (sortBy == 'Most Recent') {
                      return createdAtB.compareTo(createdAtA);
                    } else if (sortBy == 'Oldest First') {
                      return createdAtA.compareTo(createdAtB);
                    } else if (sortBy == 'A-Z') {
                      return (aData['title'] ?? '').compareTo(bData['title'] ?? '');
                    } else if (sortBy == 'Z-A') {
                      return (bData['title'] ?? '').compareTo(aData['title'] ?? '');
                    }
                    return 0;
                  });

                  if (cases.isEmpty) {
                    return const Center(
                      child: Text(
                        'No cases found.',
                        style: TextStyle(
                          color: AppColors.charcoalBlue,
                          fontSize: 20,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: cases.length,
                    itemBuilder: (context, index) {
                      var caseData = cases[index].data() as Map<String, dynamic>;
                      var title = caseData['title'] ?? 'No Title';
                      var status = caseData['status'] ?? 'Unknown Status';

                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.paleAqua,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.charcoalBlue.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 8,
                              offset: const Offset(2, 4),
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          title: Text(
                            title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.charcoalBlue,
                            ),
                          ),
                          subtitle: Text(
                            'Status: $status',
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.charcoalBlue,
                            ),
                          ),
                          onTap: () {
                            // Navigate to case details screen (if implemented)
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
