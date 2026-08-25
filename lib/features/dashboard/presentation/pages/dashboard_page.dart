import 'package:compfest/core/theme/app_colors.dart';
import 'package:compfest/features/dashboard/presentation/widgets/dashboard_empty_view.dart';
import 'package:compfest/features/dashboard/presentation/widgets/capital_locked_banner.dart';
import 'package:compfest/features/dashboard/presentation/widgets/dead_stock_card.dart';
import 'package:compfest/features/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:compfest/features/auth/presentation/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart' as import_shared_prefs;
import 'package:intl/intl.dart';
import '../../../../../core/theme/app_typography.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/images/inviseLogoName.png', height: 28),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
          IconButton(icon: const Icon(Icons.logout), onPressed: () async {
            final prefs = await import_shared_prefs.SharedPreferences.getInstance();
            await prefs.remove('token');
            Get.offAllNamed('/login');
          }),
        ],
      ),
      body: Obx(() {
        if (!controller.isDataUploaded.value && !controller.isLoadingBatches.value) {
          return const DashboardEmptyView();
        }
        
        return SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 16),
                CapitalLockedBanner(totalAmount: controller.totalCapitalLocked),
                const SizedBox(height: 24),

              const SizedBox(height: 16),
              
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Dead Stock Alerts',
                      style: AppTypography.headline.copyWith(fontSize: 20),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Obx(() => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: controller.selectedStatusFilter.value,
                            isDense: true,
                            isExpanded: true,
                            icon: const Icon(Icons.filter_list, size: 18),
                            items: ['All', 'Healthy', 'Slow-moving', 'Dead stock'].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value, style: AppTypography.label.copyWith(fontSize: 13)),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              if (newValue != null) controller.selectedStatusFilter.value = newValue;
                            },
                          ),
                        ),
                      )),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Obx(() => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: controller.selectedSort.value,
                            isDense: true,
                            isExpanded: true,
                            icon: const Icon(Icons.sort, size: 18),
                            items: ['Default', 'Value (High to Low)', 'Value (Low to High)'].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value, style: AppTypography.label.copyWith(fontSize: 13)),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              if (newValue != null) controller.selectedSort.value = newValue;
                            },
                          ),
                        ),
                      )),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              
              Obx(() {
                if (controller.isLoadingItems.value) {
                  return const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: CircularProgressIndicator(),
                  );
                }
                
                final filteredItems = controller.filteredAndSortedItems;
                
                if (filteredItems.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text('No items match the current filter.'),
                  );
                }
                
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    final item = filteredItems[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                      child: DeadStockCard(
                        sku: item['sku']?.toString() ?? 'N/A',
                        productName: item['name']?.toString() ?? 'Unknown',
                        quantity: '${item['quantity'] ?? 0} Units',
                        valueLocked: NumberFormat.currency(
                          locale: 'en_US',
                          symbol: '\$',
                          decimalDigits: 2,
                        ).format(double.tryParse(item['value_locked']?.toString() ?? '0') ?? 0.0),
                        priorityLevel: item['deadstock_status']?.toString() ?? 'Unknown',
                        itemsId: item['items_id']?.toString() ?? '',
                      ),
                    );
                  },
                );
              }),
            ],
          ),
        ),
      );
    }),
    );
  }
}

