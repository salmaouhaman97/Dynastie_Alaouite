class Roi {
  final String nom;
  final String dates;
  final String imagePath;
  final String bio;
  final String? bioAr;
  final String? bioEn;
  final String audioPath;

  final List<String>? achievements;
  final List<String>? achievementsAr;
  final List<String>? achievementsEn;

  final String? culturalSignificance;
  final String? culturalSignificanceAr;
  final String? culturalSignificanceEn;

  final List<Map<String, String>>? timeline;

  Roi({
    required this.nom,
    required this.dates,
    required this.imagePath,
    required this.bio,
    this.bioAr,
    this.bioEn,
    required this.audioPath,
    this.achievements,
    this.achievementsAr,
    this.achievementsEn,
    this.culturalSignificance,
    this.culturalSignificanceAr,
    this.culturalSignificanceEn,
    this.timeline,
  });
}
