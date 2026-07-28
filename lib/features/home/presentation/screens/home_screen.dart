import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../shared/widgets/custom_bottom_nav_bar.dart';
import '../../../profile/services/profile_service.dart';
import '../../services/home_service.dart';
import '../../../../core/constants/api_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;
  String _userName = 'User';
  String _credits = '0';
  String _location = 'Location not set';
  List<dynamic> _classes = [];
  List<dynamic> _studios = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final profileFuture = ProfileService.getProfile();
      final creditsFuture = HomeService.getCreditStatus().catchError((_) => <String, dynamic>{});
      final classesFuture = HomeService.getClasses().catchError((_) => <dynamic>[]);
      final studiosFuture = HomeService.getStudios().catchError((_) => <dynamic>[]);

      final results = await Future.wait([profileFuture, creditsFuture, classesFuture, studiosFuture]);

      if (mounted) {
        setState(() {
          final profile = results[0] as Map<String, dynamic>;
          final creditsData = results[1] as Map<String, dynamic>;
          _classes = results[2] as List<dynamic>;
          _studios = results[3] as List<dynamic>;

          _userName = profile['name']?.toString() ?? 'User';
          _location = profile['location']?.toString() ?? 'Location not set';
          _credits = creditsData['total_available']?.toString() ?? '0';
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error loading home data: $e');
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: _isLoading 
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _fetchData,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 16,
                                color: AppColors.textSecondary,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                              child: Text(
                                _location,
                                style: const TextStyle(
                                  color: Color(0xFF6B7280),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            ],
                          ),
                          const SizedBox(height: 8),
                        Text(
                          'Good Evening, $_userName',
                          style: const TextStyle(
                            color: AppColors.textDark,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.20,
                          ),
                        ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEEEEE),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        '$_credits Credits',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          height: 1.40,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Credits Banner
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.bolt,
                              size: 16,
                              color: AppColors.textDark,
                            ),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                '$_credits credits remaining',
                                style: TextStyle(
                                  color: AppColors.textDark,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  height: 1.33,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () async {
                          await Navigator.pushNamed(context, AppRoutes.plans);
                          if (mounted) {
                            _fetchData();
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '+ Add',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              height: 1.33,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Search Bar
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.searchMap);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      border: Border.all(
                        width: 1,
                        color: AppColors.border,
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          size: 20,
                          color: AppColors.textTertiary,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Search yoga, gym, spa...',
                            style: TextStyle(
                              color: AppColors.textTertiary,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              height: 1.33,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Promo Banner
                Container(
                  width: double.infinity,
                  height: 140,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.25),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'LIMITED OFFER',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  height: 1.33,
                                  letterSpacing: 0.50,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'First Month Free 🎉',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                height: 1.33,
                                letterSpacing: -0.30,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Try Pro plan at no cost. Unlock 40 classes.',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.85),
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                height: 1.33,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Claim Now',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppColors.primaryDark,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      height: 1.33,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Icon(
                                    Icons.arrow_forward,
                                    size: 16,
                                    color: AppColors.primaryDark,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                // Top Categories
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Top Categories',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        height: 1.38,
                      ),
                    ),
                    Text(
                      'See all',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.textDark,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                        height: 1.50,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: const [
                      _CategoryCard(imagePath: 'assets/Yoga.png', label: 'Yoga'),
                      SizedBox(width: 8),
                      _CategoryCard(imagePath: 'assets/Pilates.png', label: 'Pilates'),
                      SizedBox(width: 8),
                      _CategoryCard(imagePath: 'assets/Gym.png', label: 'Gym'),
                      SizedBox(width: 8),
                      _CategoryCard(imagePath: 'assets/Spa.png', label: 'Spa'),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Trending Near You (Classes)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Trending Classes Near You',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        height: 1.38,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.searchMap);
                      },
                      child: Text(
                        'Map view',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textDark,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                          height: 1.60,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                if (_classes.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(child: Text('No classes found')),
                  )
                else
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _classes.map((cls) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: SizedBox(
                          width: 300, // Fixed width for horizontal scrolling classes
                          child: _ClassListItem(
                            name: cls['name']?.toString() ?? 'Class Name',
                            studio: cls['studio_name']?.toString() ?? 'Studio',
                            time: cls['start_time']?.toString() ?? 'Time',
                            credits: '${cls['price'] ?? 0} cr',
                            spotsLeft: '${cls['capacity'] ?? 0} spots left',
                            imagePath: (cls['images'] != null && (cls['images'] as List).isNotEmpty)
                                ? (cls['images'][0]['image'] ?? '')
                                : 'assets/Morning.png',
                            onTap: () {
                              final classId = int.tryParse(cls['id']?.toString() ?? '');
                              if (classId != null) {
                                Navigator.pushNamed(context, AppRoutes.classDetails, arguments: classId);
                              }
                            },
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 24),
                // Recommended Studios
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recommended Studios',
                      style: TextStyle(
                        color: AppColors.textDark,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        height: 1.38,
                      ),
                    ),
                    Text(
                      'See all',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.textDark,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                        height: 1.50,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                if (_studios.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(child: Text('No studios found')),
                  )
                else
                  ..._studios.map((studio) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: _ClassListItem(
                        name: studio['name']?.toString() ?? 'Studio Name',
                        studio: studio['primary_category']?.toString() ?? 'Category',
                        time: studio['full_address']?.toString() ?? 'Near you',
                        credits: '1-3 cr',
                        spotsLeft: 'Open',
                        imagePath: studio['cover_photo'] != null 
                            ? studio['cover_photo'].toString() 
                            : (studio['images'] != null && (studio['images'] as List).isNotEmpty) 
                                ? studio['images'][0]['image'].toString() 
                                : 'assets/ZenFlowStudio.png',
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.studioDetails, arguments: studio['id']);
                        },
                      ),
                    );
                  }),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
    );
  }
}


class _CategoryCard extends StatelessWidget {
  final String imagePath;
  final String label;

  const _CategoryCard({
    required this.imagePath,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 1,
          color: AppColors.border,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            imagePath,
            width: 36,
            height: 36,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 10),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textDark,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              height: 1.40,
            ),
          ),
        ],
      ),
    );
  }
}


