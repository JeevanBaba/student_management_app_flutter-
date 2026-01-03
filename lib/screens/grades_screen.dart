import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:lottie/lottie.dart';
import '../widgets/grade_item.dart';

class GradesScreen extends StatefulWidget {
  final bool isDarkMode;
  GradesScreen({required this.isDarkMode, super.key});

  @override
  State<GradesScreen> createState() => _GradesScreenState();
}

class _GradesScreenState extends State<GradesScreen> {
  final String apiUrl =
      "https://695830056c3282d9f1d48ee9.mockapi.io/student_grade/grades";

  // --- LOGIC METHOD 1: Calculate CGPA ---
  double calculateCGPA(List<dynamic> grades) {
    if (grades.isEmpty) return 0.0;
    double totalPoints = 0;
    for (var item in grades) {
      int score =
          item['score'] is int
              ? item['score']
              : int.parse(item['score'].toString());
      if (score >= 90)
        totalPoints += 4.0;
      else if (score >= 80)
        totalPoints += 3.5;
      else if (score >= 70)
        totalPoints += 3.0;
      else if (score >= 60)
        totalPoints += 2.5;
      else if (score >= 50)
        totalPoints += 2.0;
      else
        totalPoints += 0.0;
    }
    return totalPoints / grades.length;
  }

  // --- LOGIC METHOD 2: Map Score to Letter Grade ---
  String _getLetterGrade(int score) {
    if (score >= 90) return "A+";
    if (score >= 80) return "A";
    if (score >= 70) return "B";
    if (score >= 60) return "C";
    if (score >= 50) return "D";
    return "F";
  }

  // --- API METHOD: Fetch Data ---
  Future<List<dynamic>> fetchGradesFromApi() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load grades');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Performance",
          style: TextStyle(fontFamily: 'NUSAR', fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchGradesFromApi(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error Syncing Data: ${snapshot.error}"));
          } else {
            final grades = snapshot.data ?? [];
            final double cgpa = calculateCGPA(grades);

            return RefreshIndicator(
              onRefresh: () async => setState(() {}),
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  // CGPA DISPLAY CARD
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Overall CGPA",
                          style: TextStyle(color: Colors.white70),
                        ),
                        Text(
                          cgpa.toStringAsFixed(2),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ANIMATION
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: widget.isDarkMode ? Colors.white10 : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Lottie.asset(
                      'assets/lottie/performance_chart.json',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    "Semester Grades",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),

                  // DYNAMIC LIST
                  ...grades.map((item) {
                    int currentScore =
                        item['score'] is int
                            ? item['score']
                            : int.parse(item['score'].toString());

                    return GradeItem(
                      subject: item['subject'],
                      score: currentScore,
                      grade: _getLetterGrade(
                        currentScore,
                      ), // Correctly calling the helper
                      isDarkMode: widget.isDarkMode,
                    );
                  }).toList(),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
