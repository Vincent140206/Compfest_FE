// ignore_for_file: deprecated_member_use

import 'package:compfest/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class StepInstructionCard extends StatelessWidget {
  final String? icon;
  final String title;
  final String description;

  const StepInstructionCard({
    super.key,
    this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 38),
      width: double.infinity,
      height: 170,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Color(0XFFDCE9FF),
            ),
            child: Image.asset(icon!, width: 15, height: 15),
          ),
          SizedBox(height: 10),
          Text(
            title,
            style: AppTypography.headline.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text(
            description,
            style: AppTypography.body.copyWith(fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
