import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../shared/widgets/custom_bottom_nav_bar.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 3),
    );
  }

  Widget _buildStudiosTab() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _FavoriteStudioCard(
          name: 'Zen Flow Studio',
          categories: ['Yoga', 'Pilates'],
          distance: '1.2 km away',
          location: 'Downtown',
          rating: 4.9,
          reviews: 128,
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.studioDetails);
          },
        ),
        const SizedBox(height: 16),
        _FavoriteStudioCard(
          name: 'FitForce Gym',
          categories: ['HITT', 'Strength'],
          distance: '3.5 km away',
          location: 'Westside',
          rating: 4.9,
          reviews: 84,
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.studioDetails);
          },
        ),
        const SizedBox(height: 16),
        _FavoriteStudioCard(
          name: 'Zen Flow Studio',
          categories: ['Yoga', 'Pilates'],
          distance: '1.2 km away',
          location: 'Downtown',
          rating: 4.9,
          reviews: 128,
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.studioDetails);
          },
        ),
        const SizedBox(height: 16),
        _FavoriteStudioCard(
          name: 'FitForce Gym',
          categories: ['HITT', 'Strength'],
          distance: '3.5 km away',
          location: 'Westside',
          rating: 4.9,
          reviews: 84,
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.studioDetails);
          },
        ),
      ],
    );
  }

  Widget _buildClassesTab() {
    return const Center(
      child: Text('No favorite classes'),
    );
  }
}

class _FavoriteStudioCard extends StatefulWidget {
  final String name;
  final List<String> categories;
  final String distance;
  final String location;
  final double rating;
  final int reviews;
  final VoidCallback onTap;

  const _FavoriteStudioCard({
    required this.name,
    required this.categories,
    required this.distance,
    required this.location,
    required this.rating,
    required this.reviews,
    required this.onTap,
  });

  @override
  State<_FavoriteStudioCard> createState() => _FavoriteStudioCardState();
}

class _FavoriteStudioCardState extends State<_FavoriteStudioCard> {
  bool _isFavorite = true;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: widget.categories
                          .map(
                            (category) => Container(
                              margin: const EdgeInsets.only(right: 8),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.background,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                category,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          '${widget.distance} • ${widget.location}',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 14, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          '${widget.rating} (${widget.reviews} reviews)',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  _isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: _isFavorite ? Colors.red : null,
                ),
                onPressed: () {
                  setState(() => _isFavorite = !_isFavorite);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
