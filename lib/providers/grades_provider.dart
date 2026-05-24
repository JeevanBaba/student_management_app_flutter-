import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GradesNotifier extends AsyncNotifier<List<dynamic>> {
  // Grab the initialized global Supabase client instance
  final _supabase = Supabase.instance.client;

  @override
  Future<List<dynamic>> build() async {
    // When the provider is first watched, immediately fetch the rows
    return _fetchGradesViaRPC();
  }

  // Fetch data using the optimized JSON RPC function we wrote
  Future<List<dynamic>> _fetchGradesViaRPC() async {
    final response = await _supabase.rpc('get_student_grades');
    return response as List<dynamic>;
  }

  // Update marks via the batch-processing RPC function
  Future<void> updateMarks(List<Map<String, dynamic>> updatedGrades) async {
    // Set state to loading so the UI can instantly display a loading spinner
    state = const AsyncValue.loading();
    try {
      // Broadcast the complete JSON list payload down to PostgreSQL
      await _supabase.rpc('update_student_grades', params: {'items': updatedGrades});
      
      // Force Riverpod to clear its cache and execute build() again, pulling fresh data
      ref.invalidateSelf();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

// Expose the notifier globally so our consumer widgets can watch it
final gradesProvider = AsyncNotifierProvider<GradesNotifier, List<dynamic>>(() {
  return GradesNotifier();
});
