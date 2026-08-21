import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTypography {
  static TextStyle headline = GoogleFonts.montserrat(
    color: AppColors.primary,
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );

  static TextStyle body = GoogleFonts.inter(
    color: AppColors.primary,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static TextStyle label = GoogleFonts.inter(
    color: AppColors.neutral,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
}
