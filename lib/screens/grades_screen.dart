import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import '../providers/grades_provider.dart';
import '../widgets/grade_item.dart';

class GradesScreen extends ConsumerWidget {
  const GradesScreen({super.key});

  // --- LOGIC METHOD 1: Calculate CGPA ---
  double calculateCGPA(List<dynamic> grades) {
    if (grades.isEmpty) return 0.0;
    double totalPoints = 0;
    for (var item in grades) {
      int score =
          item['score'] is int
              ? item['score']
              : int.tryParse(item['score'].toString()) ?? 0;
      if (score >= 90) {
        totalPoints += 4.0;
      } else if (score >= 80) {
        totalPoints += 3.5;
      } else if (score >= 70) {
        totalPoints += 3.0;
      } else if (score >= 60) {
        totalPoints += 2.5;
      } else if (score >= 50) {
        totalPoints += 2.0;
      } else {
        totalPoints += 0.0;
      }
    }
    return totalPoints / grades.length;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch our live data state stream provider
    final gradesAsync = ref.watch(gradesProvider);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Performance",
          style: TextStyle(fontFamily: 'NUSAR', fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      // Pattern match across the asynchronous states natively
      body: gradesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error loading grades: $err')),
        data: (gradesList) {
          final double cgpa = calculateCGPA(gradesList);

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(gradesProvider);
            },
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
                    color: isDarkMode ? Colors.white10 : Colors.white,
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
                if (gradesList.isEmpty)
                  const Center(child: Text('No grades recorded yet.'))
                else
                  ...gradesList.map((item) {
                    int currentScore =
                        item['score'] is int
                            ? item['score']
                            : int.tryParse(item['score'].toString()) ?? 0;

                    return GradeItem(
                      subject: item['subject'] ?? 'Unknown Subject',
                      score: currentScore,
                      grade: item['grade'] ?? 'N/A', // Pulled straight from DB
                      isDarkMode: isDarkMode,
                    );
                  }).toList(),
              ],
            ),
          );
        },
      ),
    );
  }
}
