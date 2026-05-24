import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/grades_provider.dart';

class MarksEntryScreen extends ConsumerStatefulWidget {
  const MarksEntryScreen({super.key});

  @override
  ConsumerState<MarksEntryScreen> createState() => _MarksEntryScreenState();
}

class _MarksEntryScreenState extends ConsumerState<MarksEntryScreen> {
  // Holds local modifications before blasting them to the cloud database
  List<Map<String, dynamic>> localChanges = [];

  // Helper utility to automatically calculate rolling letter tiers on the fly
  String _calculateGrade(int score) {
    if (score >= 90) return 'A+';
    if (score >= 80) return 'A';
    if (score >= 70) return 'B';
    if (score >= 60) return 'C';
    return 'D';
  }

  Color _getGradeColor(String grade) {
    if (grade == 'A+') return const Color(0xFF1E88E5);
    if (grade == 'A') return Colors.green;
    if (grade == 'B') return Colors.orange;
    if (grade == 'C') return Colors.deepOrange;
    return Colors.redAccent;
  }

  @override
  Widget build(BuildContext context) {
    // Watch the live async data state stream
    final gradesAsync = ref.watch(gradesProvider);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : const Color(0xFFF0F7FF),
      appBar: AppBar(
        title: const Text(
          "Teacher Marks Portal",
          style: TextStyle(fontFamily: 'NUSAR', fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: gradesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: Color(0xFF1E88E5))),
        error: (err, _) => Center(child: Text('Error loading portal: $err', style: const TextStyle(fontFamily: 'Poppins'))),
        data: (originalList) {
          // Deep-copy incoming server values into our editable state array exactly once
          if (localChanges.isEmpty && originalList.isNotEmpty) {
            localChanges = List<Map<String, dynamic>>.from(
              originalList.map((item) => Map<String, dynamic>.from(item as Map))
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(20.0),
                  itemCount: localChanges.length,
                  itemBuilder: (context, index) {
                    final currentItem = localChanges[index];
                    return _GradeRow(
                      item: currentItem,
                      isDarkMode: isDarkMode,
                      getGradeColor: _getGradeColor,
                      calculateGrade: _calculateGrade,
                      onScoreChanged: (newScore) {
                        currentItem['score'] = newScore;
                        currentItem['grade'] = _calculateGrade(newScore);
                      },
                    );
                  },
                ),
              ),
              // Complete Batch Submission Bar
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E88E5), // Vibrant performance blue
                      foregroundColor: Colors.white,
                      elevation: 0, // Flat
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    icon: const Icon(Icons.cloud_upload, color: Colors.white),
                    label: const Text('Save & Broadcast via RPC', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Poppins', color: Colors.white)),
                    onPressed: () async {
                      // Dispatches the entire modified map collection payload at once
                      await ref.read(gradesProvider.notifier).updateMarks(localChanges);
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Grades successfully broadcasted and synced across app!', style: TextStyle(fontFamily: 'Poppins'))),
                        );
                        context.pop(); // Returns back safely to the dashboard
                      }
                    },
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class _GradeRow extends StatefulWidget {
  final Map<String, dynamic> item;
  final bool isDarkMode;
  final Color Function(String) getGradeColor;
  final String Function(int) calculateGrade;
  final Function(int) onScoreChanged;

  const _GradeRow({
    required this.item,
    required this.isDarkMode,
    required this.getGradeColor,
    required this.calculateGrade,
    required this.onScoreChanged,
  });

  @override
  State<_GradeRow> createState() => _GradeRowState();
}

class _GradeRowState extends State<_GradeRow> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: '${widget.item['score']}');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String currentGrade = widget.item['grade'] ?? 'D';

    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: widget.isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: widget.isDarkMode ? Colors.black.withAlpha(120) : Colors.grey.withAlpha(40),
            blurRadius: 15,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.item['subject'] ?? '',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, fontFamily: 'Poppins', color: widget.isDarkMode ? Colors.white : Colors.black),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: widget.isDarkMode ? Colors.black26 : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: widget.isDarkMode ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 14),
                          ),
                          onChanged: (newValue) {
                            int parsed = int.tryParse(newValue) ?? 0;
                            if (parsed > 100) {
                              parsed = 100;
                              _controller.text = '100';
                              _controller.selection = TextSelection.fromPosition(const TextPosition(offset: 3));
                            }
                            widget.onScoreChanged(parsed);
                            setState(() {
                              currentGrade = widget.calculateGrade(parsed);
                              widget.item['grade'] = currentGrade;
                            });
                          },
                        ),
                      ),
                      Text(
                        '/100',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: widget.getGradeColor(currentGrade),
                  borderRadius: BorderRadius.circular(6), // Compact rectangular block with 6px border radius
                ),
                child: Text(
                  currentGrade,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}