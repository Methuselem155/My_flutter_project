// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_work/pages/about_page.dart';
import 'package:flutter_work/pages/data_page.dart';
import 'package:flutter_work/pages/help_page.dart';
import 'package:flutter_work/pages/login_page.dart'; // Import the LoginPage

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Track the selected index for the top navigation bar

  // List of pages to navigate to
  static final List<Widget> _pages = [
    HomeContent(), // Replace with your home content widget
    const AboutPage(),
    const DataPage(),
    const HelpPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Logout method
  void _logout(BuildContext context) {
    // Clear any user session data (e.g., tokens, logged-in state)
    // Example: Clear shared preferences, reset state, etc.

    // Navigate to the LoginPage and remove all previous routes
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (route) => false, // Remove all routes
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 80, // Set the height of the black rectangle
          decoration: const BoxDecoration(
            color: Colors.black, // Black background for the entire row
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavIcon(Icons.home, 'Home', 0),
              _buildNavIcon(Icons.info, 'About us', 1),
              _buildNavIcon(Icons.data_usage, 'Data', 2),
              _buildNavIcon(Icons.help, 'Help', 3),
            ],
          ),
        ),
        toolbarHeight: 80, // Set AppBar height to match the black rectangle
        automaticallyImplyLeading: false, // Remove the back button (if any)
        flexibleSpace: Container(
          color: Colors.black, // Ensure the entire AppBar background is black
        ),
        actions: [
          // Logout button
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: _pages[_selectedIndex], // Display the selected page
    );
  }

  // Helper method to build navigation icons
  Widget _buildNavIcon(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: _selectedIndex == index ? Colors.blue[900] : Colors.white, // Blue for selected, white for unselected
          ),
          const SizedBox(height: 4), // Add spacing between icon and text
          Text(
            label,
            style: TextStyle(
              color: _selectedIndex == index ? Colors.blue[900] : Colors.white, // Blue for selected, white for unselected
              fontSize: 12, // Adjust text size if needed
            ),
          ),
        ],
      ),
    );
  }
}

// Placeholder for the home content
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.white.withOpacity(0.8),
              child: const Text(
                'Welcome to our app! We are excited to have you here. Explore the features and enjoy the seamless experience.',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.white.withOpacity(0.8),
              child: const Text(
                'Feel free to reach out for support or feedback. Our team is here to assist you and ensure you get the best out of our services.',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}