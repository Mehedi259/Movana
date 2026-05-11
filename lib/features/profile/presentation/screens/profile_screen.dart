import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../shared/widgets/custom_bottom_nav_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),
            // Profile Picture
            Stack(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.person, size: 50),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.success,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Name
            const Text(
              'Alex Johnson',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'alex.johnson@email.com',
              style: TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.location_on, size: 16),
                Text(
                  'San Francisco, CA',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Stats
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _StatCard(
                  value: '24',
                  label: 'Classes',
                ),
                _StatCard(
                  value: '⚡ 120',
                  label: 'Credits',
                ),
                _StatCard(
                  value: '⭐ 4.9',
                  label: 'Avg Rating',
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Pro Plan Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'PRO Plan',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '80 credits/month',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          'Renews Dec 1',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Manage Plan →',
                      style: TextStyle(color: AppColors.success),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Account Section
            _SectionHeader(title: 'ACCOUNT'),
            _MenuItem(
              icon: Icons.person_outline,
              title: 'Personal Information',
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.editProfile);
              },
            ),
            _MenuItem(
              icon: Icons.credit_card,
              title: 'Manage Billing Info',
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.plans);
              },
            ),
            _MenuItem(
              icon: Icons.bolt,
              title: 'Credits & Transactions',
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.plans);
              },
            ),
            const SizedBox(height: 24),
            // Preferences Section
            _SectionHeader(title: 'PREFERENCES'),
            _MenuItem(
              icon: Icons.fitness_center,
              title: 'Fitness Interests',
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.fitnessInterests);
              },
            ),
            _MenuItem(
              icon: Icons.location_on_outlined,
              title: 'Location Preferences',
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.locationPreferences);
              },
            ),
            const SizedBox(height: 24),
            // Support Section
            _SectionHeader(title: 'SUPPORT'),
            _MenuItem(
              icon: Icons.help_outline,
              title: 'Help & FAQ',
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.helpSupport);
              },
            ),
            _MenuItem(
              icon: Icons.shield_outlined,
              title: 'Security',
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.security);
              },
            ),
            _MenuItem(
              icon: Icons.description_outlined,
              title: 'Terms & Privacy',
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.termsPolicy);
              },
            ),
            const SizedBox(height: 24),
            // Logout Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.login,
                      (route) => false,
                    );
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('Log Out'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[50],
                    foregroundColor: Colors.red,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 4),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;

  const _StatCard({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textPrimary),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
