import 'package:compfest/core/theme/app_colors.dart';
import 'package:compfest/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import '../widgets/upload_file_card.dart';

class UploadDataPage extends StatelessWidget {
  const UploadDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // 1. AppBar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: AppColors.primary),
          onPressed: () {
            // TODO: Buka drawer atau back
          },
        ),
        title: Text(
          'Import Data',
          style: AppTypography.headline.copyWith(
            fontSize: 18,
            color: AppColors.primary,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.background,
              backgroundImage: const NetworkImage(
                'https://ui-avatars.com/api/?name=User&background=0D8ABC&color=fff',
              ),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.insert_drive_file_outlined,
                  color: AppColors.primary,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  'Upload Data Files',
                  style: AppTypography.headline.copyWith(
                    fontSize: 20,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            UploadFileCard(
              icon: Icons.trending_up_rounded,
              title: 'Monthly Sales Data (.csv)',
              subtitle: 'Used for AI demand training',
              onSelectFile: () {
                Navigator.pushNamed(context, '/dashboard');
              },
            ),

            // Card 2: Unit Cost Data
            UploadFileCard(
              icon: Icons.payments_outlined,
              title: 'Unit Cost Data (.csv)',
              subtitle: 'Purchase price per item',
              onSelectFile: () {
                // TODO: Panggil fungsi file picker
              },
            ),

            // Card 3: Stock Level Data
            UploadFileCard(
              icon: Icons.inventory_2_outlined,
              title: 'Stock Level Data (.csv)',
              subtitle: 'Current inventory counts',
              onSelectFile: () {
                // TODO: Panggil fungsi file picker
              },
            ),

            const SizedBox(height: 24),

            Center(
              child: Text(
                'Max file size: 10MB per file',
                style: AppTypography.label.copyWith(
                  fontSize: 12,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
