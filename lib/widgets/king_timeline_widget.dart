import 'package:flutter/material.dart';

class KingTimelineWidget extends StatefulWidget {
  final List<Map<String, String>> timeline;

  const KingTimelineWidget({super.key, required this.timeline});

  @override
  State<KingTimelineWidget> createState() => _KingTimelineWidgetState();
}

class _KingTimelineWidgetState extends State<KingTimelineWidget> {
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    if (widget.timeline.isEmpty) {
      return const Center(
        child: Text(
          'لا توجد أحداث متوفرة حالياً.',
          style: TextStyle(color: Colors.white70, fontFamily: 'Amiri'),
        ),
      );
    }

    return SingleChildScrollView( // This solves the overflow
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            'الجدول الزمني',
            style: TextStyle(
              fontSize: 20,
              color: Color(0xFFFFD700),
              fontWeight: FontWeight.bold,
              fontFamily: 'Amiri',
            ),
          ),
          const SizedBox(height: 16),
          ...widget.timeline.asMap().entries.map((entry) {
            final index = entry.key;
            final event = entry.value;
            final isSelected = index == _selectedIndex;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = isSelected ? null : index;
                });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.black54 : Colors.black87,
                  border: Border.all(
                    color: isSelected ? Colors.amber : Colors.white24,
                    width: isSelected ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFD700),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            event['year'] ?? '',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            event['title'] ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Amiri',
                            ),
                          ),
                        ),
                        Icon(
                          isSelected ? Icons.expand_less : Icons.expand_more,
                          color: Colors.white70,
                        ),
                      ],
                    ),
                    if (isSelected) ...[
                      const SizedBox(height: 8),
                      Text(
                        event['description'] ?? '',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontFamily: 'Amiri',
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
