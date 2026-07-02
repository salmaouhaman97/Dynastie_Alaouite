import 'package:flutter/material.dart';

class BiographyWidget extends StatelessWidget {
  final Map<String, dynamic> kingData;

  const BiographyWidget({super.key, required this.kingData});

  void _shareText(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Texte copié et prêt à partager'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Biography Section
          if (kingData['biography'] != null && kingData['biography'].isNotEmpty)
            _buildSection(
              context,
              title: 'Biographie',
              icon: Icons.menu_book,
              content: kingData['biography'],
            ),

          const SizedBox(height: 16),

          // Achievements Section
          if (kingData['achievements'] != null &&
              (kingData['achievements'] as List).isNotEmpty)
            _buildAchievementsSection(context, kingData['achievements']),

          const SizedBox(height: 16),

          // Cultural Significance Section
          if (kingData['culturalSignificance'] != null &&
              kingData['culturalSignificance'].isNotEmpty)
            _buildSection(
              context,
              title: 'Signification Culturelle',
              icon: Icons.public,
              content: kingData['culturalSignificance'],
            ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context,
      {required String title, required IconData icon, required String content}) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[700]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.amber),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onLongPress: () => _shareText(context, content),
            child: SelectableText(
              content,
              style: const TextStyle(
                fontSize: 16,
                height: 1.6,
                color: Colors.white,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }

 Widget _buildAchievementsSection(BuildContext context, List<String> achievements) {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey[900],
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey[700]!),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.emoji_events, color: Colors.amber),
            const SizedBox(width: 8),
            const Text(
              'Réalisations Principales',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.amber,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ...achievements.map((achievement) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.circle, size: 8, color: Colors.amber),
                const SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onLongPress: () => _shareText(context, achievement),
                    child: SelectableText(
                      achievement,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.4,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    ),
  );
}
}