import 'package:compfest/shared/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class DeadStockCard extends StatelessWidget {
  final String sku;
  final String productName;
  final String quantity;
  final String valueLocked;
  final String priorityLevel;
  final String itemsId;

  const DeadStockCard({
    super.key,
    required this.sku,
    required this.productName,
    required this.quantity,
    required this.valueLocked,
    required this.priorityLevel,
    required this.itemsId,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    Color priorityColor;
    IconData priorityIcon;
    final status = priorityLevel.toLowerCase().trim();

    if (status.contains('healthy')) {
      priorityColor = Colors.green;
      priorityIcon = Icons.favorite;
    } else if (status.contains('slow')) {
      priorityColor = Colors.amber.shade700;
      priorityIcon = Icons.warning_rounded;
    } else if (status.contains('dead')) {
      priorityColor = Colors.red;
      priorityIcon = Icons.trending_down;
    } else {
      priorityColor = AppColors.tertiary;
      priorityIcon = Icons.info_outline;
    }

    final containerWidth = screenWidth * 0.9;
    final containerHeight = screenHeight * 0.25;

    return Container(
      width: containerWidth,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade400),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: BoxDecoration(
          border: Border(left: BorderSide(color: priorityColor, width: 4.0)),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  sku,
                  style: AppTypography.label.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Priority Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: priorityColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(priorityIcon, size: 14, color: priorityColor),
                      const SizedBox(width: 4),
                      Text(
                        priorityLevel,
                        style: AppTypography.label.copyWith(
                          color: priorityColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            Text(
              productName,
              style: AppTypography.body.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quantity',
                      style: AppTypography.label.copyWith(fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      quantity,
                      style: AppTypography.body.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: containerWidth * 0.25),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Value Locked',
                      style: AppTypography.label.copyWith(fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      valueLocked,
                      style: AppTypography.body.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            PrimaryButton(
              text: 'Diagnose',
              icon: 'assets/icons/diagnose_icon.png',
              onPressed: () {
                Get.toNamed('/dead-stock-detail', arguments: {
                  'itemsId': itemsId,
                  'status': priorityLevel,
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
