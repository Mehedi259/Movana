import 'package:flutter/material.dart';

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

  void _showFilters() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const _FiltersBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: Stack(
        children: [
          // 1. Google Map
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.6,
            child: Image.asset(
              'assets/map.png',
              fit: BoxFit.cover,
            ),
          ),

          // 2. Search Bar
          Positioned(
            top: 60,
            left: 16,
            right: 16,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x1A000000),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 16),
                        const Icon(
                          Icons.search,
                          color: Color(0xFF9CA3AF),
                          size: 22,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText: 'Search by studio or yoga,gym,spa...',
                              hintStyle: TextStyle(
                                color: Color(0xFF9CA3AF),
                                fontSize: 14,
                                fontFamily: 'Lexend',
                              ),
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
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x1A000000),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.tune,
                      color: Color(0xFF4B5563),
                    ),
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
                    onTap: () {
                      setState(() => _selectedTopCategory = cat);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF0F5238) : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x1A000000),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        cat,
                        style: TextStyle(
                          color: isSelected ? Colors.white : const Color(0xFF4B5563),
                          fontSize: 14,
                          fontFamily: 'Lexend',
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
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
            initialChildSize: 0.5,
            minChildSize: 0.2,
            maxChildSize: 0.85,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x1A000000),
                      blurRadius: 20,
                      offset: Offset(0, -4),
                    ),
                  ],
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
                        children: const [
                          Text(
                            '6 results near you',
                            style: TextStyle(
                              color: Color(0xFF6B7280),
                              fontSize: 14,
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Days Filter
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        scrollDirection: Axis.horizontal,
                        itemCount: _days.length,
                        itemBuilder: (context, index) {
                          final day = _days[index];
                          final isSelected = day == _selectedDay;
                          return GestureDetector(
                            onTap: () {
                              setState(() => _selectedDay = day);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 8),
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xFF326E51)
                                    : Colors.white,
                                border: Border.all(
                                  color: isSelected
                                      ? const Color(0xFF326E51)
                                      : const Color(0xFFD1D5DB),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                day,
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : const Color(0xFF1F2937),
                                  fontSize: 14,
                                  fontFamily: 'Lexend',
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    // List of Cards
                    Expanded(
                      child: ListView(
                        controller: scrollController,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        children: [
                          _buildStudioCard(
                            name: 'Zen Flow Studio',
                            categories: 'Yoga • Pilates',
                            rating: '4.8',
                            reviews: '(312)',
                            distance: '0.8 mi',
                            creditsText: '4+ Credits',
                            imagePath: 'assets/Reformer Pilates.png',
                          ),
                          const SizedBox(height: 16),
                          _buildStudioCard(
                            name: 'FitForce Gym',
                            categories: 'Gym • HIIT',
                            rating: '4.9',
                            reviews: '(450)',
                            distance: '1.2 mi',
                            creditsText: '6+ Credits',
                            imagePath: 'assets/Full Body HIIT Burn.png',
                          ),
                          const SizedBox(height: 16),
                          _buildStudioCard(
                            name: 'Harmony Spa & GYM',
                            categories: 'Spa • Recovery',
                            rating: '4.9',
                            reviews: '(189)',
                            distance: '2.5 mi',
                            creditsText: '5+ Credits',
                            imagePath: 'assets/Morning.png',
                          ),
                          const SizedBox(height: 24),
                        ],
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

  // Map marker UI helper removed since we're using Google Map Markers natively

  Widget _buildStudioCard({
    required String name,
    required String categories,
    required String rating,
    required String reviews,
    required String distance,
    required String creditsText,
    required String imagePath,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF3F4F6), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imagePath,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
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
                        style: const TextStyle(
                          color: Color(0xFF111827),
                          fontSize: 16,
                          fontFamily: 'Lexend',
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Icon(
                      Icons.favorite_border,
                      color: Color(0xFF6B7280),
                      size: 20,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  categories,
                  style: const TextStyle(
                    color: Color(0xFF4B5563),
                    fontSize: 13,
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, color: Color(0xFF0F5238), size: 14),
                    const SizedBox(width: 4),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: rating,
                            style: const TextStyle(
                              color: Color(0xFF0F5238),
                              fontSize: 12,
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: ' $reviews',
                            style: const TextStyle(
                              color: Color(0xFF0F5238),
                              fontSize: 12,
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      '•',
                      style: TextStyle(
                        color: Color(0xFF9CA3AF),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      distance,
                      style: const TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 12,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFDCEBDE),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        creditsText,
                        style: const TextStyle(
                          color: Color(0xFF404943),
                          fontSize: 11,
                          fontFamily: 'Lexend',
                          fontWeight: FontWeight.w600,
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

// Bottom Sheet for Filters
class _FiltersBottomSheet extends StatefulWidget {
  const _FiltersBottomSheet();

  @override
  State<_FiltersBottomSheet> createState() => _FiltersBottomSheetState();
}

class _FiltersBottomSheetState extends State<_FiltersBottomSheet> {
  final Set<String> _selectedCategories = {'Yoga', 'Pilates'};
  RangeValues _creditsRange = const RangeValues(1, 10);
  double _distance = 5;
  double _timeHour = 9.5;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
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
          const SizedBox(height: 16),
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close, color: Color(0xFF111827)),
                ),
                const Text(
                  'Filters',
                  style: TextStyle(
                    color: Color(0xFF111827),
                    fontSize: 18,
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategories.clear();
                      _creditsRange = const RangeValues(1, 10);
                      _distance = 10;
                      _timeHour = 9.5;
                    });
                  },
                  child: const Text(
                    'Reset',
                    style: TextStyle(
                      color: Color(0xFF0F5238),
                      fontSize: 14,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, color: Color(0xFFF3F4F6)),
          
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              children: [
                // Category section
                const Text(
                  'Category',
                  style: TextStyle(
                    color: Color(0xFF111827),
                    fontSize: 16,
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    'Yoga',
                    'Pilates',
                    'Gym',
                    'Spa',
                    'Cycling',
                    'Boxing',
                    'Barre',
                    'Sauna',
                    'Dance'
                  ].map((cat) {
                    final isSelected = _selectedCategories.contains(cat);
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            _selectedCategories.remove(cat);
                          } else {
                            _selectedCategories.add(cat);
                          }
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFFDCEBDE)
                              : Colors.white,
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFFDCEBDE)
                                : const Color(0xFFD1D5DB),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          cat,
                          style: TextStyle(
                            color: const Color(0xFF4B5563),
                            fontSize: 14,
                            fontFamily: 'Lexend',
                            fontWeight: isSelected
                                ? FontWeight.w500
                                : FontWeight.w400,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 32),

                // Credits section
                _buildSliderHeader(
                  'Credits',
                  '${_creditsRange.start.round()} cr — ${_creditsRange.end.round()} cr',
                ),
                RangeSlider(
                  values: _creditsRange,
                  min: 1,
                  max: 10,
                  divisions: 9,
                  activeColor: const Color(0xFF0F5238),
                  inactiveColor: const Color(0xFFE5E7EB),
                  onChanged: (vals) => setState(() => _creditsRange = vals),
                ),
                const SizedBox(height: 24),

                // Distance section
                _buildSliderHeader(
                  'Distance',
                  '0 km — ${_distance.round()} km',
                ),
                Slider(
                  value: _distance,
                  min: 0,
                  max: 20,
                  divisions: 20,
                  activeColor: const Color(0xFF0F5238),
                  inactiveColor: const Color(0xFFE5E7EB),
                  onChanged: (val) => setState(() => _distance = val),
                ),
                const SizedBox(height: 24),

                // Time section
                _buildSliderHeader(
                  'Time (Hours)',
                  _formatTime(_timeHour),
                ),
                Slider(
                  value: _timeHour,
                  min: 5,
                  max: 23,
                  divisions: 36, // Every 30 mins
                  activeColor: const Color(0xFF0F5238),
                  inactiveColor: const Color(0xFFE5E7EB),
                  onChanged: (val) => setState(() => _timeHour = val),
                ),
                const SizedBox(height: 24),

                // Rating Minimum section
                const Text(
                  'Rating Minimum',
                  style: TextStyle(
                    color: Color(0xFF111827),
                    fontSize: 16,
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
          
          // Show Results Button
          Container(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0x0A000000),
                  blurRadius: 10,
                  offset: Offset(0, -4),
                ),
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF006B3D),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Show Results',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliderHeader(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF111827),
              fontSize: 16,
              fontFamily: 'Lexend',
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF0F5238),
              fontSize: 14,
              fontFamily: 'Lexend',
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(double hourVal) {
    int h = hourVal.floor();
    int m = ((hourVal - h) * 60).round();
    String period = h >= 12 ? 'PM' : 'AM';
    int displayHour = h > 12 ? h - 12 : (h == 0 ? 12 : h);
    return '$displayHour:${m.toString().padLeft(2, '0')} $period';
  }
}
