import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_routes.dart';

class ClassDetailsScreen extends StatefulWidget {
  const ClassDetailsScreen({super.key});

  @override
  State<ClassDetailsScreen> createState() => _ClassDetailsScreenState();
}

class _ClassDetailsScreenState extends State<ClassDetailsScreen> {
  bool _isFavorite = false;
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> _classImages = [
    'assets/Reformer Pilates.png',
    'assets/Core Reformer Essentials.png',
    'assets/Vinyasa Flow Power Hour.png',
    'assets/Full Body HIIT Burn.png',
    'assets/Morning.png',
    'assets/Kickboxing.png',
    'assets/video thambnail 1.png',
    'assets/video thambnail 2.png',
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // Custom App Bar overlaid on top of the image
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: Colors.white,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Center(
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 16,
                      color: Color(0xFF0B191D),
                    ),
                  ),
                ),
              ),
            ),
            title: const Text(
              'Class Details',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF0B191D),
                fontSize: 18,
                fontFamily: 'Nunito Sans',
                fontWeight: FontWeight.w700,
                height: 1.11,
              ),
            ),
            centerTitle: true,
            actions: [
              GestureDetector(
                onTap: () {
                  // Share action
                },
                child: Container(
                  padding: const EdgeInsets.all(4),
                  child: const Icon(
                    Icons.ios_share_outlined,
                    size: 22,
                    color: Color(0xFF0B191D),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  setState(() => _isFavorite = !_isFavorite);
                },
                child: Container(
                  padding: const EdgeInsets.all(4),
                  child: Icon(
                    _isFavorite ? Icons.favorite : Icons.favorite_border,
                    size: 23,
                    color: _isFavorite ? Colors.red : const Color(0xFF0B191D),
                  ),
                ),
              ),
              const SizedBox(width: 16),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 56),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 26),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Stack(
                        children: [
                          // Image PageView
                          PageView.builder(
                            controller: _pageController,
                            itemCount: _classImages.length,
                            onPageChanged: (index) {
                              setState(() => _currentPage = index);
                            },
                            itemBuilder: (context, index) {
                              return Image.asset(
                                _classImages[index],
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              );
                            },
                          ),
                          // Page indicator badge
                          Positioned(
                            right: 16,
                            bottom: 16,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.60),
                                borderRadius: BorderRadius.circular(9999),
                              ),
                              child: Text(
                                '${_currentPage + 1}/${_classImages.length}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Lexend',
                                  fontWeight: FontWeight.w500,
                                  height: 1.50,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Main Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  // ── Class Title + Rating ──
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Reformer Pilates',
                              style: TextStyle(
                                color: Color(0xFF191C1A),
                                fontSize: 24,
                                fontFamily: 'Lexend',
                                fontWeight: FontWeight.w700,
                                height: 1.33,
                              ),
                            ),
                            const SizedBox(height: 8),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.studioDetails);
                              },
                              child: Row(
                                children: [
                                  const Expanded(
                                    child: Text(
                                      'Camden Court · Zen Flow Studio',
                                      style: TextStyle(
                                        color: Color(0xFF0F5238),
                                        fontSize: 16,
                                        fontFamily: 'Lexend',
                                        fontWeight: FontWeight.w500,
                                        height: 1.38,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Icon(
                                    Icons.chevron_right,
                                    size: 18,
                                    color: const Color(0xFF0F5238),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Rating badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F4),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star,
                              size: 16,
                              color: Color(0xFFF59E0B),
                            ),
                            SizedBox(width: 4),
                            Text(
                              '4.8',
                              style: TextStyle(
                                color: Color(0xFF111827),
                                fontSize: 14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                height: 1.43,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // ── Schedule & Instructor Card ──
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAF6),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFE1E3DF),
                        width: 1,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x0A000000),
                          blurRadius: 12,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Date & Time row
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Calendar icon circle
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: const Color(0xFFECEEEA),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.calendar_today_outlined,
                                size: 20,
                                color: Color(0xFF404943),
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Date & time text
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Mon, Mar 16',
                                    style: TextStyle(
                                      color: Color(0xFF191C1A),
                                      fontSize: 16,
                                      fontFamily: 'Lexend',
                                      fontWeight: FontWeight.w500,
                                      height: 1.50,
                                    ),
                                  ),
                                  Text(
                                    '7:00 AM – 7:50 AM',
                                    style: TextStyle(
                                      color: Color(0xFF404943),
                                      fontSize: 16,
                                      fontFamily: 'Lexend',
                                      fontWeight: FontWeight.w400,
                                      height: 1.50,
                                    ),
                                  ),
                                  Text(
                                    '(50 min)',
                                    style: TextStyle(
                                      color: Color(0xFF404943),
                                      fontSize: 16,
                                      fontFamily: 'Lexend',
                                      fontWeight: FontWeight.w400,
                                      height: 1.50,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Add to calendar button
                            GestureDetector(
                              onTap: () {
                                // Add to calendar action
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFECFDF5),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: const Color(0xFF065F46)
                                        .withValues(alpha: 0.2),
                                    width: 1,
                                  ),
                                ),
                                child: const Text(
                                  'Add to\ncalendar',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF065F46),
                                    fontSize: 12,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                    height: 1.33,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),
                        const Divider(
                          height: 1,
                          color: Color(0xFFE1E3DF),
                        ),
                        const SizedBox(height: 16),

                        // Instructor row
                        Row(
                          children: [
                            // Instructor avatar
                            ClipRRect(
                              borderRadius: BorderRadius.circular(9999),
                              child: Image.asset(
                                'assets/Instructor Giovanna.png',
                                width: 42,
                                height: 42,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Giovanna Williams',
                                    style: TextStyle(
                                      color: Color(0xFF191C1A),
                                      fontSize: 16,
                                      fontFamily: 'Lexend',
                                      fontWeight: FontWeight.w500,
                                      height: 1.38,
                                    ),
                                  ),
                                  Text(
                                    'Instructor',
                                    style: TextStyle(
                                      color: Color(0xFF404943),
                                      fontSize: 16,
                                      fontFamily: 'Lexend',
                                      fontWeight: FontWeight.w400,
                                      height: 1.38,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ── Details Section ──
                  const Text(
                    'Details',
                    style: TextStyle(
                      color: Color(0xFF191C1A),
                      fontSize: 17,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w600,
                      height: 1.40,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Experience a full-body workout designed to improve strength, flexibility, and posture. Using the reformer machine, this class focuses on slow, controlled movements that engage your deep core muscles. Suitable for all levels, modifications will be provided throughout.',
                    style: TextStyle(
                      color: Color(0xFF404943),
                      fontSize: 16,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ── How to prepare ──
                  const Text(
                    'How to prepare',
                    style: TextStyle(
                      color: Color(0xFF111827),
                      fontSize: 17,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w700,
                      height: 1.56,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Warning box
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFBEB),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFFEF3C7),
                        width: 1,
                      ),
                    ),
                    child: const Text(
                      'Please arrive 10 minutes before the class starts to get settled.',
                      style: TextStyle(
                        color: Color(0xFF78350F),
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        height: 1.63,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ── What to bring ──
                  const Text(
                    'What to bring',
                    style: TextStyle(
                      color: Color(0xFF191C1A),
                      fontSize: 17,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w600,
                      height: 1.40,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildBringItem('Yoga mat'),
                  const SizedBox(height: 8),
                  _buildBringItem('Water'),
                  const SizedBox(height: 8),
                  _buildBringItem('Grip socks (Required)'),

                  const SizedBox(height: 24),

                  // ── Amenities ──
                  const Text(
                    'Amenities',
                    style: TextStyle(
                      color: Color(0xFF111827),
                      fontSize: 17,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w700,
                      height: 1.56,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildAmenityItem(Icons.shower_outlined, 'SHOWER'),
                      const SizedBox(width: 24),
                      _buildAmenityItem(Icons.lock_outline, 'LOCKERS'),
                      const SizedBox(width: 24),
                      _buildAmenityItem(
                          Icons.local_parking_outlined, 'PARKING'),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // ── How to get there ──
                  const Text(
                    'How to get there',
                    style: TextStyle(
                      color: Color(0xFF111827),
                      fontSize: 17,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w700,
                      height: 1.56,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '123 Camden Court, Dublin 2, Ireland',
                    style: TextStyle(
                      color: Color(0xFF4B5563),
                      fontSize: 13,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 1.43,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Map placeholder
                  Container(
                    width: double.infinity,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xFFA3A3A3),
                        width: 1,
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.location_on,
                        size: 36,
                        color: Color(0xFF2D6A4F),
                      ),
                    ),
                  ),

                  // Bottom padding for the reserve bar
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),

      // ── Sticky Bottom Reserve Bar ──
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xF2F8FAF6),
          boxShadow: [
            BoxShadow(
              color: const Color(0x0C000000),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Credits info
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    '2 credits',
                    style: TextStyle(
                      color: Color(0xFF191C1A),
                      fontSize: 16,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w600,
                      height: 1.38,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Cancellation policy applies',
                    style: TextStyle(
                      color: Color(0xFF404943),
                      fontSize: 14,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w400,
                      height: 1.43,
                    ),
                  ),
                ],
              ),
              // Reserve button
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.reservation);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Text(
                    'Reserve',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w600,
                      height: 1.50,
                      letterSpacing: 0.40,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Helper: "What to bring" check-item ──
  Widget _buildBringItem(String text) {
    return Row(
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: const Color(0xFFECFDF5),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.check,
            size: 14,
            color: Color(0xFF059669),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          text,
          style: const TextStyle(
            color: Color(0xFF404943),
            fontSize: 16,
            fontFamily: 'Lexend',
            fontWeight: FontWeight.w400,
            height: 1.50,
          ),
        ),
      ],
    );
  }

  // ── Helper: Amenity icon with label ──
  Widget _buildAmenityItem(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: const Color(0xFFF9FAFB),
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFFF3F4F6),
              width: 1,
            ),
          ),
          child: Icon(
            icon,
            size: 22,
            color: const Color(0xFF6B7280),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF6B7280),
            fontSize: 10,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            height: 1.50,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}
