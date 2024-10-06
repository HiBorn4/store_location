import 'package:flutter/material.dart';
import 'home_screen.dart'; // Import the home screen (StoreListApp)

void main() {
  runApp(const MyApp()); // Entry point of the app
}

// Main app widget that wraps the entire app in MaterialApp
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hides the debug banner
      title: 'Store List App', // Title of the app
      theme: ThemeData(
        primarySwatch: Colors.blue, // Default theme color of the app (blue)
      ),
      home: const StoreListApp(), // Home screen of the app, displays the store list
    );
  }
}



