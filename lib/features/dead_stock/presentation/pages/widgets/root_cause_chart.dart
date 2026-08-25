import 'package:compfest/core/theme/app_colors.dart';
import 'package:compfest/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart'; // Import library-nya

class RootCauseChart extends StatelessWidget {
  final List<dynamic> reasons;

  const RootCauseChart({super.key, required this.reasons});

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
          
          if (reasons.isEmpty)
            const Text('No reasons found.')
          else
            ...reasons.map((reason) {
              final name = reason['name'] ?? 'Unknown';
              final percentageVal = reason['percentage'];
              double percentage = 0.0;
              if (percentageVal is num) {
                percentage = percentageVal.toDouble() / 100.0;
              } else if (percentageVal is String) {
                percentage = (double.tryParse(percentageVal) ?? 0.0) / 100.0;
              }
              final isTopReason = reasons.indexOf(reason) == 0;
              
              return Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: _buildCauseItem(
                  icon: isTopReason ? Icons.money_off_csred_outlined : Icons.trending_down,
                  title: name,
                  percent: percentage,
                  color: isTopReason ? AppColors.secondary : AppColors.neutral,
                  isAlert: isTopReason,
                ),
              );
            }),
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
