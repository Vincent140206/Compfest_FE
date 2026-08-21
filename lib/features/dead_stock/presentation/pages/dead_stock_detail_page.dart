// ignore_for_file: deprecated_member_use

import 'package:compfest/core/theme/app_colors.dart';
import 'package:compfest/core/theme/app_typography.dart';
import 'package:compfest/features/dead_stock/presentation/pages/widgets/product_image_header.dart';
import 'package:compfest/shared/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';

class DeadStockDetailPage extends StatefulWidget {
  const DeadStockDetailPage({super.key});

  @override
  State<DeadStockDetailPage> createState() => _DeadStockDetailPageState();
}

class _DeadStockDetailPageState extends State<DeadStockDetailPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Flozy',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.02),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 24,
                        width: 100,
                        decoration: BoxDecoration(
                          color: AppColors.secondary.withOpacity(0.24),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/icons/danger.png',
                                    width: 16,
                                    height: 16,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'Dead Stock',
                                    style: TextStyle(
                                      color: AppColors.secondary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20),
                      Text(
                        'SKU: FL-SLM-RED-M',
                        style: AppTypography.label.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    'Kemeja Flanel Slim Fit',
                    style: AppTypography.headline.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  PrimaryButton(
                    icon: 'assets/icons/rescue.png',
                    text: 'Rescue Capital',
                    onPressed: () {
                      // Handle button press
                    },
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              ProductImageHeader(),
            ],
          ),
        ),
      ),
    );
  }
}
