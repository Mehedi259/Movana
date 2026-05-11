import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_routes.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(32),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 6,
            offset: Offset(0, 3),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _NavItem(
            icon: Icons.home_outlined,
            activeIcon: Icons.home,
            label: 'Home',
            isActive: currentIndex == 0,
            onTap: () {
              if (currentIndex != 0) {
                Navigator.pushReplacementNamed(context, AppRoutes.home);
              }
            },
          ),
          _NavItem(
            icon: Icons.search,
            activeIcon: Icons.search,
            label: 'Search',
            isActive: currentIndex == 1,
            onTap: () {
              if (currentIndex != 1) {
                Navigator.pushReplacementNamed(context, AppRoutes.search);
              }
            },
          ),
          _NavItem(
            icon: Icons.calendar_today_outlined,
            activeIcon: Icons.calendar_today,
            label: 'Bookings',
            isActive: currentIndex == 2,
            onTap: () {
              if (currentIndex != 2) {
                Navigator.pushReplacementNamed(context, AppRoutes.bookings);
              }
            },
          ),
          _NavItem(
            icon: Icons.favorite_outline,
            activeIcon: Icons.favorite,
            label: 'Favorites',
            isActive: currentIndex == 3,
            onTap: () {
              if (currentIndex != 3) {
                Navigator.pushReplacementNamed(context, AppRoutes.favorites);
              }
            },
          ),
          _NavItem(
            icon: Icons.person_outline,
            activeIcon: Icons.person,
            label: 'Profile',
            isActive: currentIndex == 4,
            onTap: () {
              if (currentIndex != 4) {
                Navigator.pushReplacementNamed(context, AppRoutes.profile);
              }
            },
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFDFDFDF) : Colors.transparent,
          borderRadius: BorderRadius.circular(32),
          boxShadow: isActive
              ? const [
                  BoxShadow(
                    color: Color(0x0F000000),
                    blurRadius: 10,
                    offset: Offset(0, 0),
                    spreadRadius: 0,
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? activeIcon : icon,
              size: 20,
              color: AppColors.textDark,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textDark,
                fontSize: 10,
                fontWeight: FontWeight.w400,
                height: 1.20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
