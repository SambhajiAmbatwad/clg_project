import 'package:clg_project/screens/LoginScreen.dart'; // Correct the import if needed
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:clg_project/screens/HomeScreen.dart'; // Import HomeScreen if that's what you're using

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Fixed typo in WidgetsFlutterBinding
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Homepage(), // Make sure this is the correct widget name
    );
  }
}
