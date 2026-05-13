import 'package:flutter/material.dart';

class ClassScheduleScreen extends StatefulWidget {
  const ClassScheduleScreen({super.key});

  @override
  State<ClassScheduleScreen> createState() => _ClassScheduleScreenState();
}

class _ClassScheduleScreenState extends State<ClassScheduleScreen> {
  String _selectedDay = 'All';

  final List<String> _days = ['All', 'Today', 'Tue-28', 'Wed-29', 'Thu-30'];
  final List<String> _categories = ['Yoga', 'Pilates', 'Gym', 'HIIT', 'Spin'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Container(
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
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Class Shedule',
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
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          // Day Filter
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 26),
              itemCount: _days.length,
              itemBuilder: (context, index) {
                final day = _days[index];
                final isSelected = _selectedDay == day;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDay = day;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 9,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF2D6A4F)
                            : Colors.white,
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF2D6A4F)
                              : const Color(0xFFBFC9C1),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      child: Center(
                        child: Text(
                          day,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : const Color(0xFF404943),
                            fontSize: 14,
                            fontFamily: 'Lexend',
                            fontWeight: FontWeight.w400,
                            height: 1.43,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          // Category Filter
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 26),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: () {
                      // Category filter action
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFFBFC9C1),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          category,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFF191C1A),
                            fontSize: 16,
                            fontFamily: 'Lexend',
                            fontWeight: FontWeight.w400,
                            height: 1.50,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          // Class List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 26),
              children: const [
                _ClassCard(
                  title: 'Vinyasa Flow Power Hour',
                  studio: 'Zen Studio',
                  instructor: 'Sarah Jenkins',
                  time: 'Today, 08:00 AM – 08:50 AM',
                  credits: 2,
                  category: 'Yoga',
                  spotsLeft: 4,
                  imagePath: 'assets/Vinyasa Flow Power Hour.png',
                ),
                SizedBox(height: 8),
                _ClassCard(
                  title: 'Core Reformer Essentials',
                  studio: 'Core Space',
                  instructor: 'Marcus Lin',
                  time: 'Today, 09:30 AM – 10:20 AM',
                  credits: 3,
                  category: 'Pilates',
                  isWaitlist: true,
                  imagePath: 'assets/Core Reformer Essentials.png',
                ),
                SizedBox(height: 8),
                _ClassCard(
                  title: 'Full Body HIIT Burn',
                  studio: 'Iron & Sweat',
                  instructor: 'Coach T',
                  time: 'Today, 12:15 PM – 13:00 PM',
                  credits: 3,
                  category: 'HIIT',
                  isWaitlist: true,
                  imagePath: 'assets/Full Body HIIT Burn.png',
                ),
                SizedBox(height: 8),
                _ClassCard(
                  title: 'Vinyasa Flow Power Hour',
                  studio: 'Zen Studio',
                  instructor: 'Sarah Jenkins',
                  time: 'Today, 08:00 AM – 08:50 AM',
                  credits: 2,
                  category: 'Yoga',
                  spotsLeft: 4,
                  imagePath: 'assets/Vinyasa Flow Power Hour.png',
                ),
                SizedBox(height: 8),
                _ClassCard(
                  title: 'Core Reformer Essentials',
                  studio: 'Core Space',
                  instructor: 'Marcus Lin',
                  time: 'Today, 09:30 AM – 10:20 AM',
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
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAF6),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 12,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
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
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF191C1A),
                    fontSize: 16,
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  '$studio · $instructor',
                  style: const TextStyle(
                    color: Color(0xFF404943),
                    fontSize: 14,
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w400,
                    height: 1.43,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 16,
                      color: Color(0xFF404943),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        time,
                        style: const TextStyle(
                          color: Color(0xFF404943),
                          fontSize: 12,
                          fontFamily: 'Lexend',
                          fontWeight: FontWeight.w400,
                          height: 1.50,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD9E6DA),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '$credits credits',
                        style: const TextStyle(
                          color: Color(0xFF5B675E),
                          fontSize: 12,
                          fontFamily: 'Lexend',
                          fontWeight: FontWeight.w400,
                          height: 1.50,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFFBFC9C1),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        category,
                        style: const TextStyle(
                          color: Color(0xFF404943),
                          fontSize: 12,
                          fontFamily: 'Lexend',
                          fontWeight: FontWeight.w400,
                          height: 1.50,
                        ),
                      ),
                    ),
                    if (spotsLeft != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0x338D4D4E),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '$spotsLeft spots left',
                          style: const TextStyle(
                            color: Color(0xFF713638),
                            fontSize: 12,
                            fontFamily: 'Lexend',
                            fontWeight: FontWeight.w400,
                            height: 1.50,
                          ),
                        ),
                      ),
                    if (isWaitlist)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0x338D4D4E),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'Waitlist',
                          style: TextStyle(
                            color: Color(0xFF713638),
                            fontSize: 12,
                            fontFamily: 'Lexend',
                            fontWeight: FontWeight.w400,
                            height: 1.50,
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
    );
  }
}
