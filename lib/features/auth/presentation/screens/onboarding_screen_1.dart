import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_routes.dart';

class OnboardingScreen1 extends StatelessWidget {
  const OnboardingScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26.0),
          child: Column(
            children: [
              const SizedBox(height: 16),
              
              // Progress Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 4,
                    decoration: const BoxDecoration(
                      color: Color(0xFF1A714A),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(99),
                        bottomLeft: Radius.circular(99),
                      ),
                    ),
                  ),
                  Container(
                    width: 60,
                    height: 4,
                    color: const Color(0xFFE1E1E1),
                  ),
                  Container(
                    width: 60,
                    height: 4,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE1E1E1),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(99),
                        bottomRight: Radius.circular(99),
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 44),
              
              // Image with gradient overlay
              Expanded(
                child: Stack(
                  children: [
                    // Main Image
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: const DecorationImage(
                          image: AssetImage('assets/Onboarding1Image.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    
                    // Gradient Overlay at bottom
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: size.height * 0.25,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white.withOpacity(0),
                              Colors.white.withOpacity(0.70),
                              Colors.white.withOpacity(0.90),
                              Colors.white,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 56),
              
              // Title
              const Text(
                'Discover Fitness Near You',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF002212),
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  height: 1.50,
                ),
              ),
              
              const SizedBox(height: 4),
              
              // Description
              const Text(
                'Discover a wide range of workouts near you — from calming yoga sessions to high-energy training — all tailored to your schedule, mood, and fitness goals.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF002212),
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 1.30,
                ),
              ),
              
              const SizedBox(height: 48),
              
              // Next Button
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0xFF0B2D1E), Color(0xFF009955)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.onboarding2);
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: const Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Next',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              height: 1.50,
                            ),
                          ),
                          SizedBox(width: 12),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
