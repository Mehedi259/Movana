import 'package:flutter/material.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../shared/widgets/custom_bottom_nav_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _selectedCategory = 'All';

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
                    'Search',
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
            
            // Search Bar and Filter
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 46,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        border: Border.all(
                          width: 1.11,
                          color: const Color(0xFFE2E8F0),
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.search,
                            size: 16,
                            color: Color(0x7F0F172A),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              'Search yoga, gym, spa...',
                              style: TextStyle(
                                color: Color(0x7F0F172A),
                                fontSize: 14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      border: Border.all(
                        width: 1.11,
                        color: const Color(0xFFE2E8F0),
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.tune,
                      size: 24,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 12),
            
            // Category Filters
            SizedBox(
              height: 31,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 26),
                children: [
                  _CategoryChip(
                    label: 'All',
                    isSelected: _selectedCategory == 'All',
                    onTap: () => setState(() => _selectedCategory = 'All'),
                  ),
                  const SizedBox(width: 8),
                  _CategoryChip(
                    label: 'Yoga',
                    isSelected: _selectedCategory == 'Yoga',
                    onTap: () => setState(() => _selectedCategory = 'Yoga'),
                  ),
                  const SizedBox(width: 8),
                  _CategoryChip(
                    label: 'Gym',
                    isSelected: _selectedCategory == 'Gym',
                    onTap: () => setState(() => _selectedCategory = 'Gym'),
                  ),
                  const SizedBox(width: 8),
                  _CategoryChip(
                    label: 'Pilates',
                    isSelected: _selectedCategory == 'Pilates',
                    onTap: () => setState(() => _selectedCategory = 'Pilates'),
                  ),
                  const SizedBox(width: 8),
                  _CategoryChip(
                    label: 'Spa',
                    isSelected: _selectedCategory == 'Spa',
                    onTap: () => setState(() => _selectedCategory = 'Spa'),
                  ),
                  const SizedBox(width: 8),
                  _CategoryChip(
                    label: 'Boxing',
                    isSelected: _selectedCategory == 'Boxing',
                    onTap: () => setState(() => _selectedCategory = 'Boxing'),
                  ),
                  const SizedBox(width: 8),
                  _CategoryChip(
                    label: 'Cycling',
                    isSelected: _selectedCategory == 'Cycling',
                    onTap: () => setState(() => _selectedCategory = 'Cycling'),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Results
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                children: [
                  const Text(
                    '24 results near you',
                    style: TextStyle(
                      color: Color(0xFF002212),
                      fontSize: 16,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w600,
                      height: 1.38,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _SearchResultCard(
                    name: 'Zen Flow Studio',
                    category: 'Yoga • Pilates',
                    rating: 4.8,
                    reviews: 312,
                    distance: '0.8 mi',
                    credits: '4+ Credits',
                    imagePath: 'assets/ZenFlowStudio.png',
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.studioDetails);
                    },
                  ),
                  const SizedBox(height: 16),
                  _SearchResultCard(
                    name: 'FitForce Gym',
                    category: 'Gym • HIIT',
                    rating: 4.9,
                    reviews: 450,
                    distance: '1.2 mi',
                    credits: '6+ Credits',
                    imagePath: 'assets/FitForseGym.png',
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.studioDetails);
                    },
                  ),
                  const SizedBox(height: 16),
                  _SearchResultCard(
                    name: 'PurePilates Studio',
                    category: 'Pilates',
                    rating: 4.7,
                    reviews: 189,
                    distance: '2.5 mi',
                    credits: '5+ Credits',
                    imagePath: 'assets/ZenFlowStudio.png',
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.studioDetails);
                    },
                  ),
                  const SizedBox(height: 16),
                  _SearchResultCard(
                    name: 'Harmony Spa & GYM',
                    category: 'Spa • Recovery',
                    rating: 4.9,
                    reviews: 189,
                    distance: '2.5 mi',
                    credits: '5+ Credits',
                    imagePath: 'assets/FitForseGym.png',
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.studioDetails);
                    },
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton.icon(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.searchMap),
        icon: const Icon(Icons.map_outlined, color: Colors.white, size: 18),
        label: const Text(
          'Map View',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontFamily: 'Lexend',
            fontWeight: FontWeight.w500,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF006B3D),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          elevation: 4,
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xFF0B2D1E), Color(0xFF009955)],
                )
              : null,
          color: isSelected ? null : const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF64748B),
            fontSize: 13,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            height: 1.50,
          ),
        ),
      ),
    );
  }
}

class _SearchResultCard extends StatelessWidget {
  final String name;
  final String category;
  final double rating;
  final int reviews;
  final String distance;
  final String credits;
  final String imagePath;
  final VoidCallback onTap;

  const _SearchResultCard({
    required this.name,
    required this.category,
    required this.rating,
    required this.reviews,
    required this.distance,
    required this.credits,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAF6),
          borderRadius: BorderRadius.circular(12),
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
                color: const Color(0xFFECEEEA),
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage(imagePath),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          style: const TextStyle(
                            color: Color(0xFF191C1A),
                            fontSize: 16,
                            fontFamily: 'Lexend',
                            fontWeight: FontWeight.w600,
                            height: 1.38,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.favorite_border,
                        size: 20,
                        color: Color(0xFF191C1A),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    category,
                    style: const TextStyle(
                      color: Color(0xFF404943),
                      fontSize: 14,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w400,
                      height: 1.43,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 14,
                              color: Color(0xFF0F5238),
                            ),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                '$rating ($reviews)',
                                style: const TextStyle(
                                  color: Color(0xFF0F5238),
                                  fontSize: 12,
                                  fontFamily: 'Lexend',
                                  fontWeight: FontWeight.w600,
                                  height: 1.50,
                                  letterSpacing: 0.60,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              '•',
                              style: TextStyle(
                                color: Color(0xFFBFC9C1),
                                fontSize: 16,
                                fontFamily: 'Lexend',
                                fontWeight: FontWeight.w400,
                                height: 1.50,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                distance,
                                style: const TextStyle(
                                  color: Color(0xFF707973),
                                  fontSize: 12,
                                  fontFamily: 'Lexend',
                                  fontWeight: FontWeight.w400,
                                  height: 1.33,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD9E6DA),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          credits,
                          style: const TextStyle(
                            color: Color(0xFF5B675E),
                            fontSize: 10,
                            fontFamily: 'Lexend',
                            fontWeight: FontWeight.w600,
                            height: 1.20,
                            letterSpacing: 0.60,
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
      ),
    );
  }
}
