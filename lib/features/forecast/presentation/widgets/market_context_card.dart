import 'package:flutter/material.dart';
import 'package:compfest/core/theme/app_colors.dart';
import 'package:compfest/core/theme/app_typography.dart';

class MarketContextCard extends StatelessWidget {
  const MarketContextCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.psychology, size: 18, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                'EXTERNAL MARKET CONTEXT',
                style: AppTypography.label.copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Category Trend Alert: LLM analysis indicates a rapid shift towards oversized styles in urban demographics. Projected 45% increase in demand for relaxed-fit outerwear. Tapered cuts showing early signs of stagnation in key coastal markets.',
              style: AppTypography.body.copyWith(
                fontSize: 13,
                height: 1.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Confidence: 87%',
                style: AppTypography.label.copyWith(fontSize: 12),
              ),
              Text(
                'Read Full Report',
                style: AppTypography.label.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
