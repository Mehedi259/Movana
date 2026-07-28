import 'package:flutter/material.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../shared/widgets/custom_bottom_nav_bar.dart';
import '../../services/favorites_service.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  int _selectedTab = 0;
  bool _isLoading = true;
  List<dynamic> _studios = [];
  List<dynamic> _classes = [];

  @override
  void initState() {
    super.initState();
    _fetchFavorites();
  }

  Future<void> _fetchFavorites() async {
    setState(() => _isLoading = true);
    try {
      final studiosFuture = FavoritesService.getFavoriteStudios().catchError((_) => <dynamic>[]);
      final classesFuture = FavoritesService.getFavoriteClasses().catchError((_) => <dynamic>[]);
      final results = await Future.wait([studiosFuture, classesFuture]);
      
      if (mounted) {
        setState(() {
          _studios = results[0];
          _classes = results[1];
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _toggleFavoriteStudio(int id) async {
    try {
      await FavoritesService.toggleFavoriteStudio(id);
      _fetchFavorites();
    } catch (e) {
      // ignore
    }
  }

  Future<void> _toggleFavoriteClass(int id) async {
    try {
      await FavoritesService.toggleFavoriteClass(id);
      _fetchFavorites();
    } catch (e) {
      // ignore
    }
  }

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
              child: _isLoading 
                ? const Center(child: CircularProgressIndicator(color: Color(0xFF2D6A4F)))
                : RefreshIndicator(
                    onRefresh: _fetchFavorites,
                    color: const Color(0xFF2D6A4F),
                    child: _selectedTab == 0
                        ? _buildStudiosTab()
                        : _buildClassesTab(),
                  ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 3),
    );
  }

  Widget _buildStudiosTab() {
    if (_studios.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: const [
          SizedBox(height: 100),
          Center(child: Text('No favorite studios found')),
        ],
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 8),
      itemCount: _studios.length + 1,
      itemBuilder: (context, index) {
        if (index == _studios.length) return const SizedBox(height: 100);
        final studio = _studios[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _FavoriteStudioCard(
            name: studio['name'] ?? 'Studio',
            categories: [(studio['category'] ?? 'General').toString()],
            distance: '',
            location: studio['location'] ?? 'Location',
            rating: 4.9,
            reviews: 100,
            imagePath: 'assets/ZenFlowStudio.png',
            networkImage: studio['cover_photo'],
            onTap: () => Navigator.pushNamed(context, AppRoutes.studioDetails, arguments: studio['id']),
            onToggleFavorite: () => _toggleFavoriteStudio(studio['id']),
          ),
        );
      },
    );
  }

  Widget _buildClassesTab() {
    if (_classes.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: const [
          SizedBox(height: 100),
          Center(child: Text('No favorite classes found')),
        ],
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 8),
      itemCount: _classes.length + 1,
      itemBuilder: (context, index) {
        if (index == _classes.length) return const SizedBox(height: 100);
        final cls = _classes[index];
        final studioName = (cls['studio'] is Map) 
            ? (cls['studio']['name'] ?? 'Studio') 
            : (cls['studio_name'] ?? 'Studio');
        final location = (cls['studio'] is Map) 
            ? (cls['studio']['location'] ?? 'Location') 
            : (cls['location'] ?? 'Location');
            
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _FavoriteStudioCard(
            name: cls['name'] ?? 'Class',
            categories: [studioName.toString()],
            distance: '',
            location: location.toString(),
            rating: 4.8,
            reviews: 80,
            imagePath: 'assets/FitForseGym.png',
            networkImage: cls['image'],
            onTap: () => Navigator.pushNamed(context, AppRoutes.classDetails, arguments: cls['id']),
            onToggleFavorite: () => _toggleFavoriteClass(cls['id']),
          ),
        );
      },
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
  final String? networkImage;
  final VoidCallback onTap;
  final VoidCallback onToggleFavorite;

  const _FavoriteStudioCard({
    required this.name,
    required this.categories,
    required this.distance,
    required this.location,
    required this.rating,
    required this.reviews,
    required this.imagePath,
    this.networkImage,
    required this.onTap,
    required this.onToggleFavorite,
  });

  @override
  State<_FavoriteStudioCard> createState() => _FavoriteStudioCardState();
}

class _FavoriteStudioCardState extends State<_FavoriteStudioCard> {
  bool _isFavorite = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
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
                  image: (widget.networkImage != null && widget.networkImage!.isNotEmpty)
                      ? NetworkImage(
                          widget.networkImage!.startsWith('http')
                              ? widget.networkImage!
                              : 'http://16.170.40.206:8000${widget.networkImage}'
                        ) as ImageProvider
                      : (widget.imagePath.startsWith('http')
                          ? NetworkImage(widget.imagePath) as ImageProvider
                          : AssetImage(widget.imagePath)),
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
