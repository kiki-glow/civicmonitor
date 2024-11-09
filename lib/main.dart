import 'package:civicmonitor/features/screens/admin_dashboard/all_cases_screen.dart';
import 'package:civicmonitor/features/screens/admin_dashboard/upload_documents_screen.dart';
import 'package:civicmonitor/features/screens/user_dashboard/track_cases_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Auth
import 'core/constants/app_colors.dart';
import 'features/home/home.dart';
import 'features/home/landing_page.dart';
import 'firebase_options.dart'; 
import 'features/notifications/notifications.dart';
import 'features/screens/admin_dashboard/admin_dashboard.dart';
import 'features/screens/user_dashboard/user_dashboard.dart';
import 'user/auth.dart';
import 'user/login.dart';
import 'user/register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize Firebase with platform-specific options
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print("Error initializing Firebase: $e");
    return;
  }

  // Set the desired language code for Firebase Authentication
  FirebaseAuth.instance.setLanguageCode('en');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CivicMonitor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.paleAqua,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LandingPage(),
        '/auth': (context) => const AuthPage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const Home(),
        '/adminDashboard': (context) => const AdminDashboard(),
        '/userDashboard': (context) => const UserDashboard(), 
        '/notifications': (context) => NotificationsPage(),
        '/viewCases': (context) => const AllCasesScreen(),
        '/trackCases': (context) => const TrackCasesScreen(),
        '/uploadDocuments': (context) => const UploadDocumentsScreen(),
      },
    );
  }
}
