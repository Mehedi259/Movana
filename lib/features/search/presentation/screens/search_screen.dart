import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/widgets/custom_bottom_nav_bar.dart';
import '../../services/search_service.dart';
import '../../../home/services/home_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _selectedCategory = 'All';
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  bool _isLoading = false;
  List<dynamic> _results = [];
  
  // Location and Distance Filter
  Position? _currentPosition;
  // Type Filter
  String _selectedType = 'All'; // 'All', 'Class', 'Studio'

  final List<String> _categories = ['All', 'Yoga', 'Gym', 'Pilates', 'Spa', 'Boxing', 'Cycling'];

  @override
  void initState() {
    super.initState();
    _fetchResults();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    if (permission == LocationPermission.deniedForever) return;

    final position = await Geolocator.getCurrentPosition();
    if (mounted) {
      setState(() {
        _currentPosition = position;
      });
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _fetchResults();
    });
  }

  Future<void> _fetchResults() async {
    setState(() => _isLoading = true);
    try {
      final query = _searchController.text.trim();
      final classesData = await SearchService.searchClasses(query);
      
      List<dynamic> studiosData = [];
      try {
        studiosData = await HomeService.getStudios();
      } catch (_) {}

      if (mounted) {
        setState(() {
          _results = [...classesData, ...studiosData];
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  List<dynamic> get _filteredResults {
    List<dynamic> categoryFiltered = _results;
    if (_selectedCategory != 'All') {
      categoryFiltered = _results.where((item) {
        final name = (item['name'] ?? '').toString().toLowerCase();
        final studioName = ((item['studio'] is Map) ? (item['studio']['name'] ?? '') : (item['studio_name'] ?? '')).toString().toLowerCase();
        final searchStr = '$name $studioName';
        return searchStr.contains(_selectedCategory.toLowerCase());
      }).toList();
    }

    // Type Filter
    if (_selectedType != 'All') {
      categoryFiltered = categoryFiltered.where((item) {
        final isClass = item['credit_cost'] != null || item['studio'] != null;
        if (_selectedType == 'Class') return isClass;
        if (_selectedType == 'Studio') return !isClass;
        return true;
      }).toList();
    }
    
    return categoryFiltered;
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Filters',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text('Type', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    children: ['All', 'Class', 'Studio'].map((type) {
                      final isSelected = _selectedType == type;
                      return ChoiceChip(
                        label: Text(type),
                        selected: isSelected,
                        selectedColor: AppColors.primary,
                        labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black87),
                        onSelected: (selected) {
                          if (selected) {
                            setModalState(() => _selectedType = type);
                            setState(() => _selectedType = type);
                          }
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Apply Filters', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                    ),
                  )
                ],
              ),
            );
          }
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredResults = _filteredResults;
    
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Search',
                    style: TextStyle(
                      color: Color(0xFF0B191D),
                      fontSize: 20,
                      fontFamily: 'Nunito Sans',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            
            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 52,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _searchController,
                        onChanged: _onSearchChanged,
                        decoration: InputDecoration(
                          hintText: 'Search yoga, gym, spa...',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 15,
                          ),
                          prefixIcon: const Icon(Icons.search, color: Colors.grey),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: _showFilterBottomSheet,
                    child: Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.tune, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Category Filters
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: _CategoryChip(
                      label: category,
                      isSelected: _selectedCategory == category,
                      onTap: () => setState(() => _selectedCategory = category),
                    ),
                  );
                },
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Results
            Expanded(
              child: _isLoading 
                ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemCount: filteredResults.length + 2,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Text(
                            '${filteredResults.length} results found',
                            style: const TextStyle(
                              color: Color(0xFF0B191D),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }
                      if (index == filteredResults.length + 1) {
                        return const SizedBox(height: 100);
                      }
                      
                      final item = filteredResults[index - 1];
                      final studioName = (item['studio'] is Map) 
                          ? (item['studio']['name'] ?? 'Studio') 
                          : (item['studio_name'] ?? 'Studio');
                      final location = (item['studio'] is Map) 
                          ? (item['studio']['location'] ?? 'Location') 
                          : (item['location'] ?? 'Location');
                      
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _SearchResultCard(
                          name: item['name'] ?? 'Class Name',
                          category: studioName.toString(),
                          rating: 4.8,
                          reviews: 120,
                          distance: location.toString(),
                          credits: '${item['credit_cost'] ?? item['start_credit'] ?? 0} Credits',
                          networkImage: item['image'] ?? item['cover_photo'] ?? (item['images'] != null && (item['images'] as List).isNotEmpty ? item['images'][0]['image'] : null),
                          onTap: () {
                            Navigator.pushNamed(
                              context, 
                              AppRoutes.classDetails,
                              arguments: item['id'],
                            );
                          },
                        ),
                      );
                    },
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
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF002212), // Very dark green
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          elevation: 6,
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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  )
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  )
                ],
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey.shade200,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey.shade700,
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
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
  final String? networkImage;
  final VoidCallback onTap;

  const _SearchResultCard({
    required this.name,
    required this.category,
    required this.rating,
    required this.reviews,
    required this.distance,
    required this.credits,
    this.networkImage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: 90,
                height: 90,
                color: Colors.grey.shade100,
                child: (networkImage != null && networkImage!.isNotEmpty)
                    ? Image.network(
                        networkImage!.startsWith('http')
                            ? networkImage!
                            : 'http://16.170.40.206:8000$networkImage',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Image.asset(
                          'assets/ZenFlowStudio.png',
                          fit: BoxFit.cover,
                        ),
                      )
                    : Image.asset(
                        'assets/ZenFlowStudio.png',
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
                            color: Color(0xFF0B191D),
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Icon(Icons.favorite_border, size: 20, color: Colors.grey),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    category,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 16, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        rating.toString(),
                        style: const TextStyle(
                          color: Color(0xFF0B191D),
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        ' ($reviews)',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text('•', style: TextStyle(color: Colors.grey)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          distance,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 13,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      credits,
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
