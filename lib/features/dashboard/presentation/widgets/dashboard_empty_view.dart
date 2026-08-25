// ignore_for_file: deprecated_member_use

import 'package:compfest/core/theme/app_colors.dart';
import 'package:compfest/core/theme/app_typography.dart';
import 'package:compfest/features/dashboard/presentation/widgets/step_instruction_card.dart';
import 'package:compfest/shared/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardEmptyView extends StatefulWidget {
  const DashboardEmptyView({super.key});

  @override
  State<DashboardEmptyView> createState() => _DashboardEmptyViewState();
}

class _DashboardEmptyViewState extends State<DashboardEmptyView> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.3),
                borderRadius: BorderRadius.circular(13),
                border: Border.all(
                  color: const Color.fromARGB(255, 90, 89, 89).withOpacity(0.5),
                  width: 1,
                ),
              ),
              child: const Icon(Icons.person_2_outlined, color: Colors.black),
            ),
            Image.asset('assets/images/Invise.png', height: 32),
            const Icon(Icons.notifications_none, color: Colors.black),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.002),
              Container(
                padding: const EdgeInsets.all(32),
                width: screenWidth * 1.0,
                height: screenHeight * 0.42,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color(0xFFEFF4FF),
                ),
                child: Image.asset('assets/images/empty_dashboard.png'),
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                'Ready to Rescue Your Capital?',
                style: AppTypography.headline.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenHeight * 0.005),
              Text(
                "Invise's AI engine is waiting to analyze your inventory. Upload your data to detect dead stock and unlock your cash flow immediately.",
                style: AppTypography.body.copyWith(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenHeight * 0.04),
              PrimaryButton(
                text: 'Upload CSV Data',
                icon: 'assets/icons/upload.png',
                isLoading: false,
                onPressed: () {
                  Get.toNamed('/upload');
                },
              ),
              SizedBox(height: screenHeight * 0.03),
              Text(
                'HOW IT WORKS',
                style: AppTypography.label.copyWith(fontSize: 12),
              ),
              SizedBox(height: screenHeight * 0.01),
              StepInstructionCard(
                icon: 'assets/icons/step_1.png',
                title: '1. Sync Data',
                description:
                    'Securely upload your CSV or connect your inventory source.',
              ),
              SizedBox(height: 12),
              StepInstructionCard(
                icon: 'assets/icons/step_2.png',
                title: '2. AI Diagnosis',
                description:
                    'The engine autonomously detects dead stock and locked capital.',
              ),
              SizedBox(height: 12),
              StepInstructionCard(
                icon: 'assets/icons/step_3.png',
                title: '3. Rescue Capital',
                description:
                    'Execute generated strategies to liquidate and recover funds.',
              ),
              SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
