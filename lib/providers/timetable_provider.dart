import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TimetableNotifier extends AsyncNotifier<List<dynamic>> {
  @override
  Future<List<dynamic>> build() async {
    final response = await Supabase.instance.client.rpc('get_scheduled_timetable');
    return response as List<dynamic>;
  }
}

final timetableProvider = AsyncNotifierProvider<TimetableNotifier, List<dynamic>>(() {
  return TimetableNotifier();
});
