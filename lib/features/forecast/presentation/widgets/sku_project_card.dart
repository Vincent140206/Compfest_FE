import 'package:flutter/material.dart';
import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:compfest/core/theme/app_typography.dart';

class SkuProjectionCard extends StatelessWidget {
  final String sku;
  final String name;
  final Color trendColor;
  final String trendText;
  final String badgeText;
  final Color badgeColor;
  final Color badgeTextColor;
  final List<double> chartData;

  const SkuProjectionCard({
    super.key,
    required this.sku,
    required this.name,
    required this.trendColor,
    required this.trendText,
    required this.badgeText,
    required this.badgeColor,
    this.badgeTextColor = Colors.white,
    required this.chartData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                color: Colors.grey.shade200,
                child: const Icon(Icons.checkroom, color: Colors.grey),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sku,
                    style: AppTypography.label.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    name,
                    style: AppTypography.body.copyWith(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          SizedBox(
            height: 35,
            width: double.infinity,
            child: Sparkline(
              data: chartData,
              lineColor: trendColor,
              lineWidth: 2.5,
              useCubicSmoothing: true,
              cubicSmoothingFactor: 0.2,
            ),
          ),
          const SizedBox(height: 12),

          Text(
            trendText,
            style: AppTypography.label.copyWith(
              color: trendColor,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),

          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: badgeColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                badgeText,
                style: AppTypography.label.copyWith(
                  color: badgeTextColor,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
