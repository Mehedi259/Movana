import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class FavoriteClassesScreen extends StatefulWidget {
  const FavoriteClassesScreen({super.key});

  @override
  State<FavoriteClassesScreen> createState() => _FavoriteClassesScreenState();
}

class _FavoriteClassesScreenState extends State<FavoriteClassesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 1);
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
        title: const Text('Favourite'),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: AppColors.primary,
          tabs: const [
            Tab(text: 'Studios'),
            Tab(text: 'Classes'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildStudiosTab(),
          _buildClassesTab(),
        ],
      ),
    );
  }

  Widget _buildStudiosTab() {
    return Center(
      child: Text(
        'Favorite Studios',
        style: TextStyle(color: AppColors.textSecondary),
      ),
    );
  }

  Widget _buildClassesTab() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _FavoriteClassCard(
          title: 'Morning Vinyasa Flow',
          studio: 'Zen Flow Studio',
          instructor: 'Sarah Chen',
          time: 'Today, 08:00 AM',
          credits: 2,
          imageColor: Colors.pink[100]!,
        ),
        const SizedBox(height: 16),
        _FavoriteClassCard(
          title: 'Kickboxing Power',
          studio: 'Iron & Core',
          instructor: 'Mike Davis',
          time: 'Tomorrow, 18:30 PM',
          credits: 3,
          imageColor: Colors.grey[800]!,
        ),
        const SizedBox(height: 16),
        _FavoriteClassCard(
          title: 'Morning Vinyasa Flow',
          studio: 'Zen Flow Studio',
          instructor: 'Sarah Chen',
          time: 'Today, 08:00 AM',
          credits: 2,
          imageColor: Colors.pink[100]!,
        ),
        const SizedBox(height: 16),
        _FavoriteClassCard(
          title: 'Restorative Yin',
          studio: 'The Calm Space',
          instructor: 'Elena Rossi',
          time: 'Wed, 19:00 PM',
          credits: 1,
          imageColor: Colors.amber[100]!,
        ),
        const SizedBox(height: 16),
        _FavoriteClassCard(
          title: 'Kickboxing Power',
          studio: 'Iron & Core',
          instructor: 'Mike Davis',
          time: 'Tomorrow, 18:30 PM',
          credits: 3,
          imageColor: Colors.grey[800]!,
        ),
      ],
    );
  }
}

class _FavoriteClassCard extends StatefulWidget {
  final String title;
  final String studio;
  final String instructor;
  final String time;
  final int credits;
  final Color imageColor;

  const _FavoriteClassCard({
    required this.title,
    required this.studio,
    required this.instructor,
    required this.time,
    required this.credits,
    required this.imageColor,
  });

  @override
  State<_FavoriteClassCard> createState() => _FavoriteClassCardState();
}

class _FavoriteClassCardState extends State<_FavoriteClassCard> {
  bool _isFavorite = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          // Image
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: widget.imageColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
            child: const Icon(Icons.fitness_center, size: 40, color: Colors.white),
          ),
          // Details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${widget.studio} • ${widget.instructor}',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
                      Text(
                        widget.time,
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
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
                      '⚡${widget.credits} cr',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Favorite Button
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              onPressed: () {
                setState(() {
                  _isFavorite = !_isFavorite;
                });
              },
              icon: Icon(
                _isFavorite ? Icons.favorite : Icons.favorite_border,
                color: _isFavorite ? Colors.red : AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
