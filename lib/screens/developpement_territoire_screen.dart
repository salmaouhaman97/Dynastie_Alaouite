import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class DeveloppementTerritoireScreen extends StatefulWidget {
  const DeveloppementTerritoireScreen({super.key});
 @override
 State<DeveloppementTerritoireScreen> createState() => _DeveloppementTerritoireScreenState();
}
class _DeveloppementTerritoireScreenState extends State<DeveloppementTerritoireScreen> {
  late VideoPlayerController _videoController;
  ChewieController? _chewieController;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }
  Future<void> _initializeVideo() async {
    _videoController = VideoPlayerController.asset('assets/videos/alaouite_dynasty.mp4');
    try {
      await _videoController.initialize();
      setState(() {
        _chewieController = ChewieController(
          videoPlayerController: _videoController,
          autoPlay: false,
          looping: false,
          allowFullScreen: true,
          showControls: true,
          materialProgressColors: ChewieProgressColors(
            playedColor: const Color(0xFFFFD700),
            handleColor: const Color(0xFFFFD700),
            backgroundColor: Colors.grey[700]!,
            bufferedColor: Colors.grey[500]!,
          ),
        );
        _isVideoInitialized = true;
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _isVideoInitialized = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _videoController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFF1a1a1a),
        appBar: AppBar(
          backgroundColor: const Color(0xFF2a1810),
          title: const Text(
            'تطور المغرب في العهد العلوي',
            style: TextStyle(
              fontFamily: 'Amiri',
              fontWeight: FontWeight.bold,
              color: Color(0xFFFFD700),
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                

                const SizedBox(height: 24),
                _buildSection(
                  title: 'تطور العلم والخريطة المغربية',
                  icon: Icons.map,
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: _isVideoInitialized && _chewieController != null
                            ? Chewie(controller: _chewieController!)
                            : Container(
                                color: Colors.black,
                                child: Center(
                                  child: _isVideoInitialized
                                      ? const CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFFD700)),
                                        )
                                      : Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Icon(Icons.error_outline, color: Colors.red, size: 40),
                                            const SizedBox(height: 10),
                                            const Text(
                                              'حدث خطأ في تحميل الفيديو',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Amiri',
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                foregroundColor: Colors.black,
                                                backgroundColor: const Color(0xFFFFD700),
                                              ),
                                              onPressed: _initializeVideo,
                                              child: const Text('إعادة المحاولة'),
                                            ),
                                          ],
                                        ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _buildSection(
                  title: 'أهم الأحداث التاريخية',
                  icon: Icons.history_edu,
                  child: Column(
                    children: [
                      _buildHistoricalEvent(
                        date: '1631',
                        title: 'تأسيس الدولة العلوية',
                        description: 'بداية حكم الأشراف العلويين بقيادة المولى علي الشريف في تافيلالت.',
                      ),
                      _buildHistoricalEvent(
                        date: '1672',
                        title: 'عهد مولاي إسماعيل',
                        description: 'بناء مدينة مكناس كعاصمة وفرض سلطة الدولة في كل أنحاء المغرب.',
                      ),
                      _buildHistoricalEvent(
                        date: '1673',
                        title: 'القضاء على حركة الخضر غيلان',
                        description: 'نجح مولاي إسماعيل في القضاء على حركة الخضر غيلان التي كانت تهدد استقرار الدولة.',
                      ),
                      _buildHistoricalEvent(
                        date: '1684',
                        title: 'فتح مدينة المهدية 1682 فتح طنجة 1684م',
                        description: 'نجح مولاي إسماعيل في فتح مدينة المهدية ومدينة طنجة، مما عزز من مكانة الدولة العلوية.',
                      ),
                       _buildHistoricalEvent(
                        date: '1690',
                        title: 'فتح مدينة العرائش 1690 فتح أصيلا 1691م',
                        description: 'نجح مولاي إسماعيل في فتح مدينة العرائش ومدينة أصيلا، مما عزز من مكانة الدولة العلوية.',
                      ),
                      _buildHistoricalEvent(
                        date: '1694-1727',
                        title: 'حصار سبتة الذي دام حوالي 30 عامًا',
                        description: ' يُعتبر أطول حصار في التاريخ. بدأ الحصار في عام 1694 وانتهى عام 1727. خلال هذه الفترة، فرضت القوات المغربية سلسلة من الحصارات على المدينة التي كانت تحت سيطرة إسبانيا',
                      ),
                      _buildHistoricalEvent(
                        date: '1757-1790',
                        title: 'نهج سياسة الانفتاح',
                        description: 'لعب الملك محمد الثالث دورًا كبيرًا في الانفتاح على أوروبا، حيث أرسل بعثات دبلوماسية إلى فرنسا وبريطانيا.',
                      ),
                      _buildHistoricalEvent(
                        date: '1777',
                        title: 'اعتراف الإيالة الشريفة بأمريكا سنة 1777م',
                        description: 'اعترفت الإيالة الشريفة (المغرب) باستقلال الولايات المتحدة الأمريكية عام 1777. كان ذلك من خلال إصدار السلطان محمد الثالث لمنشور يسمح للسفن الأمريكية بدخول الموانئ المغربية. يُعتبر هذا الاعتراف الأول من نوعه من قبل دولة غير أوروبية للولايات المتحدة.',
                      ),
                      _buildHistoricalEvent(
                        date: '1800-1830',
                        title: 'تأسيس أول مدرسة عصرية في المغرب',
                        description: 'في عهد السلطان مولاي سليمان، تم تأسيس أول مدرسة عصرية في فاس لتعليم العلوم الحديثة.',
                      ),
                      _buildHistoricalEvent(
                        date: '1845',
                        title: 'توقيع معاهدة لالة مغنية',
                        description: 'وقعت معاهدة لالة مغنية في 18 مارس 1845 بين المغرب وفرنسا بعد معركة إسلي، وكانت تهدف إلى تحديد الحدود بين المغرب والجزائر التي كانت تحت السيطرة الفرنسية.',
                      ),
                      _buildHistoricalEvent(
                        date: '1864',
                        title: 'إصلاحات محمد الرابع',
                        description: 'أطلق محمد الرابع إصلاحات إدارية واقتصادية لتعزيز الدولة العلوية.',
                      ),
                      _buildHistoricalEvent(
                        date: '1884',
                        title: 'الإحتلال الإسباني للصحراء المغربية',
                        description: 'بدأ الاحتلال الإسباني للصحراء المغربية في عام 1884، حيث قامت إسبانيا بضم المناطق الجنوبية من المغرب.',
                      ),

                      _buildHistoricalEvent(
                        date: '1904',
                        title: 'اتفاقية فرنسية-إسبانية',
                        description: 'تم توقيع اتفاقية بين فرنسا وإسبانيا لتقسيم النفوذ في المغرب، مما أدى إلى زيادة التوترات الدولية.',
                      ),
                      _buildHistoricalEvent(
                        date: '1912',
                        title: 'توقيع معاهدة الحماية',
                        description: 'فرض الحماية الفرنسية على المغرب بعد أزمة دولية، وتقسيم البلاد.',
                      ),

                      _buildHistoricalEvent(
                        date: '1956',
                        title: 'استقلال المغرب',
                        description: 'بقيادة الملك محمد الخامس، استعاد المغرب سيادته بعد مقاومة شعبية شرسة.',
                      ),
                      _buildHistoricalEvent(
                        date: '1975',
                        title: 'المسيرة الخضراء',
                        description: 'شارك فيها 350 ألف مغربي لاسترجاع الأقاليم الجنوبية بطريقة سلمية.',
                      ),
                      _buildHistoricalEvent(
                        date: '1999',
                        title: 'تولي الملك محمد السادس العرش',
                        description: 'بدأ عهد جديد من الإصلاحات السياسية والاقتصادية والاجتماعية.',
                      ),

                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: _buildSection(
                    title: 'التطور الاقتصادي',
                    icon: Icons.trending_up,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // ou end selon besoin
                      children: [
                        _buildDevelopmentItem(
                          title: 'التجارة',
                          description: 'ازدهرت التجارة مع أوروبا خلال القرن 18 و19، خاصة في عهد محمد الثالث.',
                        ),
                        _buildDevelopmentItem(
                          title: 'البنية التحتية',
                          description: 'شهد المغرب تطوراً كبيراً في الموانئ والطرق والسكك الحديدية منذ عهد الحماية.',
                        ),
                        _buildDevelopmentItem(
                          title: 'الصناعة',
                          description: 'تم إنشاء العديد من المصانع في القرن 20، خاصة في مجالات النسيج والصناعات الغذائية.',
                        ),
                        _buildDevelopmentItem(
                          title: 'الفلاحة',
                          description: 'تم إطلاق مخطط المغرب الأخضر سنة 2008 لتحديث القطاع الزراعي.',
                        ),

                        _buildDevelopmentItem(
                          title: 'السياحة',
                          description: 'عرف قطاع السياحة نمواً كبيراً بفضل الإستقرار وجمالية المدن كفاس ومراكش وأكادير.',
                        ),
                        _buildDevelopmentItem(
                          title: 'الطاقة المتجددة',
                          description: 'أطلق المغرب مشاريع ضخمة للطاقة الشمسية والريحية، أبرزها محطة نور بورزازات.',
                        ),
                        _buildDevelopmentItem(
                          title: 'الرقمنة',
                          description: 'شهد المغرب تسارعاً في التحول الرقمي وتوسيع التغطية بالأنترنت والخدمات الرقمية.',
                        ),
                        _buildDevelopmentItem(
                          title: 'التكنولوجيا والابتكار',
                          description: 'تم دعم المشاريع الناشئة والتكنولوجيا الحديثة لتعزيز الابتكار ودفع الاقتصاد الرقمي.',
                        ), 
                        _buildDevelopmentItem(
                          title: 'التمويل والبنوك',
                          description: 'شهد القطاع المالي والمصرفي تطوراً ملحوظاً مع انتشار البنوك والخدمات المالية الإلكترونية.',
                        ),
                       ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFFD700), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFFFFD700)),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFFFFD700),
                  fontSize: 20,
                  fontFamily: 'Amiri',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildHistoricalEvent({
    required String date,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFFFD700),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              date,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Amiri',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontFamily: 'Amiri',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDevelopmentItem({
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Amiri',
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: const TextStyle(
              color: Colors.white70,
              fontFamily: 'Amiri',
            ),
          ),
        ],
      ),
    );
  }
}