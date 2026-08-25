import 'package:compfest/core/theme/app_colors.dart';
import 'package:compfest/features/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:compfest/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:compfest/features/dashboard/presentation/widgets/dashboard_empty_view.dart';
import 'package:compfest/features/forecast/presentation/pages/forecast_page.dart';
import 'package:compfest/features/main_navigation/presentation/controllers/main_navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainNavigationPage extends StatelessWidget {
  MainNavigationPage({super.key});

  final MainNavigationController _navController = Get.put(MainNavigationController());
  final DashboardController _dashboardController = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        switch (_navController.selectedIndex.value) {
          case 0:
            return _dashboardController.isDataUploaded.value
                ? const DashboardPage()
                : const DashboardEmptyView();
          case 1:
            return const ForecastPage();
          case 2:
            return const Center(child: Text('Command Page'));
          case 3:
            return const Center(child: Text('Inventory Page'));
          default:
            return const DashboardEmptyView();
        }
      }),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  index: 0,
                  label: 'Dashboard',
                  icon: Icons.alarm,
                  isSelected: _navController.selectedIndex.value == 0,
                ),
                _buildNavItem(
                  index: 1,
                  label: 'Forecast',
                  icon: Icons.analytics_outlined, // Using analytics as approximation
                  isSelected: _navController.selectedIndex.value == 1,
                ),
                _buildNavItem(
                  index: 2,
                  label: 'Command',
                  icon: Icons.auto_fix_high,
                  isSelected: _navController.selectedIndex.value == 2,
                ),
                _buildNavItem(
                  index: 3,
                  label: 'Inventory',
                  icon: Icons.inventory_2_outlined,
                  isSelected: _navController.selectedIndex.value == 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required String label,
    required IconData icon,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () => _navController.changeIndex(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : AppColors.neutral,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.neutral,
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
