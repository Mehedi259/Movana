import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/widgets/custom_button.dart';

class LocationPreferencesScreen extends StatefulWidget {
  const LocationPreferencesScreen({super.key});

  @override
  State<LocationPreferencesScreen> createState() => _LocationPreferencesScreenState();
}

class _LocationPreferencesScreenState extends State<LocationPreferencesScreen> {
  double _searchRadius = 10;
  bool _usePreciseLocation = true;
  bool _showNearbyCities = false;
  final List<String> _preferredCities = ['Los Angeles, CA', 'Austin, TX'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Location Preferences'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current City
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CURRENT CITY',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: AppColors.primary, size: 20),
                        const SizedBox(width: 4),
                        const Text(
                          'San Francisco, CA',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('Update'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Map Placeholder
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Icon(
                  Icons.map,
                  size: 50,
                  color: Colors.grey[400],
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Search Radius
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Search Radius',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${_searchRadius.toInt()} km',
                    style: TextStyle(
                      color: AppColors.success,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('1 km'),
                Expanded(
                  child: Slider(
                    value: _searchRadius,
                    min: 1,
                    max: 50,
                    divisions: 49,
                    activeColor: AppColors.primary,
                    onChanged: (value) {
                      setState(() => _searchRadius = value);
                    },
                  ),
                ),
                const Text('50 km'),
              ],
            ),
            const SizedBox(height: 32),
            // Use Precise Location
            _SettingTile(
              title: 'Use Precise Location',
              subtitle: 'Allow app to use your exact location',
              value: _usePreciseLocation,
              onChanged: (value) {
                setState(() => _usePreciseLocation = value);
              },
            ),
            const SizedBox(height: 16),
            // Show Nearby Cities
            _SettingTile(
              title: 'Show nearby cities',
              subtitle: 'Include results just outside your radius',
              value: _showNearbyCities,
              onChanged: (value) {
                setState(() => _showNearbyCities = value);
              },
            ),
            const SizedBox(height: 32),
            // Preferred Cities
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Preferred Cities',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  label: const Text('Add City'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // City List
            ..._preferredCities.map((city) => _CityTile(
              city: city,
              onRemove: () {
                setState(() => _preferredCities.remove(city));
              },
            )),
            const SizedBox(height: 40),
            // Save Button
            CustomButton(
              text: 'Save Changes',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SettingTile({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.primary,
        ),
      ],
    );
  }
}

class _CityTile extends StatelessWidget {
  final String city;
  final VoidCallback onRemove;

  const _CityTile({
    required this.city,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.location_city),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              city,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: onRemove,
          ),
        ],
      ),
    );
  }
}
