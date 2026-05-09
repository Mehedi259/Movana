import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class SearchMapScreen extends StatefulWidget {
  const SearchMapScreen({super.key});

  @override
  State<SearchMapScreen> createState() => _SearchMapScreenState();
}

class _SearchMapScreenState extends State<SearchMapScreen> {
  String _selectedDay = 'All';
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
      body: Stack(
        children: [
          // Map Placeholder
          Container(
            color: Colors.grey[200],
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.map,
                    size: 100,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Map View',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '(Map integration required)',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Map Markers (simulated)
          Positioned(
            top: 200,
            left: 50,
            child: _MapMarker(number: 1),
          ),
          Positioned(
            top: 150,
            right: 80,
            child: _MapMarker(number: 2),
          ),
          Positioned(
            bottom: 400,
            left: 100,
            child: _MapMarker(number: 1),
          ),
          Positioned(
            bottom: 450,
            right: 50,
            child: _MapMarker(number: 1),
          ),
          // Top Search Bar
          Positioned(
            top: 50,
            left: 16,
            right: 16,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: Colors.grey[400]),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search by studio or yoga,gym,spa...',
                              hintStyle: TextStyle(color: Colors.grey[400]),
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
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(Icons.tune, color: AppColors.primary),
                  ),
                ),
              ],
            ),
          ),
          // Category Chips
          Positioned(
            top: 120,
            left: 0,
            right: 0,
            child: Container(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: 5,
                itemBuilder: (context, index) {
                  final categories = ['All', 'Yoga', 'Gym', 'Pilates', 'Spa'];
                  final category = categories[index];
                  final isSelected = index == 0;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(category),
                      selected: isSelected,
                      onSelected: (selected) {},
                      backgroundColor: Colors.white,
                      selectedColor: AppColors.primary,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : AppColors.textPrimary,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                      side: BorderSide(
                        color: isSelected ? AppColors.primary : Colors.grey[300]!,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          // Bottom Results Sheet
          DraggableScrollableSheet(
            initialChildSize: 0.35,
            minChildSize: 0.2,
            maxChildSize: 0.8,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    // Handle
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    // Results Count
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          const Text(
                            '6 results near you',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Day Filter
                    Container(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: _days.length,
                        itemBuilder: (context, index) {
                          final day = _days[index];
                          final isSelected = _selectedDay == day;
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: FilterChip(
                              label: Text(day),
                              selected: isSelected,
                              onSelected: (selected) {
                                setState(() {
                                  _selectedDay = day;
                                });
                              },
                              backgroundColor: Colors.white,
                              selectedColor: AppColors.primary,
                              labelStyle: TextStyle(
                                color: isSelected ? Colors.white : AppColors.textPrimary,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                              ),
                              side: BorderSide(
                                color: isSelected ? AppColors.primary : Colors.grey[300]!,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    // Studios List
                    Expanded(
                      child: ListView(
                        controller: scrollController,
                        padding: const EdgeInsets.all(20),
                        children: [
                          _StudioCard(
                            name: 'Zen Flow Studio',
                            category: 'Yoga • Pilates',
                            rating: 4.8,
                            reviews: 312,
                            distance: '0.8 mi',
                            credits: '4+',
                          ),
                          const SizedBox(height: 12),
                          _StudioCard(
                            name: 'FitForce Gym',
                            category: 'Gym • HIIT',
                            rating: 4.9,
                            reviews: 450,
                            distance: '1.2 mi',
                            credits: '6+',
                          ),
                          const SizedBox(height: 12),
                          _StudioCard(
                            name: 'Harmony Spa & GYM',
                            category: 'Spa • Recovery',
                            rating: 4.9,
                            reviews: 189,
                            distance: '2.5 mi',
                            credits: '5+',
                          ),
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
}

class _MapMarker extends StatelessWidget {
  final int number;

  const _MapMarker({required this.number});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        number.toString(),
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _StudioCard extends StatelessWidget {
  final String name;
  final String category;
  final double rating;
  final int reviews;
  final String distance;
  final String credits;

  const _StudioCard({
    required this.name,
    required this.category,
    required this.rating,
    required this.reviews,
    required this.distance,
    required this.credits,
  });

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
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
            child: const Icon(Icons.fitness_center, size: 40),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    category,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 16, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        '$rating ($reviews)',
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '• $distance',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '• $credits Credits',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite_border),
            ),
          ),
        ],
      ),
    );
  }
}

class _FiltersBottomSheet extends StatefulWidget {
  const _FiltersBottomSheet();

  @override
  State<_FiltersBottomSheet> createState() => _FiltersBottomSheetState();
}

class _FiltersBottomSheetState extends State<_FiltersBottomSheet> {
  final Set<String> _selectedCategories = {'Yoga', 'Pilates'};
  RangeValues _creditsRange = const RangeValues(1, 10);
  double _distance = 5;
  TimeOfDay _time = const TimeOfDay(hour: 9, minute: 30);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
                const Text(
                  'Filters',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedCategories.clear();
                      _creditsRange = const RangeValues(1, 10);
                      _distance = 5;
                      _time = const TimeOfDay(hour: 9, minute: 30);
                    });
                  },
                  child: Text(
                    'Reset',
                    style: TextStyle(color: AppColors.primary),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                // Category
                const Text(
                  'Category',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
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
                  ].map((category) {
                    final isSelected = _selectedCategories.contains(category);
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            _selectedCategories.remove(category);
                          } else {
                            _selectedCategories.add(category);
                          }
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary.withValues(alpha: 0.1)
                              : Colors.white,
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : Colors.grey[300]!,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          category,
                          style: TextStyle(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.textPrimary,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),
                // Credits
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Credits',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${_creditsRange.start.round()} cr — ${_creditsRange.end.round()} cr',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  ],
                ),
                RangeSlider(
                  values: _creditsRange,
                  min: 1,
                  max: 10,
                  divisions: 9,
                  activeColor: AppColors.primary,
                  onChanged: (values) {
                    setState(() {
                      _creditsRange = values;
                    });
                  },
                ),
                const SizedBox(height: 16),
                // Distance
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Distance',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '0 km — ${_distance.round()} km',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  ],
                ),
                Slider(
                  value: _distance,
                  min: 0,
                  max: 10,
                  divisions: 10,
                  activeColor: AppColors.primary,
                  onChanged: (value) {
                    setState(() {
                      _distance = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                // Time
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Time (Hours)',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${_time.hour}:${_time.minute.toString().padLeft(2, '0')} AM',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  ],
                ),
                Slider(
                  value: _time.hour.toDouble(),
                  min: 0,
                  max: 23,
                  divisions: 23,
                  activeColor: AppColors.primary,
                  onChanged: (value) {
                    setState(() {
                      _time = TimeOfDay(hour: value.round(), minute: _time.minute);
                    });
                  },
                ),
                const SizedBox(height: 16),
                // Rating Minimum
                const Text(
                  'Rating Minimum',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
          // Show Results Button
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Show Results',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
