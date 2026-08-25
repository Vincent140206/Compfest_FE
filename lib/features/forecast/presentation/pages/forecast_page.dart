import 'package:compfest/features/forecast/presentation/widgets/early_warning_banner.dart';
import 'package:compfest/features/forecast/presentation/widgets/market_context_card.dart';
import 'package:compfest/features/forecast/presentation/widgets/sku_project_card.dart';
import 'package:compfest/features/forecast/presentation/controllers/forecast_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:compfest/core/theme/app_colors.dart';
import 'package:compfest/core/theme/app_typography.dart';

class ForecastPage extends StatelessWidget {
  const ForecastPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForecastController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Row(
          children: [
            Image.asset('assets/images/inviseLogoName.png', height: 28),
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
                Obx(() => Container(
                      height: 36,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: controller.selectedFilter.value,
                          icon: const Icon(Icons.filter_list, size: 16, color: AppColors.neutral),
                          style: AppTypography.label.copyWith(color: AppColors.neutral),
                          items: <String>['All', 'RESTOCK', 'HOLD', 'DISCOUNT']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            if (newValue != null) {
                              controller.selectedFilter.value = newValue;
                            }
                          },
                        ),
                      ),
                    )),
              ],
            ),
            const SizedBox(height: 16),

            Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.filteredProjections.isEmpty) {
                return const Center(child: Text('No projections available for this filter.'));
              }
              return Column(
                children: controller.filteredProjections.map<Widget>((item) {
                  final double percentage = double.tryParse(item['projection_percentage']?.toString() ?? '0') ?? 0.0;
                  final String decision = item['decision']?.toString() ?? 'UNKNOWN';
                  final List<dynamic> points = item['projection_points'] ?? [];
                  
                  List<double> chartData = [];
                  for (var point in points) {
                    if (point is List && point.length >= 2) {
                      chartData.add(double.tryParse(point[1]?.toString() ?? '0') ?? 0.0);
                    }
                  }
                  if (chartData.isEmpty) chartData = [0.0];

                  Color trendColor = percentage >= 0 ? Colors.green : AppColors.secondary;
                  String trendText = '${percentage > 0 ? '+' : ''}${percentage.toStringAsFixed(2)}% Proj. Demand';
                  
                  Color badgeColor = AppColors.primary;
                  Color badgeTextColor = Colors.white;
                  if (decision.toUpperCase() == 'HOLD') {
                    badgeColor = Colors.grey.shade200;
                    badgeTextColor = Colors.black87;
                    trendColor = AppColors.secondary;
                  } else if (decision.toUpperCase() == 'DISCOUNT') {
                    badgeColor = AppColors.secondary;
                  }

                  return SkuProjectionCard(
                    sku: item['sku']?.toString() ?? 'N/A',
                    name: item['name']?.toString() ?? 'Unknown',
                    trendColor: trendColor,
                    trendText: trendText,
                    badgeText: decision,
                    badgeColor: badgeColor,
                    badgeTextColor: badgeTextColor,
                    chartData: chartData,
                  );
                }).toList(),
              );
            }),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