class _StudioCard extends StatelessWidget {
  final String name;
  final String category;
  final double rating;
  final String credits;
  final String distance;
  final String imagePath;
  final VoidCallback onTap;

  const _StudioCard({
    required this.name,
    required this.category,
    required this.rating,
    required this.credits,
    required this.distance,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 171,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 12,
              offset: Offset(0, 2),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 110,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    child: imagePath.startsWith('http')
                        ? Image.network(
                            imagePath,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Image.asset(
                              'assets/ZenFlowStudio.png',
                              fit: BoxFit.cover,
                            ),
                          )
                        : Image.asset(
                            imagePath,
                            fit: BoxFit.cover,
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.95),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.star,
                          size: 12,
                          color: Colors.amber,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          rating.toString(),
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            height: 1.50,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ],
                ),
              ),
            ],
          ),
        ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      height: 1.43,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    category,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        credits,
                        style: TextStyle(
                          color: AppColors.textDark,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          height: 1.50,
                        ),
                      ),
                      Text(
                        distance,
                        style: TextStyle(
                          color: AppColors.textTertiary,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          height: 1.50,
                        ),
                      ),
                    ],
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


class _ClassListItem extends StatelessWidget {
  final String name;
  final String studio;
  final String time;
  final String credits;
  final String spotsLeft;
  final String imagePath;
  final VoidCallback onTap;

  const _ClassListItem({
    required this.name,
    required this.studio,
    required this.time,
    required this.credits,
    required this.spotsLeft,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.cardShadow,
              blurRadius: 12,
              offset: Offset(0, 2),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xFFF3F4F1),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: imagePath.startsWith('http')
                    ? Image.network(
                        imagePath,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Image.asset(
                          'assets/ZenFlowStudio.png',
                          fit: BoxFit.cover,
                        ),
                      )
                    : Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: const Color(0xFF191C1A),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 1.38,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$studio • $time',
                    style: TextStyle(
                      color: const Color(0xFF404943),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.successLight,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '⚡$credits',
                          style: TextStyle(
                            color: AppColors.successText,
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            height: 1.60,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: AppColors.borderLight,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          spotsLeft,
                          style: TextStyle(
                            color: const Color(0xFF404943),
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            height: 1.60,
                          ),
                        ),
                      ),
                    ],
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
