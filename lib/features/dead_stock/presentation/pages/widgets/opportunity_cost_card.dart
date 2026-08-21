import 'package:compfest/core/theme/app_colors.dart';
import 'package:compfest/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class OpportunityCostCard extends StatelessWidget {
  const OpportunityCostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0XFFFFDAD6),
            ),
            child: Center(
              child: Image.asset(
                'assets/icons/dollar.png',
                width: 20,
                height: 20,
              ),
            ),
          ),
          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'OPPORTUNITY COST',
                  style: AppTypography.label.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade600,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 8),

                Text.rich(
                  TextSpan(
                    text: 'This item is eating ',
                    style: AppTypography.body.copyWith(fontSize: 14),
                    children: [
                      TextSpan(
                        text: 'Rp 150.000 / month',
                        style: AppTypography.body.copyWith(
                          fontSize: 18,
                          color: AppColors.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: ' in storage & locked capital.',
                        style: AppTypography.body.copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
