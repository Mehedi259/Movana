import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors - Green Theme from Figma
  static const Color primary = Color(0xFF009955);
  static const Color primaryDark = Color(0xFF0B2D1E);
  static const Color secondary = Color(0xFF03DAC6);
  
  // Background Colors
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceLight = Color(0xFFF0FDF4);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textDark = Color(0xFF002212);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textTertiary = Color(0xFF94A3B8);
  static const Color textHint = Color(0xFF94A3B8);
  
  // Border Colors
  static const Color border = Color(0xFFE2E8F0);
  static const Color borderLight = Color(0xFFBFC9C1);
  
  // Success/Credit Colors
  static const Color successBg = Color(0xFFF0FDF4);
  static const Color successLight = Color(0xFFD9E6DA);
  static const Color successText = Color(0xFF5B675E);
  
  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);
  
  // Other Colors
  static const Color divider = Color(0xFFE2E8F0);
  static const Color shadow = Color(0x0F000000);
  static const Color cardShadow = Color(0x11000000);
  
  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment(0.00, 0.00),
    end: Alignment(1.00, 1.00),
    colors: [Color(0xFF0B2D1E), Color(0xFF009955)],
  );
}
