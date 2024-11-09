import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:civicmonitor/features/screens/admin_dashboard/admin_dashboard.dart'; // Admin Dashboard
import 'package:civicmonitor/features/screens/user_dashboard/user_dashboard.dart'; // User Dashboard
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = true; // Loading state flag
  bool isAdmin = false; // Default to non-admin (regular user)

  @override
  void initState() {
    super.initState();
    _checkUserRole(); // Check user role when the widget initializes
  }

  // Function to check the user role from Firestore
  Future<void> _checkUserRole() async {
    try {
      // Get the currently logged-in user
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Fetch user data from Firestore
        DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

        if (userDoc.exists) {
          // Ensure user document exists
          Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>; // Cast Firestore data

          // Here we check the role field, and in your Firestore, it's called 'court_admin'
          if (userData.containsKey('role') && userData['role'] == 'court_admin') {
            // Check if the role is 'court_admin'
            setState(() {
              isAdmin = true; // Set admin status
            });
          }
        } else {
          // Handle case where user document does not exist
          print('User document does not exist.');
        }
      } else {
        // Handle case where no user is logged in
        print('No user is currently logged in.');
      }
    } catch (e) {
      // Catch and log any error that occurs
      print('Error fetching user role: $e');
    } finally {
      // Stop the loading spinner after the role check is done
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      // Show a loading spinner while user role is being fetched
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Based on the user role, show the correct dashboard
    return isAdmin ? const AdminDashboard() : const UserDashboard();
  }
}