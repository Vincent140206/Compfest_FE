// ignore_for_file: deprecated_member_use

import 'package:compfest/core/theme/app_colors.dart';
import 'package:compfest/core/theme/app_typography.dart';
import 'package:compfest/features/dead_stock/presentation/pages/widgets/opportunity_cost_card.dart';
import 'package:intl/intl.dart';
import 'package:compfest/features/dead_stock/presentation/pages/widgets/root_cause_chart.dart';
import 'package:compfest/shared/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:compfest/features/dead_stock/presentation/controllers/dead_stock_detail_controller.dart';

class DeadStockDetailPage extends StatefulWidget {
  const DeadStockDetailPage({super.key});

  @override
  State<DeadStockDetailPage> createState() => _DeadStockDetailPageState();
}

class _DeadStockDetailPageState extends State<DeadStockDetailPage> {
  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    String itemsId = '';
    String passedStatus = 'Unknown';
    if (args is Map) {
      itemsId = args['itemsId']?.toString() ?? '';
      passedStatus = args['status']?.toString() ?? 'Unknown';
    } else if (args is String) {
      itemsId = args;
    }
    final controller = Get.put(DeadStockDetailController(itemsId));
    
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('assets/images/inviseLogoName.png')
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
                  SizedBox(height: screenHeight * 0.02),
                  Obx(() {
                    if (controller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    
                    final item = controller.itemDetails;
                    final apiStatus = item['deadstock_status']?.toString();
                    final statusString = (apiStatus == null || apiStatus.trim().isEmpty || apiStatus.toLowerCase() == 'unknown') 
                        ? passedStatus.toLowerCase().trim() 
                        : apiStatus.toLowerCase().trim();
                    Color badgeColor = AppColors.tertiary;
                    IconData badgeIcon = Icons.info_outline;
                    String badgeText = 'Unknown';

                    if (statusString.contains('healthy')) {
                      badgeColor = Colors.green;
                      badgeIcon = Icons.favorite;
                      badgeText = 'Healthy';
                    } else if (statusString.contains('slow')) {
                      badgeColor = Colors.amber.shade700;
                      badgeIcon = Icons.warning_rounded;
                      badgeText = 'Slow-moving';
                    } else if (statusString.contains('dead')) {
                      badgeColor = Colors.red;
                      badgeIcon = Icons.trending_down;
                      badgeText = 'Dead Stock';
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: badgeColor.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(badgeIcon, size: 16, color: badgeColor),
                                  const SizedBox(width: 4),
                                  Text(
                                    badgeText,
                                    style: TextStyle(
                                      color: badgeColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Text(
                                'SKU: ${item['sku'] ?? '-'}',
                                style: AppTypography.label.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Text(
                          item['name'] ?? 'Unknown Item',
                          style: AppTypography.headline.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.015),
                        Text(
                          'Quantity: ${item['quantity'] ?? 0}  •  Value: ${NumberFormat.currency(locale: 'en_US', symbol: '\$', decimalDigits: 2).format(double.tryParse(item['value_locked']?.toString() ?? '0') ?? 0.0)}  •  Price: ${NumberFormat.currency(locale: 'en_US', symbol: '\$', decimalDigits: 2).format(double.tryParse(item['current_price']?.toString() ?? '0') ?? 0.0)}',
                          style: AppTypography.body.copyWith(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                      ],
                    );
                  }),
                  SizedBox(height: screenHeight * 0.02),
                  Obx(() {
                    if (controller.isLoadingDiagnose.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final diagnose = controller.itemDiagnose;
                    final optCostVal = diagnose['opportunity_cost'];
                    final double opportunityCost = optCostVal is num 
                        ? optCostVal.toDouble() 
                        : (double.tryParse(optCostVal?.toString() ?? '0') ?? 0.0);
                    final List<dynamic> reasons = diagnose['reasons'] ?? [];

                    return Column(
                      children: [
                        OpportunityCostCard(opportunityCost: opportunityCost),
                        SizedBox(height: screenHeight * 0.02),
                        RootCauseChart(reasons: reasons),
                      ],
                    );
                  }),
                  SizedBox(height: screenHeight * 0.02)
            ],
          ),
        ),
      ),
    );
  }
}
