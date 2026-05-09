import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_routes.dart';

class BookingDetailsScreen extends StatefulWidget {
  const BookingDetailsScreen({super.key});

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
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
        title: const Text('Booking Details'),
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
    );
  }

  Widget _buildUpcomingTab() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _BookingCard(
          title: 'Vinyasa Flow',
          studio: 'Zen Flow Studio',
          date: 'Tomorrow, 8:00 AM',
          instructor: 'Sarah Chen',
          credits: 2,
          status: 'Confirmed',
          statusColor: AppColors.success,
          onViewDetails: () {},
          onCancel: () {},
        ),
      ],
    );
  }

  Widget _buildPastTab() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _BookingCard(
          title: 'Reformer Pilates',
          studio: 'Zen Flow Studio',
          date: 'Oct 12, 2023 • 9:00 AM',
          instructor: 'Giovanna',
          credits: 20,
          status: 'Completed',
          statusColor: AppColors.success,
          onViewDetails: () {},
          onLeaveReview: () {
            Navigator.pushNamed(context, AppRoutes.review);
          },
        ),
        const SizedBox(height: 16),
        _BookingCard(
          title: 'HIIT Burnout',
          studio: 'Iron Vault Gym',
          date: 'Oct 05, 2023 • 5:30 PM',
          instructor: 'Marcus T.',
          credits: 15,
          status: 'Completed',
          statusColor: AppColors.success,
          onViewDetails: () {},
          onLeaveReview: () {
            Navigator.pushNamed(context, AppRoutes.review);
          },
        ),
      ],
    );
  }

  Widget _buildCancelledTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.event_busy,
            size: 80,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 16),
          Text(
            'No cancelled bookings',
            style: TextStyle(
              fontSize: 18,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _BookingCard extends StatelessWidget {
  final String title;
  final String studio;
  final String date;
  final String instructor;
  final int credits;
  final String status;
  final Color statusColor;
  final VoidCallback onViewDetails;
  final VoidCallback? onLeaveReview;
  final VoidCallback? onCancel;

  const _BookingCard({
    required this.title,
    required this.studio,
    required this.date,
    required this.instructor,
    required this.credits,
    required this.status,
    required this.statusColor,
    required this.onViewDetails,
    this.onLeaveReview,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Text(
                      status,
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.check_circle,
                      size: 16,
                      color: statusColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            studio,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                size: 16,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 8),
              Text(
                date,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.person,
                size: 16,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 8),
              Text(
                instructor,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.amber[50],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.bolt, size: 16, color: Colors.amber),
                const SizedBox(width: 4),
                Text(
                  '$credits credits',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onViewDetails,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.primary),
                    foregroundColor: AppColors.primary,
                  ),
                  child: const Text('View Details >'),
                ),
              ),
              if (onLeaveReview != null) ...[
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onLeaveReview,
                    icon: const Icon(Icons.star, size: 18),
                    label: const Text('Leave a review'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.success,
                    ),
                  ),
                ),
              ],
              if (onCancel != null) ...[
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onCancel,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text('Cancel'),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
