import 'package:flutter/material.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../shared/widgets/custom_bottom_nav_bar.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Favourite',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF0B191D),
                      fontSize: 18,
                      fontFamily: 'Nunito Sans',
                      fontWeight: FontWeight.w700,
                      height: 1.11,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Tab Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26),
              child: Row(
                children: [
                  Expanded(
                    child: _TabItem(
                      label: 'Studios',
                      isSelected: _selectedTab == 0,
                      onTap: () => setState(() => _selectedTab = 0),
                    ),
                  ),
                  Expanded(
                    child: _TabItem(
                      label: 'Classes',
                      isSelected: _selectedTab == 1,
                      onTap: () => setState(() => _selectedTab = 1),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Content
            Expanded(
              child: _selectedTab == 0
                  ? _buildStudiosTab()
                  : _buildClassesTab(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 3),
    );
  }

  Widget _buildStudiosTab() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 26),
      children: const [
        _FavoriteStudioCard(
          name: 'Zen Flow Studio',
          categories: ['Yoga', 'Pilates'],
          distance: '1.2 km away',
          location: 'Downtown',
          rating: 4.9,
          reviews: 128,
          imagePath: 'assets/ZenFlowStudio.png',
        ),
        SizedBox(height: 12),
        _FavoriteStudioCard(
          name: 'FitForce Gym',
          categories: ['HITT', 'Strength'],
          distance: '3.5 km away',
          location: 'Westside',
          rating: 4.9,
          reviews: 84,
          imagePath: 'assets/FitForseGym.png',
        ),
        SizedBox(height: 12),
        _FavoriteStudioCard(
          name: 'Zen Flow Studio',
          categories: ['Yoga', 'Pilates'],
          distance: '1.2 km away',
          location: 'Downtown',
          rating: 4.9,
          reviews: 128,
          imagePath: 'assets/ZenFlowStudio.png',
        ),
        SizedBox(height: 12),
        _FavoriteStudioCard(
          name: 'FitForce Gym',
          categories: ['HITT', 'Strength'],
          distance: '3.5 km away',
          location: 'Westside',
          rating: 4.9,
          reviews: 84,
          imagePath: 'assets/FitForseGym.png',
        ),
        SizedBox(height: 100),
      ],
    );
  }

  Widget _buildClassesTab() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 26),
      children: const [
        _FavoriteStudioCard(
          name: 'Morning Vinyasa',
          categories: ['Yoga', 'Flow'],
          distance: '1.2 km away',
          location: 'Downtown',
          rating: 4.8,
          reviews: 95,
          imagePath: 'assets/ZenFlowStudio.png',
        ),
        SizedBox(height: 12),
        _FavoriteStudioCard(
          name: 'Reformer Pilates',
          categories: ['Pilates', 'Core'],
          distance: '2.1 km away',
          location: 'Midtown',
          rating: 4.9,
          reviews: 112,
          imagePath: 'assets/FitForseGym.png',
        ),
        SizedBox(height: 12),
        _FavoriteStudioCard(
          name: 'HIIT Training',
          categories: ['HIIT', 'Cardio'],
          distance: '3.5 km away',
          location: 'Westside',
          rating: 4.7,
          reviews: 78,
          imagePath: 'assets/ZenFlowStudio.png',
        ),
        SizedBox(height: 100),
      ],
    );
  }
}

class _TabItem extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabItem({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 34,
        decoration: BoxDecoration(
          border: isSelected
              ? const Border(
                  bottom: BorderSide(
                    width: 2,
                    color: Color(0xFF2D6A4F),
                  ),
                )
              : null,
        ),
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? const Color(0xFF2D6A4F) : const Color(0xFF707973),
              fontSize: isSelected ? 17 : 16,
              fontFamily: 'Lexend',
              fontWeight: FontWeight.w600,
              height: isSelected ? 1.40 : 1.38,
            ),
          ),
        ),
      ),
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
  final String imagePath;

  const _FavoriteStudioCard({
    required this.name,
    required this.categories,
    required this.distance,
    required this.location,
    required this.rating,
    required this.reviews,
    required this.imagePath,
  });

  @override
  State<_FavoriteStudioCard> createState() => _FavoriteStudioCardState();
}

class _FavoriteStudioCardState extends State<_FavoriteStudioCard> {
  bool _isFavorite = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.studioDetails);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color(0x11000000),
              blurRadius: 12,
              offset: Offset(0, 2),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          children: [
            // Image
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: const Color(0xFFE1E3DF),
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(widget.imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Categories and Favorite Icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  color: const Color(0xFFD9E6DA),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  category,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color(0xFF5B675E),
                                    fontSize: 10,
                                    fontFamily: 'Lexend',
                                    fontWeight: FontWeight.w400,
                                    height: 1.60,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() => _isFavorite = !_isFavorite);
                        },
                        child: Icon(
                          _isFavorite ? Icons.favorite : Icons.favorite_border,
                          size: 20,
                          color: _isFavorite ? Colors.red : const Color(0xFF191C1A),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Studio Name
                  Text(
                    widget.name,
                    style: const TextStyle(
                      color: Color(0xFF191C1A),
                      fontSize: 16,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w600,
                      height: 1.38,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Location
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 16,
                        color: Color(0xFF404943),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          '${widget.distance} · ${widget.location}',
                          style: const TextStyle(
                            color: Color(0xFF404943),
                            fontSize: 14,
                            fontFamily: 'Lexend',
                            fontWeight: FontWeight.w400,
                            height: 1.43,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Rating
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 16,
                        color: Color(0xFFFFA500),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${widget.rating}',
                        style: const TextStyle(
                          color: Color(0xFF191C1A),
                          fontSize: 14,
                          fontFamily: 'Lexend',
                          fontWeight: FontWeight.w500,
                          height: 1.43,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '(${widget.reviews} reviews)',
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
