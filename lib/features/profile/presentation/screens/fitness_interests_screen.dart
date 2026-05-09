import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/widgets/custom_button.dart';

class FitnessInterestsScreen extends StatefulWidget {
  const FitnessInterestsScreen({super.key});

  @override
  State<FitnessInterestsScreen> createState() => _FitnessInterestsScreenState();
}

class _FitnessInterestsScreenState extends State<FitnessInterestsScreen> {
  final List<String> _selectedInterests = ['Yoga', 'Pilates', 'Cycling', 'Running'];
  
  final List<String> _allInterests = [
    'Yoga',
    'Pilates',
    'Gym',
    'Spa',
    'Cycling',
    'Boxing',
    'Barre',
    'Running',
    'Sauna',
    'Dance',
    'Meditation',
  ];

  void _toggleInterest(String interest) {
    setState(() {
      if (_selectedInterests.contains(interest)) {
        _selectedInterests.remove(interest);
      } else {
        _selectedInterests.add(interest);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Fitness Interests'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'My Interests',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            // Interest Chips
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: _allInterests.map((interest) {
                final isSelected = _selectedInterests.contains(interest);
                return _InterestChip(
                  label: interest,
                  isSelected: isSelected,
                  onTap: () => _toggleInterest(interest),
                );
              }).toList(),
            ),
            const SizedBox(height: 32),
            // Add Interests Button
            OutlinedButton.icon(
              onPressed: () {
                // Show dialog to add custom interest
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Interestes'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: BorderSide(color: AppColors.primary),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
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

class _InterestChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _InterestChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(25),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white,
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.divider,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.textPrimary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
