import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/timetable_provider.dart';

class TimetableScreen extends ConsumerWidget {
  const TimetableScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timetableAsync = ref.watch(timetableProvider);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : const Color(0xFFF0F7FF),
      appBar: AppBar(
        title: Text('Scheduled Time Table', style: TextStyle(fontFamily: 'NUSAR', color: isDarkMode ? Colors.white : Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: isDarkMode ? Colors.white : Colors.black),
          onPressed: () => context.pop(),
        ),
      ),
      body: timetableAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: Color(0xFF1E88E5))),
        error: (err, _) => Center(child: Text('Error loading timetable: $err', style: const TextStyle(fontFamily: 'Poppins'))),
        data: (schedule) {
          if (schedule.isEmpty) {
            return const Center(child: Text('No classes scheduled.', style: TextStyle(fontFamily: 'Poppins', fontSize: 16, color: Colors.grey)));
          }

          return RefreshIndicator(
            color: const Color(0xFF1E88E5),
            onRefresh: () async {
              await ref.refresh(timetableProvider.future);
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(20.0),
            itemCount: schedule.length,
            itemBuilder: (context, index) {
              final item = schedule[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 16.0),
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: isDarkMode ? Colors.black.withAlpha(120) : Colors.grey.withAlpha(40),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    )
                  ],
                  border: const Border(
                    left: BorderSide(
                      color: Color(0xFF1E88E5), // Master brand blue
                      width: 6,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['subject_name']?.toString() ?? 'Free Period',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              fontFamily: 'Poppins',
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.access_time, size: 16, color: Colors.grey),
                              const SizedBox(width: 6),
                              Text(
                                '${item['start_time']?.toString() ?? 'TBA'} - ${item['end_time']?.toString() ?? 'TBA'}',
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.room, size: 16, color: Colors.grey),
                              const SizedBox(width: 6),
                              Text(
                                'Room: ${item['room_number']?.toString() ?? 'N/A'}',
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (item['day'] != null)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E88E5).withAlpha(30),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          item['day'].toString(),
                          style: const TextStyle(
                            color: Color(0xFF1E88E5),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
            ),
          );
        },
      ),
    );
  }
}
