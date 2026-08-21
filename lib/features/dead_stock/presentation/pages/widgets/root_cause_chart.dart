import 'package:compfest/core/theme/app_colors.dart';
import 'package:compfest/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart'; // Import library-nya

class RootCauseChart extends StatelessWidget {
  const RootCauseChart({super.key});

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Why it\'s stuck',
            style: AppTypography.headline.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 12),
          Divider(color: Colors.grey.shade300),
          const SizedBox(height: 16),

          _buildCauseItem(
            icon: Icons.money_off_csred_outlined,
            title: 'Overpriced',
            percent: 0.75,
            color: AppColors.secondary,
            isAlert: true,
          ),
          const SizedBox(height: 20),

          // 2. Item Declining Trend (Abu-abu)
          _buildCauseItem(
            icon: Icons.trending_down,
            title: 'Declining Trend',
            percent: 0.20,
            color: AppColors.neutral,
          ),
          const SizedBox(height: 20),

          _buildCauseItem(
            icon: Icons.campaign_outlined,
            title: 'Marketing Reach',
            percent: 0.05,
            color: AppColors.neutral,
          ),
        ],
      ),
    );
  }

  Widget _buildCauseItem({
    required IconData icon,
    required String title,
    required double percent,
    required Color color,
    bool isAlert = false,
  }) {
    final titleColor = isAlert ? color : Colors.grey.shade600;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: titleColor, size: 18),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: AppTypography.label.copyWith(
                    color: titleColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Text(
              '${(percent * 100).toInt()}%',
              style: AppTypography.label.copyWith(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        LinearPercentIndicator(
          padding: EdgeInsets.zero,
          lineHeight: 8.0,
          percent: percent,
          backgroundColor: const Color(0xFFD6E4FF),
          progressColor: color,
          barRadius: const Radius.circular(8),
          animation: true,
          animationDuration: 1000,
        ),
      ],
    );
  }
}
