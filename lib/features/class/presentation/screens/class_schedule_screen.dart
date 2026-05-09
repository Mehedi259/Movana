import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class ClassScheduleScreen extends StatefulWidget {
  const ClassScheduleScreen({super.key});

  @override
  State<ClassScheduleScreen> createState() => _ClassScheduleScreenState();
}

class _ClassScheduleScreenState extends State<ClassScheduleScreen> {
  String _selectedDay = 'All';
  String _selectedCategory = 'All';

  final List<String> _days = ['All', 'Today', 'Tue-28', 'Wed-29', 'Thu-30'];
  final List<String> _categories = ['All', 'Yoga', 'Pilates', 'Gym', 'HIIT'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Class Schedule'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Day Filter
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _days.length,
              itemBuilder: (context, index) {
                final day = _days[index];
                final isSelected = _selectedDay == day;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(day),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedDay = day;
                      });
                    },
                    backgroundColor: Colors.white,
                    selectedColor: AppColors.primary,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : AppColors.textPrimary,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                    side: BorderSide(
                      color: isSelected ? AppColors.primary : Colors.grey[300]!,
                    ),
                  ),
                );
              },
            ),
          ),
          // Category Filter
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = _selectedCategory == category;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                    backgroundColor: Colors.white,
                    selectedColor: AppColors.primary,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : AppColors.textPrimary,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                    side: BorderSide(
                      color: isSelected ? AppColors.primary : Colors.grey[300]!,
                    ),
                  ),
                );
              },
            ),
          ),
          // Class List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _ClassCard(
                  title: 'Vinyasa Flow Power Hour',
                  studio: 'Zen Studio',
                  instructor: 'Sarah Jenkins',
                  time: 'Today, 08:00 AM - 08:50 AM',
                  credits: 2,
                  category: 'Yoga',
                  spotsLeft: 4,
                  imageColor: Colors.pink[100]!,
                ),
                const SizedBox(height: 12),
                _ClassCard(
                  title: 'Core Reformer Essentials',
                  studio: 'Core Space',
                  instructor: 'Marcus Lin',
                  time: 'Today, 09:30 AM - 10:20 AM',
                  credits: 3,
                  category: 'Pilates',
                  isWaitlist: true,
                  imageColor: Colors.grey[300]!,
                ),
                const SizedBox(height: 12),
                _ClassCard(
                  title: 'Full Body HIIT Burn',
                  studio: 'Iron & Sweat',
                  instructor: 'Coach T',
                  time: 'Today, 12:15 PM - 13:00 PM',
                  credits: 3,
                  category: 'HIIT',
                  isWaitlist: true,
                  imageColor: Colors.orange[200]!,
                ),
                const SizedBox(height: 12),
                _ClassCard(
                  title: 'Vinyasa Flow Power Hour',
                  studio: 'Zen Studio',
                  instructor: 'Sarah Jenkins',
                  time: 'Today, 08:00 AM - 08:50 AM',
                  credits: 2,
                  category: 'Yoga',
                  spotsLeft: 4,
                  imageColor: Colors.pink[100]!,
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
  final Color imageColor;

  const _ClassCard({
    required this.title,
    required this.studio,
    required this.instructor,
    required this.time,
    required this.credits,
    required this.category,
    this.spotsLeft,
    this.isWaitlist = false,
    required this.imageColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          // Image
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: imageColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.fitness_center, size: 40),
          ),
          const SizedBox(width: 12),
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '$studio • $instructor',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 14,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        time,
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.amber[50],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '$credits credits',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (spotsLeft != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red[50],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '$spotsLeft spots left',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Colors.red,
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
                          color: Colors.orange[50],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'Waitlist',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Colors.orange,
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
