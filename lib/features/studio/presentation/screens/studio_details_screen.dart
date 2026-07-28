import 'package:flutter/material.dart';

class StudioDetailsScreen extends StatefulWidget {
  const StudioDetailsScreen({super.key});

  @override
  State<StudioDetailsScreen> createState() => _StudioDetailsScreenState();
}

class _StudioDetailsScreenState extends State<StudioDetailsScreen> {
  bool _isFavorite = false;
  String _selectedDay = 'TODAY';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Scrollable Content
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60), // Space for app bar
                  // Image Carousel
                  Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 26),
                        height: 320,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: const DecorationImage(
                            image: AssetImage('assets/ZenFlowStudio.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // Image Counter
                      Positioned(
                        bottom: 16,
                        right: 42,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xCC2E312F),
                            borderRadius: BorderRadius.circular(9999),
                          ),
                          child: const Text(
                            '1 / 19',
                            style: TextStyle(
                              color: Color(0xFFEFF1ED),
                              fontSize: 12,
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.60,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Studio Name and Actions
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 26),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                          child: Text(
                            'Zen Flow Studio',
                            style: TextStyle(
                              color: Color(0xFF191C1A),
                              fontSize: 24,
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.w700,
                              height: 1.33,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            // Share Button
                            Container(
                              height: 36,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF2F4F0),
                                borderRadius: BorderRadius.circular(9999),
                              ),
                              child: const Icon(
                                Icons.share_outlined,
                                size: 20,
                                color: Color(0xFF404943),
                              ),
                            ),
                            const SizedBox(width: 8),
                            // Favorite Button
                            GestureDetector(
                              onTap: () {
                                setState(() => _isFavorite = !_isFavorite);
                              },
                              child: Container(
                                width: 36,
                                height: 36,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF2F4F0),
                                  borderRadius: BorderRadius.circular(9999),
                                ),
                                child: Icon(
                                  _isFavorite ? Icons.favorite : Icons.favorite_border,
                                  size: 20,
                                  color: _isFavorite ? Colors.red : const Color(0xFF404943),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Location
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 26),
                    child: Row(
                      children: const [
                        Text(
                          'Camden Court',
                          style: TextStyle(
                            color: Color(0xFF404943),
                            fontSize: 14,
                            fontFamily: 'Lexend',
                            fontWeight: FontWeight.w400,
                            height: 1.43,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          '·',
                          style: TextStyle(
                            color: Color(0xFF707973),
                            fontSize: 16,
                            fontFamily: 'Nunito Sans',
                            fontWeight: FontWeight.w400,
                            height: 1.50,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          '2.4 mi',
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
                  ),
                  const SizedBox(height: 12),
                  // Category Badges
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 26),
                    child: Wrap(
                      spacing: 8,
                      children: const [
                        _CategoryBadge(label: 'Pilates'),
                        _CategoryBadge(label: 'Barre'),
                        _CategoryBadge(label: 'Yoga'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Booking Stats
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 26),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0x4CB1F0CE),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.trending_up,
                            size: 12,
                            color: Color(0xFF0F5238),
                          ),
                          SizedBox(width: 8),
                          Text(
                            '1,000+ bookings this week',
                            style: TextStyle(
                              color: Color(0xFF0F5238),
                              fontSize: 14,
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.w500,
                              height: 1.43,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Videos Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 26),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Videos',
                          style: TextStyle(
                            color: Color(0xFF191C1A),
                            fontSize: 16,
                            fontFamily: 'Lexend',
                            fontWeight: FontWeight.w600,
                            height: 1.38,
                          ),
                        ),
                        const SizedBox(height: 12),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              const _VideoThumbnail(imagePath: 'assets/video thambnail 1.png'),
                              const SizedBox(width: 8),
                              const _VideoThumbnail(imagePath: 'assets/video thambnail 2.png'),
                              const SizedBox(width: 8),
                              const _SeeAllVideos(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Schedule Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 26),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Schedule',
                          style: TextStyle(
                            color: Color(0xFF191C1A),
                            fontSize: 16,
                            fontFamily: 'Lexend',
                            fontWeight: FontWeight.w600,
                            height: 1.38,
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Date Tabs
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFFE1E3DF),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              _DateTab(
                                day: 'TODAY',
                                date: '15',
                                isSelected: _selectedDay == 'TODAY',
                                onTap: () => setState(() => _selectedDay = 'TODAY'),
                              ),
                              _DateTab(
                                day: 'MON',
                                date: '16',
                                isSelected: _selectedDay == 'MON',
                                onTap: () => setState(() => _selectedDay = 'MON'),
                              ),
                              _DateTab(
                                day: 'TUE',
                                date: '17',
                                isSelected: _selectedDay == 'TUE',
                                onTap: () => setState(() => _selectedDay = 'TUE'),
                              ),
                              _DateTab(
                                day: 'WED',
                                date: '18',
                                isSelected: _selectedDay == 'WED',
                                onTap: () => setState(() => _selectedDay = 'WED'),
                              ),
                              _DateTab(
                                day: 'THU',
                                date: '19',
                                isSelected: _selectedDay == 'THU',
                                onTap: () => setState(() => _selectedDay = 'THU'),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Class Cards
                        _ClassTimeCard(
                          time: '17:30',
                          duration: '50 min',
                          className: 'Dynamic Reformer',
                          instructor: 'with Sarah Jenkins',
                          spots: '11 spots',
                          spotsColor: const Color(0xFFD9E6DA),
                          spotsTextColor: const Color(0xFF5B675E),
                        ),
                        const SizedBox(height: 2),
                        _ClassTimeCard(
                          time: '18:30',
                          duration: '45 min',
                          className: 'Vinyasa Flow',
                          instructor: 'with Michael T.',
                          spots: '2 spots',
                          spotsColor: const Color(0xFFFFDAD6),
                          spotsTextColor: const Color(0xFF93000A),
                        ),
                        const SizedBox(height: 2),
                        Opacity(
                          opacity: 0.75,
                          child: _ClassTimeCard(
                            time: '19:30',
                            duration: '60 min',
                            className: 'Restorative Yin',
                            instructor: 'with Emma W.',
                            spots: 'Waitlist',
                            spotsColor: const Color(0xFFE1E3DF),
                            spotsTextColor: const Color(0xFF404943),
                            hasBorder: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Ratings Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 26),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Ratings and reviews',
                              style: TextStyle(
                                color: Color(0xFF191C1A),
                                fontSize: 16,
                                fontFamily: 'Lexend',
                                fontWeight: FontWeight.w600,
                                height: 1.38,
                              ),
                            ),
                            Row(
                              children: const [
                                Text(
                                  'See all',
                                  style: TextStyle(
                                    color: Color(0xFF0F5238),
                                    fontSize: 12,
                                    fontFamily: 'Lexend',
                                    fontWeight: FontWeight.w500,
                                    height: 1.50,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Icon(
                                  Icons.arrow_forward,
                                  size: 12,
                                  color: Color(0xFF0F5238),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FAF6),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x0A000000),
                                blurRadius: 12,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Column(
                                children: const [
                                  Text(
                                    '4.8',
                                    style: TextStyle(
                                      color: Color(0xFF191C1A),
                                      fontSize: 32,
                                      fontFamily: 'Lexend',
                                      fontWeight: FontWeight.w700,
                                      height: 1.19,
                                    ),
                                  ),
                                  Text(
                                    'out of 5',
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
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: List.generate(
                                      5,
                                      (index) => const Icon(
                                        Icons.star,
                                        size: 16,
                                        color: Color(0xFFFFB800),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    'Based on 30k+ ratings',
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // About Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 26),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'About',
                          style: TextStyle(
                            color: Color(0xFF191C1A),
                            fontSize: 16,
                            fontFamily: 'Lexend',
                            fontWeight: FontWeight.w600,
                            height: 1.38,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Zen Flow Studio offers a sanctuary in the heart of the city. We specialize in contemporary Pilates, dynamic Yoga flows, and restorative practices designed tostrengthen the body and calm the mind.',
                          style: TextStyle(
                            color: Color(0xFF404943),
                            fontSize: 12,
                            fontFamily: 'Lexend',
                            fontWeight: FontWeight.w400,
                            height: 1.50,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
            // Fixed App Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 8),
              color: Colors.white,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        size: 16,
                        color: Color(0xFF0B191D),
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      'Studio Detils',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF0B191D),
                        fontSize: 18,
                        fontFamily: 'Nunito Sans',
                        fontWeight: FontWeight.w700,
                        height: 1.11,
                      ),
                    ),
                  ),
                  const SizedBox(width: 24), // Balance the back button
                ],
              ),
            ),
            // Fixed Bottom Button
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.all(26),
                color: Colors.white,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/class-schedule');
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF0B2D1E), Color(0xFF009955)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Text(
                      'View Schedule',
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryBadge extends StatelessWidget {
  final String label;

  const _CategoryBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFD9E6DA),
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF5B675E),
          fontSize: 12,
          fontFamily: 'Lexend',
          fontWeight: FontWeight.w400,
          height: 1.50,
          letterSpacing: 0.60,
        ),
      ),
    );
  }
}

class _VideoThumbnail extends StatelessWidget {
  final String imagePath;

  const _VideoThumbnail({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 171,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: imagePath.startsWith('http')
              ? NetworkImage(imagePath) as ImageProvider
              : AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.20),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.90),
              borderRadius: BorderRadius.circular(9999),
            ),
            child: const Icon(
              Icons.play_arrow,
              color: Color(0xFF0F5238),
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}

class _SeeAllVideos extends StatelessWidget {
  const _SeeAllVideos();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 171,
      height: 100,
      decoration: BoxDecoration(
        color: const Color(0xFFECEEEA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: Text(
          'See all 12',
          style: TextStyle(
            color: Color(0xFF0F5238),
            fontSize: 14,
            fontFamily: 'Lexend',
            fontWeight: FontWeight.w500,
            height: 1.50,
          ),
        ),
      ),
    );
  }
}

class _DateTab extends StatelessWidget {
  final String day;
  final String date;
  final bool isSelected;
  final VoidCallback onTap;

  const _DateTab({
    required this.day,
    required this.date,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            border: isSelected
                ? const Border(
                    bottom: BorderSide(
                      color: Color(0xFF0F5238),
                      width: 2,
                    ),
                  )
                : null,
          ),
          child: Column(
            children: [
              Text(
                day,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isSelected ? const Color(0xFF0F5238) : const Color(0xFF404943),
                  fontSize: 12,
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w600,
                  height: 1.50,
                  letterSpacing: 0.60,
                ),
              ),
              Text(
                date,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isSelected ? const Color(0xFF0F5238) : const Color(0xFF404943),
                  fontSize: 22,
                  fontFamily: 'Lexend',
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                  height: 1.27,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ClassTimeCard extends StatelessWidget {
  final String time;
  final String duration;
  final String className;
  final String instructor;
  final String spots;
  final Color spotsColor;
  final Color spotsTextColor;
  final bool hasBorder;

  const _ClassTimeCard({
    required this.time,
    required this.duration,
    required this.className,
    required this.instructor,
    required this.spots,
    required this.spotsColor,
    required this.spotsTextColor,
    this.hasBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAF6),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 12,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Time Section
          SizedBox(
            width: 60,
            child: Column(
              children: [
                Text(
                  time,
                  style: const TextStyle(
                    color: Color(0xFF191C1A),
                    fontSize: 16,
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w600,
                    height: 1.38,
                  ),
                ),
                Text(
                  duration,
                  style: const TextStyle(
                    color: Color(0xFF404943),
                    fontSize: 14,
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w400,
                    height: 1.43,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Divider
          Container(
            width: 1,
            height: 40,
            color: const Color(0x7FBFC9C1),
          ),
          const SizedBox(width: 16),
          // Class Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  className,
                  style: const TextStyle(
                    color: Color(0xFF191C1A),
                    fontSize: 15,
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w600,
                    height: 1.50,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  instructor,
                  style: const TextStyle(
                    color: Color(0xFF404943),
                    fontSize: 14,
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ],
            ),
          ),
          // Spots Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: spotsColor,
              borderRadius: BorderRadius.circular(6),
              border: hasBorder
                  ? Border.all(
                      color: const Color(0xFFBFC9C1),
                      width: 1,
                    )
                  : null,
            ),
            child: Text(
              spots,
              style: TextStyle(
                color: spotsTextColor,
                fontSize: 12,
                fontFamily: 'Lexend',
                fontWeight: FontWeight.w400,
                height: 1.50,
                letterSpacing: 0.60,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
