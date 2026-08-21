import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class DeadStockCard extends StatelessWidget {
  final String sku;
  final String productName;
  final String quantity;
  final String valueLocked;
  final String priorityLevel;

  const DeadStockCard({
    super.key,
    required this.sku,
    required this.productName,
    required this.quantity,
    required this.valueLocked,
    required this.priorityLevel,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final isHighPriority = priorityLevel == 'High';
    final priorityColor = isHighPriority
        ? AppColors.secondary
        : AppColors.tertiary;
    final priorityIcon = isHighPriority
        ? Icons.trending_down
        : Icons.warning_rounded;

    final containerWidth = screenWidth * 0.9;
    final containerHeight = screenHeight * 0.25;

    return Container(
      width: containerWidth,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
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
            // Row 1: SKU & Badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  sku,
                  style: AppTypography.label.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
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

            SizedBox(
              width: double.infinity,
              height: containerHeight * 0.18,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  // TODO: Navigasi ke halaman AI Diagnosis
                },
                icon: Image.asset(
                  'assets/icons/diagnose_icon.png',
                  width: 20,
                  height: 20,
                ),
                label: Text(
                  'Diagnose',
                  style: AppTypography.label.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
