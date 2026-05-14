import 'package:flutter/material.dart';
import '../../../../core/constants/app_routes.dart';

class ClassScheduleScreen extends StatefulWidget {
  const ClassScheduleScreen({super.key});

  @override
  State<ClassScheduleScreen> createState() => _ClassScheduleScreenState();
}

class _ClassScheduleScreenState extends State<ClassScheduleScreen> {
  String _selectedDay = 'Today';
  String _selectedCategory = 'All';

  final List<String> _days = ['All', 'Today', 'Tue-28', 'Wed-29', 'Thu-30', 'Fri-31'];
  final List<String> _categories = ['All', 'Yoga', 'Pilates', 'Gym', 'HIIT', 'Spin'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9FAFB),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Center(
            child: InkWell(
              onTap: () => Navigator.pop(context),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 18,
                  color: Color(0xFF111827),
                ),
              ),
            ),
          ),
        ),
        title: const Text(
          'Class Schedule',
          style: TextStyle(
            color: Color(0xFF111827),
            fontSize: 20,
            fontFamily: 'Nunito Sans',
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.calendar_month_outlined,
              color: Color(0xFF111827),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          // Day Filter
          SizedBox(
            height: 76,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _days.length,
              itemBuilder: (context, index) {
                final day = _days[index];
                final isSelected = _selectedDay == day;
                
                String topText = '';
                String bottomText = '';
                
                if (day.contains('-')) {
                  final parts = day.split('-');
                  topText = parts[0];
                  bottomText = parts[1];
                } else {
                  topText = day;
                }

                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDay = day;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 68,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF2D6A4F)
                            : Colors.white,
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF2D6A4F)
                              : const Color(0xFFE5E7EB),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: const Color(0xFF2D6A4F).withValues(alpha: 0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                )
                              ]
                            : [],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            topText,
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white.withValues(alpha: 0.9)
                                  : const Color(0xFF6B7280),
                              fontSize: 13,
                              fontFamily: 'Lexend',
                              fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                            ),
                          ),
                          if (bottomText.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text(
                              bottomText,
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : const Color(0xFF111827),
                                fontSize: 16,
                                fontFamily: 'Lexend',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          // Category Filter
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = _selectedCategory == category;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF191C1A) : Colors.white,
                        border: Border.all(
                          color: isSelected ? const Color(0xFF191C1A) : const Color(0xFFE5E7EB),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(99),
                      ),
                      child: Center(
                        child: Text(
                          category,
                          style: TextStyle(
                            color: isSelected ? Colors.white : const Color(0xFF4B5563),
                            fontSize: 14,
                            fontFamily: 'Lexend',
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          
          // Header for list
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_selectedDay == 'All' ? 'Upcoming' : _selectedDay} Classes',
                  style: const TextStyle(
                    color: Color(0xFF111827),
                    fontSize: 18,
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Text(
                  '5 Results',
                  style: TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 14,
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          
          // Class List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 32),
              children: const [
                _ClassCard(
                  title: 'Vinyasa Flow Power Hour',
                  studio: 'Zen Studio',
                  instructor: 'Sarah Jenkins',
                  time: '08:00 AM – 08:50 AM',
                  credits: 2,
                  category: 'Yoga',
                  spotsLeft: 4,
                  imagePath: 'assets/Vinyasa Flow Power Hour.png',
                ),
                SizedBox(height: 16),
                _ClassCard(
                  title: 'Core Reformer Essentials',
                  studio: 'Core Space',
                  instructor: 'Marcus Lin',
                  time: '09:30 AM – 10:20 AM',
                  credits: 3,
                  category: 'Pilates',
                  isWaitlist: true,
                  imagePath: 'assets/Core Reformer Essentials.png',
                ),
                SizedBox(height: 16),
                _ClassCard(
                  title: 'Full Body HIIT Burn',
                  studio: 'Iron & Sweat',
                  instructor: 'Coach T',
                  time: '12:15 PM – 01:00 PM',
                  credits: 3,
                  category: 'HIIT',
                  isWaitlist: true,
                  imagePath: 'assets/Full Body HIIT Burn.png',
                ),
                SizedBox(height: 16),
                _ClassCard(
                  title: 'Vinyasa Flow Power Hour',
                  studio: 'Zen Studio',
                  instructor: 'Sarah Jenkins',
                  time: '08:00 AM – 08:50 AM',
                  credits: 2,
                  category: 'Yoga',
                  spotsLeft: 4,
                  imagePath: 'assets/Vinyasa Flow Power Hour.png',
                ),
                SizedBox(height: 16),
                _ClassCard(
                  title: 'Core Reformer Essentials',
                  studio: 'Core Space',
                  instructor: 'Marcus Lin',
                  time: '09:30 AM – 10:20 AM',
                  credits: 3,
                  category: 'Pilates',
                  isWaitlist: true,
                  imagePath: 'assets/Core Reformer Essentials.png',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ClassCard extends StatelessWidget {
  final String title;
  final String studio;
  final String instructor;
  final String time;
  final int credits;
  final String category;
  final int? spotsLeft;
  final bool isWaitlist;
  final String imagePath;

  const _ClassCard({
    required this.title,
    required this.studio,
    required this.instructor,
    required this.time,
    required this.credits,
    required this.category,
    this.spotsLeft,
    this.isWaitlist = false,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: const Color(0xFF000000).withValues(alpha: 0.01),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
        border: Border.all(
          color: const Color(0xFFF3F4F6),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.classDetails);
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image
                      Container(
                        width: 88,
                        height: 88,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                            image: AssetImage(imagePath),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    title,
                                    style: const TextStyle(
                                      color: Color(0xFF111827),
                                      fontSize: 16,
                                      fontFamily: 'Lexend',
                                      fontWeight: FontWeight.w600,
                                      height: 1.3,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(
                                  Icons.bookmark_border_rounded,
                                  size: 22,
                                  color: Color(0xFF9CA3AF),
                                )
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '$studio • $instructor',
                              style: const TextStyle(
                                color: Color(0xFF6B7280),
                                fontSize: 13,
                                fontFamily: 'Lexend',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF3F4F6),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: const Icon(
                                    Icons.access_time_rounded,
                                    size: 14,
                                    color: Color(0xFF4B5563),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    time,
                                    style: const TextStyle(
                                      color: Color(0xFF374151),
                                      fontSize: 13,
                                      fontFamily: 'Lexend',
                                      fontWeight: FontWeight.w500,
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
                  const SizedBox(height: 16),
                  const Divider(height: 1, color: Color(0xFFF3F4F6)),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Wrap(
                        spacing: 8,
                        children: [
                          _buildTag(
                            '$credits credits',
                            const Color(0xFFECFDF5),
                            const Color(0xFF059669),
                          ),
                          _buildTag(
                            category,
                            const Color(0xFFF3F4F6),
                            const Color(0xFF4B5563),
                          ),
                        ],
                      ),
                      if (spotsLeft != null)
                        _buildTag(
                          '$spotsLeft spots left',
                          const Color(0xFFFEF2F2),
                          const Color(0xFFDC2626),
                        )
                      else if (isWaitlist)
                        _buildTag(
                          'Waitlist',
                          const Color(0xFFFFF7ED),
                          const Color(0xFFEA580C),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTag(String text, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontFamily: 'Lexend',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

