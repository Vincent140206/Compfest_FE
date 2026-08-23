import 'package:compfest/features/forecast/presentation/widgets/early_warning_banner.dart';
import 'package:compfest/features/forecast/presentation/widgets/market_context_card.dart';
import 'package:compfest/features/forecast/presentation/widgets/sku_project_card.dart';
import 'package:flutter/material.dart';
import 'package:compfest/core/theme/app_colors.dart';
import 'package:compfest/core/theme/app_typography.dart';

class ForecastPage extends StatelessWidget {
  const ForecastPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(width: 12),
            Text('Flozy', style: AppTypography.headline.copyWith(fontSize: 20)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications_none,
              color: AppColors.primary,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Predictive Demand Engine',
              style: AppTypography.headline.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Real-time SKU forecasting and market intelligence.',
              style: AppTypography.label.copyWith(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 24),

            const EarlyWarningBanner(),
            const SizedBox(height: 24),

            const MarketContextCard(),
            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ACTIVE SKU\nPROJECTIONS',
                  style: AppTypography.label.copyWith(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
                Row(
                  children: [
                    _buildToggleBtn('7\nDay', true),
                    _buildToggleBtn('14\nDay', false),
                    _buildToggleBtn('30\nDay', false),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            SkuProjectionCard(
              sku: 'SKU-8924',
              name: 'Oversized Navy Hoodie',
              trendColor: Colors.green,
              trendText: '+24% Proj. Demand',
              badgeText: 'Safe to Restock',
              badgeColor: AppColors.primary,
              chartData: const [0.0, 1.0, 1.5, 2.0, 1.8, 2.5],
            ),
            SkuProjectionCard(
              sku: 'SKU-1105',
              name: 'Slim Fit Charcoal Tee',
              trendColor: AppColors.secondary,
              trendText: '-32% Proj. Demand',
              badgeText: 'Hold',
              badgeColor: Colors.grey.shade200,
              badgeTextColor: Colors.black87,
              chartData: const [2.5, 2.0, 1.5, 1.0, 0.5, 0.0],
            ),
            SkuProjectionCard(
              sku: 'SKU-4432',
              name: 'Standard Beige Cargo',
              trendColor: Colors.black,
              trendText: 'Stable Demand',
              badgeText: 'Safe to Restock',
              badgeColor: AppColors.primary,
              chartData: const [1.0, 1.1, 1.0, 0.9, 1.0, 1.1],
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleBtn(String text, bool isActive) {
    return Container(
      margin: const EdgeInsets.only(left: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : AppColors.background,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: AppTypography.label.copyWith(
          fontSize: 10,
          color: isActive ? Colors.white : AppColors.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
