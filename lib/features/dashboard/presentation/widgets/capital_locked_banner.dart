import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class CapitalLockedBanner extends StatelessWidget {
  const CapitalLockedBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.9,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: AppColors.secondary.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        // ignore: deprecated_member_use
        border: Border.all(color: AppColors.secondary.withOpacity(0.5)),
      ),
      child: Stack(
        children: [
          Row(
            children: [
              SizedBox(width: screenWidth * 0.50),
              Image.asset(
                'assets/icons/danger.png',
                width: 100,
                height: 100,
                opacity: const AlwaysStoppedAnimation(0.2),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.error, color: AppColors.secondary, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'TOTAL CAPITAL LOCKED',
                    style: AppTypography.label.copyWith(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Rp 42.500.000',
                style: AppTypography.headline.copyWith(
                  color: AppColors.secondary,
                  fontSize: screenWidth * 0.07,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Equivalent to 14 Days of Operating Costs\n(Rent/Salary)',
                style: AppTypography.label.copyWith(
                  // ignore: deprecated_member_use
                  color: AppColors.secondary.withOpacity(0.8),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
