import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../models/roi.dart';
import '../widgets/biography_widget.dart';
import '../widgets/king_timeline_widget.dart';

class RoiDetailScreen extends StatefulWidget {
  final Roi roi;
  const RoiDetailScreen({super.key, required this.roi});

  @override
  State<RoiDetailScreen> createState() => _RoiDetailScreenState();
}

class _RoiDetailScreenState extends State<RoiDetailScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _showTitle = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _scrollController.addListener(() {
      if (_scrollController.offset > 150 && !_showTitle) {
        setState(() => _showTitle = true);
      } else if (_scrollController.offset <= 150 && _showTitle) {
        setState(() => _showTitle = false);
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _playAudio() async {
    await _audioPlayer.play(
      AssetSource(widget.roi.audioPath.replaceFirst('assets/', '')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, _) => [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                final isLandscape =
                    constraints.maxWidth > constraints.maxHeight;
                return FlexibleSpaceBar(
                  title: _showTitle ? Text(widget.roi.nom) : null,
                  background: Container(
                    color: Colors.black,
                    child: Image.asset(
                      widget.roi.imagePath,
                      width: double.infinity,
                      height: double.infinity,
                      fit: isLandscape ? BoxFit.contain : BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
        body: Column(
          children: [
            TabBar(
              labelColor: Colors.amber,
              controller: _tabController,
              
              tabs: const [
                Tab(icon: Icon(Icons.language), text: 'Français'),
                Tab(icon: Icon(Icons.language), text: 'العربية'),
                Tab(icon: Icon(Icons.language), text: 'English'),
                Tab(icon: Icon(Icons.timeline), text: 'Chronologie'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Biographie Français
                  BiographyWidget(kingData: {
                    'biography': widget.roi.bio,
                    'achievements': widget.roi.achievements ?? [],
                    'culturalSignificance': widget.roi.culturalSignificance ?? '',
                  }),

                  // Biographie Arabe
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: BiographyWidget(kingData: {
                      'biography': widget.roi.bioAr,
                      'achievements': widget.roi.achievementsAr ?? [],
                      'culturalSignificance': widget.roi.culturalSignificanceAr ?? '',
                    }),
                  ),

                  // Biographie English
                  BiographyWidget(kingData: {
                    'biography': widget.roi.bioEn,
                    'achievements': widget.roi.achievementsEn ?? [],
                    'culturalSignificance': widget.roi.culturalSignificanceEn ?? '',
                  }),

                  // Timeline
                  

                  KingTimelineWidget(
                    
                    timeline: widget.roi.timeline ?? [],
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
