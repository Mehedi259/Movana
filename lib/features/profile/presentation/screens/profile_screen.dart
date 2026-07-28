import 'package:flutter/material.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../shared/widgets/custom_bottom_nav_bar.dart';
import '../../services/profile_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? _profileData;
  Map<String, dynamic>? _creditData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  Future<void> _fetchProfile() async {
    try {
      final profileFuture = ProfileService.getProfile();
      final creditFuture = ProfileService.getCreditStatus();
      
      final results = await Future.wait([profileFuture, creditFuture]);
      
      if (mounted) {
        setState(() {
          _profileData = results[0];
          _creditData = results[1];
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString().replaceAll('Exception: ', ''))),
        );
      }
    }
  }

  Future<void> _handleLogout() async {
    try {
      await ProfileService.logout();
    } catch (e) {
      // Ignore logout API error if token is already invalid
    }
    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 24),
              // Profile Header with Avatar and Edit Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    // Avatar
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF10B981),
                          width: 3,
                        ),
                      ),
                      child: ClipOval(
                        child: _profileData?['image'] != null
                            ? Image.network(
                                _profileData!['image'].toString().startsWith('http') 
                                    ? _profileData!['image'] 
                                    : 'http://16.170.40.206:8000${_profileData!['image']}',
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Image.asset('assets/Alex Johnson.png', fit: BoxFit.cover),
                              )
                            : Image.asset(
                                'assets/Alex Johnson.png',
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Name and Email
                    Expanded(
                      child: _isLoading 
                        ? const Center(child: CircularProgressIndicator())
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _profileData?['name'] ?? 'User',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0F172A),
                                  fontFamily: 'Lexend',
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _profileData?['email'] ?? '',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF64748B),
                                  fontFamily: 'Inter',
                                ),
                              ),
                            ],
                          ),
                    ),
                    // Edit Button
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFFE2E8F0),
                          width: 1,
                        ),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.edit_outlined,
                          size: 20,
                          color: Color(0xFF64748B),
                        ),
                        onPressed: () async {
                          await Navigator.pushNamed(context, AppRoutes.editProfile);
                          _fetchProfile();
                        },
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Stats Cards
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        value: '0', // TODO: Add API for attended classes
                        label: 'Classes',
                        icon: Icons.fitness_center,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StatCard(
                        value: _creditData?['total_available']?.toString() ?? '0',
                        label: 'Credits',
                        icon: Icons.bolt,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StatCard(
                        value: '0.0', // TODO: Add API for average rating
                        label: 'Avg Rating',
                        icon: Icons.star,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
                // Subscription Plan Card
              Builder(builder: (context) {
                final plan = _creditData?['plan'];
                final planName = plan != null ? plan['name'] : 'No Active Plan';
                final planCredits = _creditData?['plan_credits'] ?? 0;
                final isPro = planName.toString().toLowerCase().contains('pro');
                
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isPro 
                          ? [const Color(0xFF10B981), const Color(0xFF059669)]
                          : [const Color(0xFF6B7280), const Color(0xFF4B5563)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          if (isPro)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                'PRO',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Lexend',
                                ),
                              ),
                            ),
                          const Spacer(),
                          const Icon(
                            Icons.workspace_premium,
                            color: Colors.white,
                            size: 24,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        planName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Lexend',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        plan != null 
                            ? '$planCredits credits/month' 
                            : 'Upgrade to book classes',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 14,
                          fontFamily: 'Inter',
                        ),
                      ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          await Navigator.pushNamed(context, AppRoutes.plans);
                          if (context.mounted) {
                            _fetchProfile();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF10B981),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Manage Plan',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Lexend',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 32),
              // Account Section
              const _SectionHeader(title: 'ACCOUNT'),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFFE2E8F0),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    _MenuItem(
                      icon: Icons.person_outline,
                      title: 'Personal Information',
                      onTap: () async {
                        await Navigator.pushNamed(context, AppRoutes.editProfile);
                        _fetchProfile();
                      },
                    ),
                    const Divider(height: 1, color: Color(0xFFE2E8F0)),
                    _MenuItem(
                      icon: Icons.credit_card_outlined,
                      title: 'Billing',
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.plans);
                      },
                    ),
                    const Divider(height: 1, color: Color(0xFFE2E8F0)),
                    _MenuItem(
                      icon: Icons.bolt_outlined,
                      title: 'Credits & Transactions',
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.plans);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              // Preferences Section
              const _SectionHeader(title: 'PREFERENCES'),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFFE2E8F0),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    _MenuItem(
                      icon: Icons.fitness_center_outlined,
                      title: 'Fitness Interests',
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.fitnessInterests);
                      },
                    ),
                    const Divider(height: 1, color: Color(0xFFE2E8F0)),
                    _MenuItem(
                      icon: Icons.location_on_outlined,
                      title: 'Location',
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.locationPreferences);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              // Support Section
              const _SectionHeader(title: 'SUPPORT'),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFFE2E8F0),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    _MenuItem(
                      icon: Icons.help_outline,
                      title: 'Help & FAQ',
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.helpSupport);
                      },
                    ),
                    const Divider(height: 1, color: Color(0xFFE2E8F0)),
                    _MenuItem(
                      icon: Icons.headset_mic_outlined,
                      title: 'Contact Support',
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.helpSupport);
                      },
                    ),
                    const Divider(height: 1, color: Color(0xFFE2E8F0)),
                    _MenuItem(
                      icon: Icons.description_outlined,
                      title: 'Terms & Privacy',
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.termsPolicy);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              // Logout Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _handleLogout,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFEE2E2),
                      foregroundColor: const Color(0xFFEF4444),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.logout, size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Log Out',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Lexend',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 4),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;

  const _StatCard({
    required this.value,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 24,
            color: const Color(0xFF10B981),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
              fontFamily: 'Lexend',
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF64748B),
              fontSize: 12,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
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
          style: const TextStyle(
            color: Color(0xFF64748B),
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
            fontFamily: 'Inter',
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
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Icon(
              icon,
              color: const Color(0xFF64748B),
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF0F172A),
                  fontFamily: 'Inter',
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Color(0xFF94A3B8),
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
