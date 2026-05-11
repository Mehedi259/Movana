import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/widgets/custom_bottom_nav_bar.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Booking Setails'),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: AppColors.primary,
          tabs: const [
            Tab(text: 'Upcoming'),
            Tab(text: 'Past'),
            Tab(text: 'Cancelled'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildUpcomingTab(),
          _buildPastTab(),
          _buildCancelledTab(),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2),
    );
  }

  Widget _buildUpcomingTab() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _BookingCard(
          className: 'Reformer Pilates',
          studioName: 'Zen Flow Studio',
          date: 'Mon, Mar 16',
          time: '7:00 AM to 7:30 AM',
          instructor: 'Giovanna',
          location: 'Unit 24, Point Square Shopping, East wall\nRoad, Dublin 1, Ireland',
          credits: '20 credits',
          status: 'Confirmed',
          onViewDetails: () {},
          onCancel: () {},
          onViewMap: () {},
        ),
        const SizedBox(height: 16),
        _BookingCard(
          className: 'Morning Vinyasa',
          studioName: 'Zen Flow Studio',
          date: 'Tue, Mar 17',
          time: '8:30 AM to 9:30 AM',
          instructor: 'Alex',
          location: 'Unit 24, Point Square Shopping, East wall\nRoad, Dublin 1, Ireland',
          credits: '5 credits',
          status: 'Confirmed',
          onViewDetails: () {},
          onCancel: () {},
          onViewMap: () {},
        ),
      ],
    );
  }

  Widget _buildPastTab() {
    return const Center(
      child: Text('No past bookings'),
    );
  }

  Widget _buildCancelledTab() {
    return const Center(
      child: Text('No cancelled bookings'),
    );
  }
}

class _BookingCard extends StatelessWidget {
  final String className;
  final String studioName;
  final String date;
  final String time;
  final String instructor;
  final String location;
  final String credits;
  final String status;
  final VoidCallback onViewDetails;
  final VoidCallback onCancel;
  final VoidCallback onViewMap;

  const _BookingCard({
    required this.className,
    required this.studioName,
    required this.date,
    required this.time,
    required this.instructor,
    required this.location,
    required this.credits,
    required this.status,
    required this.onViewDetails,
    required this.onCancel,
    required this.onViewMap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        className,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        studioName,
                        style: TextStyle(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Text(
                        status,
                        style: TextStyle(
                          color: AppColors.success,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.check_circle,
                        size: 16,
                        color: AppColors.success,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _InfoRow(
              icon: Icons.calendar_today,
              text: '$date • $time',
            ),
            const SizedBox(height: 8),
            _InfoRow(
              icon: Icons.person,
              text: instructor,
            ),
            const SizedBox(height: 8),
            _InfoRow(
              icon: Icons.location_on,
              text: location,
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                credits,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onViewMap,
                icon: const Icon(Icons.location_on),
                label: const Text('View Map'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: onViewDetails,
                    child: const Text('View Details >'),
                  ),
                ),
                TextButton(
                  onPressed: onCancel,
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: AppColors.error),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoRow({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: AppColors.textSecondary),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ),
      ],
    );
  }
}
