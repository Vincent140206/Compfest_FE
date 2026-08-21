import 'package:compfest/core/theme/app_colors.dart';
import 'package:compfest/features/dashboard/presentation/widgets/capital_locked_banner.dart';
import 'package:compfest/features/dashboard/presentation/widgets/dead_stock_card.dart';
import 'package:flutter/material.dart';
import '../../../../../core/theme/app_typography.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Row(
          children: [
            Image.network(
              'https://images.unsplash.com/photo-1564564244660-5d73c057f2d2?q=80&w=1476&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
              width: 32,
              height: 32,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 8),
            Text('Flozy', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 16),
              const CapitalLockedBanner(),
              const SizedBox(height: 24),

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Text(
                  'Dead Stock Alerts',
                  style: AppTypography.headline.copyWith(fontSize: 20),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 16),

              const DeadStockCard(
                sku: 'SKU-A012',
                productName: 'Premium Widget Pack',
                quantity: '450 Units',
                valueLocked: 'Rp 12.500.000',
                priorityLevel: 'High',
              ),
              const DeadStockCard(
                sku: 'SKU-B334',
                productName: 'Standard Casing V2',
                quantity: '820 Units',
                valueLocked: 'Rp 18.200.000',
                priorityLevel: 'High',
              ),
              const DeadStockCard(
                sku: 'SKU-C001',
                productName: 'Legacy Connectors',
                quantity: '1,200 Units',
                valueLocked: 'Rp 11.800.000',
                priorityLevel: 'Medium',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
