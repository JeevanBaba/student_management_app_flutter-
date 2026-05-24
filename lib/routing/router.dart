import 'package:go_router/go_router.dart';
import '../screens/dashboard_screen.dart';
import '../screens/grades_screen.dart';
import '../screens/marks_entry_screen.dart';
import '../screens/timetable_screen.dart';

final goRouter = GoRouter(
  initialLocation: '/dashboard',
  routes: [
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: '/grades',
      builder: (context, state) => const GradesScreen(),
    ),
    GoRoute(
      path: '/teacher-entry',
      builder: (context, state) => const MarksEntryScreen(),
    ),
    GoRoute(
      path: '/timetable',
      builder: (context, state) => const TimetableScreen(),
    ),
  ],
);
