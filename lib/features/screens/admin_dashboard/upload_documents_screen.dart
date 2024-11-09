import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../../../core/constants/app_colors.dart';

class UploadDocumentsScreen extends StatefulWidget {
  const UploadDocumentsScreen({super.key});

  @override
  _UploadDocumentsScreenState createState() => _UploadDocumentsScreenState();
}

class _UploadDocumentsScreenState extends State<UploadDocumentsScreen> {
  String? fileName; // Stores the selected file name

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'docx', 'json', 'jpg'],
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        fileName = result.files.single.name;
      });
    } else {
      setState(() {
        fileName = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.themeGradientBackground,
        ),
        child: Center(
          child: Card(
            color: AppColors.veryPaleBlue,
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.upload_file,
                    size: 50,
                    color: AppColors.oceanBlue,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Upload Your Documents',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.charcoalBlue,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Select a file to upload. Supported formats: PDF, DOCX, JSON, JPG.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.charcoalBlue,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: pickFile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.brightBlue,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: const StadiumBorder(), // Makes the button fully rounded
                    ),
                    child: const Text(
                      'Choose File',
                      style: TextStyle(color: AppColors.white, fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (fileName != null)
                    Text(
                      'Selected File: $fileName',
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.charcoalBlue,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
