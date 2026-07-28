import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../home/services/home_service.dart';

class SearchMapScreen extends StatefulWidget {
  const SearchMapScreen({super.key});

  @override
  State<SearchMapScreen> createState() => _SearchMapScreenState();
}

class _SearchMapScreenState extends State<SearchMapScreen> {
  String _selectedTopCategory = 'All';
  String _selectedDay = 'All';

  final List<String> _topCategories = ['All', 'Yoga', 'Gym', 'Pilates', 'Spa', 'Sauna'];
  final List<String> _days = ['All', 'Today', 'Tue-28', 'Wed-29', 'Thu-30'];

  List<dynamic> _studios = [];
  bool _isLoading = true;
  
  // Default to Dhaka
  final LatLng _defaultLocation = const LatLng(23.779468, 90.404630);
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    _fetchStudios();
  }

  Future<void> _fetchStudios() async {
    try {
      final data = await HomeService.getStudios();
      if (mounted) {
        setState(() {
          _studios = data;
          _isLoading = false;
        });
        
        if (_studios.isNotEmpty) {
          double lat = double.tryParse(_studios[0]['latitude']?.toString() ?? '') ?? 0;
          double lng = double.tryParse(_studios[0]['longitude']?.toString() ?? '') ?? 0;
          if (lat != 0 && lng != 0) {
            // Give the map a moment to initialize before moving it
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _mapController.move(LatLng(lat, lng), 13.0);
            });
          }
        }
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showFilters() {
    // Simple filter placeholder
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Map Filters', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              const Text('Distance Radius', style: TextStyle(fontWeight: FontWeight.bold)),
              Slider(value: 5, min: 1, max: 20, activeColor: AppColors.primary, onChanged: (v){}),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Apply', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  List<Marker> _buildMarkers() {
    return _studios.map((studio) {
      double lat = double.tryParse(studio['latitude']?.toString() ?? '') ?? 0;
      double lng = double.tryParse(studio['longitude']?.toString() ?? '') ?? 0;
      
      // Fallback coordinates if API doesn't have them
      if (lat == 0 || lng == 0) {
        lat = _defaultLocation.latitude + (_studios.indexOf(studio) * 0.01);
        lng = _defaultLocation.longitude + (_studios.indexOf(studio) * 0.01);
      }
      
      return Marker(
        point: LatLng(lat, lng),
        width: 40,
        height: 40,
        child: GestureDetector(
          onTap: () {
            // Optional: Animate map to marker
            _mapController.move(LatLng(lat, lng), 14.0);
          },
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))
              ],
            ),
            child: const Icon(Icons.location_on, color: Colors.white, size: 24),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: Stack(
        children: [
          // 1. Flutter Map
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.65,
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: _defaultLocation,
                initialZoom: 12.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://a.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.movana.app',
                ),
                MarkerLayer(
                  markers: _buildMarkers(),
                ),
              ],
            ),
          ),

          // 2. Search Bar
          Positioned(
            top: 60,
            left: 16,
            right: 16,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 52,
                    height: 52,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4))],
                    ),
                    child: const Icon(Icons.arrow_back, color: Color(0xFF4B5563)),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4))],
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 16),
                        const Icon(Icons.search, color: Color(0xFF9CA3AF), size: 22),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText: 'Search by studio or yoga...',
                              hintStyle: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: _showFilters,
                  child: Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4))],
                    ),
                    child: const Icon(Icons.tune, color: Color(0xFF4B5563)),
                  ),
                ),
              ],
            ),
          ),

          // 3. Top Category Chips over Map
          Positioned(
            top: 130,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 40,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: _topCategories.length,
                itemBuilder: (context, index) {
                  final cat = _topCategories[index];
                  final isSelected = cat == _selectedTopCategory;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedTopCategory = cat),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        cat,
                        style: TextStyle(
                          color: isSelected ? Colors.white : const Color(0xFF4B5563),
                          fontSize: 14,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // 4. Draggable Bottom Sheet for Results
          DraggableScrollableSheet(
            initialChildSize: 0.45,
            minChildSize: 0.2,
            maxChildSize: 0.85,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20, offset: Offset(0, -4))],
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    // Handle
                    Container(
                      width: 48,
                      height: 5,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE5E7EB),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Title
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Text(
                            '${_studios.length} studios near you',
                            style: const TextStyle(color: Color(0xFF6B7280), fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // List of Cards
                    Expanded(
                      child: _isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : _studios.isEmpty
                              ? const Center(child: Text('No studios found.'))
                              : ListView.builder(
                                  controller: scrollController,
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  itemCount: _studios.length,
                                  itemBuilder: (context, index) {
                                    final studio = _studios[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 16),
                                      child: _buildStudioCard(
                                        name: studio['name'] ?? 'Studio Name',
                                        categories: studio['primary_category'] ?? 'Studio • Wellness',
                                        rating: '4.8',
                                        reviews: '(120)',
                                        distance: studio['full_address'] ?? studio['city'] ?? 'Unknown location',
                                        imagePath: studio['cover_photo'], // using network image if available
                                        isFavorite: studio['is_favorite'] == true,
                                        onTap: () {
                                          Navigator.pushNamed(context, AppRoutes.studioDetails, arguments: studio['id']);
                                        },
                                      ),
                                    );
                                  },
                                ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStudioCard({
    required String name,
    required String categories,
    required String rating,
    required String reviews,
    required String distance,
    required String? imagePath,
    required bool isFavorite,
    required VoidCallback onTap,
  }) {
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
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: 80,
                height: 80,
                color: Colors.grey.shade100,
                child: (imagePath != null && imagePath.isNotEmpty)
                    ? Image.network(
                        imagePath.startsWith('http') ? imagePath : 'http://16.170.40.206:8000$imagePath',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset('assets/ZenFlowStudio.png', fit: BoxFit.cover);
                        },
                      )
                    : Image.asset('assets/ZenFlowStudio.png', fit: BoxFit.cover),
              ),
            ),
            const SizedBox(width: 16),
            // Info
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
                          style: const TextStyle(color: Color(0xFF111827), fontSize: 16, fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : const Color(0xFF6B7280),
                        size: 20,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    categories,
                    style: const TextStyle(color: Color(0xFF4B5563), fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        rating,
                        style: const TextStyle(color: Color(0xFF111827), fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        ' $reviews',
                        style: const TextStyle(color: Color(0xFF6B7280), fontSize: 13),
                      ),
                      const SizedBox(width: 8),
                      const Text('•', style: TextStyle(color: Color(0xFF9CA3AF))),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          distance,
                          style: const TextStyle(color: Color(0xFF6B7280), fontSize: 13),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
