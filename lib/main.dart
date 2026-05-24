import 'package:flutter/material.dart';
import 'providers/theme_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'screens/dashboard_screen.dart';
import 'routing/router.dart';

void main() async {
  // Ensures Flutter framework bindings are ready before async setup
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  // Initialize Supabase client
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'] ?? '',
    anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '',
  );

  runApp(
    // ProviderScope stores the state of all Riverpod providers
    ProviderScope(
      child: StudentApp(),
    ),
  );
}

class StudentApp extends ConsumerWidget {
  const StudentApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider);

    // Switch to .router constructor to hand over navigation control to go_router
    return MaterialApp.router(
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        scaffoldBackgroundColor:
            isDarkMode ? const Color(0xFF121212) : const Color(0xFFF0F7FF),
        fontFamily: 'Poppins',
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: const Color(0xFF1E88E5),
          selectionHandleColor: const Color(0xFF1E88E5),
          selectionColor: const Color(0xFF1E88E5).withOpacity(0.3),
        ),
      ),
    );
  }
}
