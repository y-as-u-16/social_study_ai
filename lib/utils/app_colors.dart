import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF4A90E2);
  static const Color primaryLight = Color(0xFF7BB3F0);
  static const Color primaryDark = Color(0xFF2968B3);
  
  static const Color secondary = Color(0xFF50C878);
  static const Color secondaryLight = Color(0xFF7ED596);
  static const Color secondaryDark = Color(0xFF3BA05A);
  
  static const Color accent = Color(0xFFFF6B6B);
  static const Color accentLight = Color(0xFFFF8E8E);
  static const Color accentDark = Color(0xFFE54B4B);
  
  static const Color background = Color(0xFFF8F9FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceLight = Color(0xFFF1F3F4);
  
  static const Color textPrimary = Color(0xFF212529);
  static const Color textSecondary = Color(0xFF6C757D);
  static const Color textDisabled = Color(0xFF9CA3AF);
  
  static const Color success = Color(0xFF28A745);
  static const Color successLight = Color(0xFF4CAF50);
  static const Color successDark = Color(0xFF1E7E34);
  
  static const Color warning = Color(0xFFFFC107);
  static const Color warningLight = Color(0xFFFFD54F);
  static const Color warningDark = Color(0xFFF57F17);
  
  static const Color error = Color(0xFFDC3545);
  static const Color errorLight = Color(0xFFEF5350);
  static const Color errorDark = Color(0xFFC62828);
  
  static const Color info = Color(0xFF17A2B8);
  static const Color infoLight = Color(0xFF4FC3F7);
  static const Color infoDark = Color(0xFF0277BD);
  
  static const Color cardShadowColor = Color(0x1A000000);
  static const Color divider = Color(0xFFE9ECEF);
  static const Color border = Color(0xFFDEE2E6);
  static const Color borderLight = Color(0xFFF1F3F4);
  
  static const Color gradientStart = Color(0xFF667eea);
  static const Color gradientEnd = Color(0xFF764ba2);
  
  static const Color shimmerBase = Color(0xFFE0E0E0);
  static const Color shimmerHighlight = Color(0xFFF5F5F5);
  
  static const Color overlay = Color(0x66000000);
  static const Color overlayLight = Color(0x33000000);
  
  static Color getSubjectColor(String subject) {
    switch (subject) {
      case '歴史':
        return const Color(0xFF3B82F6);
      case '地理':
        return const Color(0xFF10B981);
      case '公民':
        return const Color(0xFFF59E0B);
      default:
        return textSecondary;
    }
  }
  
  static Color getSubjectColorLight(String subject) {
    switch (subject) {
      case '歴史':
        return const Color(0xFFDBEAFE);
      case '地理':
        return const Color(0xFFD1FAE5);
      case '公民':
        return const Color(0xFFFEF3C7);
      default:
        return surfaceLight;
    }
  }
  
  static Color getSubjectColorDark(String subject) {
    switch (subject) {
      case '歴史':
        return const Color(0xFF1E40AF);
      case '地理':
        return const Color(0xFF059669);
      case '公民':
        return const Color(0xFFD97706);
      default:
        return textSecondary;
    }
  }
  
  static Color getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case 'easy':
        return success;
      case 'medium':
        return warning;
      case 'hard':
        return error;
      default:
        return textSecondary;
    }
  }
  
  static Color getDifficultyColorLight(String difficulty) {
    switch (difficulty) {
      case 'easy':
        return const Color(0xFFDCFCE7);
      case 'medium':
        return const Color(0xFFFEF3C7);
      case 'hard':
        return const Color(0xFFFEE2E2);
      default:
        return surfaceLight;
    }
  }
  
  static Color getScoreColor(int percentage) {
    if (percentage >= 80) {
      return success;
    } else if (percentage >= 60) {
      return warning;
    } else {
      return error;
    }
  }
  
  static LinearGradient get primaryGradient => const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [gradientStart, gradientEnd],
  );
  
  static LinearGradient getSubjectGradient(String subject) {
    final baseColor = getSubjectColor(subject);
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        baseColor.withValues(alpha: 0.8),
        baseColor.withValues(alpha: 0.6),
      ],
    );
  }
  
  static BoxShadow get cardShadow => const BoxShadow(
    color: AppColors.cardShadowColor,
    blurRadius: 8,
    offset: Offset(0, 2),
  );
  
  static BoxShadow get elevatedCardShadow => const BoxShadow(
    color: AppColors.cardShadowColor,
    blurRadius: 16,
    offset: Offset(0, 4),
  );
  
  static List<BoxShadow> get softShadow => [
    const BoxShadow(
      color: AppColors.cardShadowColor,
      blurRadius: 10,
      offset: Offset(0, 2),
    ),
    const BoxShadow(
      color: AppColors.cardShadowColor,
      blurRadius: 2,
      offset: Offset(0, 1),
    ),
  ];
}