import 'package:compfest/core/theme/app_colors.dart';
import 'package:compfest/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class UploadFileCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String? selectedFileName;
  final VoidCallback onSelectFile;

  const UploadFileCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.selectedFileName,
    required this.onSelectFile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: selectedFileName != null ? AppColors.primary.withOpacity(0.05) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: selectedFileName != null ? AppColors.primary : Colors.grey.shade300,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: AppColors.primary, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTypography.body.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      selectedFileName ?? subtitle,
                      style: AppTypography.label.copyWith(
                        fontSize: 12,
                        color: selectedFileName != null ? AppColors.primary : Colors.grey.shade600,
                        fontWeight: selectedFileName != null ? FontWeight.bold : FontWeight.normal,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (selectedFileName != null)
                const Icon(Icons.check_circle, color: AppColors.primary),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: selectedFileName != null ? Colors.white : AppColors.primary,
                foregroundColor: selectedFileName != null ? AppColors.primary : Colors.white,
                side: selectedFileName != null ? const BorderSide(color: AppColors.primary) : null,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: onSelectFile,
              child: Text(
                selectedFileName != null ? 'Change File' : 'Select File',
                style: AppTypography.label.copyWith(
                  color: selectedFileName != null ? AppColors.primary : Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
