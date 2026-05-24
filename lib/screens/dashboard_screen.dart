import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/theme_provider.dart';
import '../widgets/stat_card.dart';
import '../widgets/class_tile.dart';
import 'grades_screen.dart';
import 'package:lottie/lottie.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider);
    final Function(bool) onThemeChanged = (bool val) {
      ref.read(themeProvider.notifier).state = val;
    };

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Dashboard",
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
            fontFamily: 'NUSAR',
          ),
        ),
        actions: [
          Switch(
            value: isDarkMode,
            onChanged: onThemeChanged,
            activeColor: Colors.white, // The 'knob' color when ON
            activeTrackColor: Colors.blueAccent, // The track color when ON
            inactiveThumbColor: Colors.blueAccent, // The knob color when OFF
            inactiveTrackColor: Colors.blueAccent.withOpacity(
              0.3,
            ), // The track when OFF
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Student Welcome Animation
            Center(
              child: Lottie.asset(
                'assets/lottie/student_welcome.json',
                height: 180,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Welcome back, Shivam!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // STAT CARDS SECTION
            Row(
              children: [
                Expanded(
                  child: StatCard(
                    title: "Attendance",
                    value: "92%",
                    icon: Icons.calendar_today,
                    isDarkMode: isDarkMode, // Use the actual variable
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: GestureDetector(
                    // Navigation triggered when clicking the StatCard
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    const GradesScreen(),
                          ),
                        ),
                    child: StatCard(
                      title: "Performance", // CHANGED FROM GPA
                      value:
                          "View All", // You can also put the CGPA variable here later
                      icon: Icons.trending_up,
                      isDarkMode: isDarkMode,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),
            const Text(
              "Quick Actions", // Changed from Activities for better UX
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),

            // NAVIGATION TILES
            ClassTile(
              title: "Academic Performance",
              isDarkMode: isDarkMode,
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => const GradesScreen(),
                    ),
                  ),
            ),
            ClassTile(
              title: "Scheduled Time Table",
              isDarkMode: isDarkMode,
              onTap: () => context.push('/timetable'),
            ),
            const SizedBox(height: 20),
            
            // PROMINENT TEACHER ACTION BUTTON
            ClassTile(
              title: "Teacher Access: Enter Marks",
              isDarkMode: isDarkMode,
              onTap: () => context.push('/teacher-entry'),
            ),
          ],
        ),
      ),
    );
  }
}
