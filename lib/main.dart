import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart';

void main() => runApp(StudentApp());

class StudentApp extends StatefulWidget {
  @override
  _StudentAppState createState() => _StudentAppState();
}

class _StudentAppState extends State<StudentApp> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        scaffoldBackgroundColor:
            isDarkMode ? Color(0xFF121212) : Color(0xFFF0F7FF),
        fontFamily: 'Poppins',
      ),
      home: DashboardScreen(
        isDarkMode: isDarkMode,
        onThemeChanged: (val) => setState(() => isDarkMode = val),
      ),
    );
  }
}
