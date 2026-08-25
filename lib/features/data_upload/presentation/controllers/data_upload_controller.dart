import 'package:compfest/core/network/api_endpoints.dart';
import 'package:compfest/core/network/dio_client.dart';
import 'package:compfest/features/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;

class DataUploadController extends GetxController {
  var monthlySalesFile = Rxn<PlatformFile>();
  var unitCostFile = Rxn<PlatformFile>();
  var stockLevelFile = Rxn<PlatformFile>();

  var isLoading = false.obs;

  bool get canUpload =>
      monthlySalesFile.value != null &&
      unitCostFile.value != null &&
      stockLevelFile.value != null;

  Future<void> pickFile(String type) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      if (type == 'monthly_sales') {
        monthlySalesFile.value = file;
      } else if (type == 'unit_cost') {
        unitCostFile.value = file;
      } else if (type == 'stock_level') {
        stockLevelFile.value = file;
      }
    }
  }

  Future<void> uploadFiles() async {
    if (!canUpload) return;

    isLoading.value = true;
    try {
      final formData = FormData.fromMap({
        'monthly_sales_data': await MultipartFile.fromFile(
          monthlySalesFile.value!.path!,
          filename: monthlySalesFile.value!.name,
        ),
        'unit_cost_data': await MultipartFile.fromFile(
          unitCostFile.value!.path!,
          filename: unitCostFile.value!.name,
        ),
        'stock_level_data': await MultipartFile.fromFile(
          stockLevelFile.value!.path!,
          filename: stockLevelFile.value!.name,
        ),
      });

      final dio = DioClient().dio;
      final response = await dio.post(
        ApiEndpoints.importStocks,
        data: formData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar('Success', 'Data uploaded successfully');
        final dashboardController = Get.find<DashboardController>();
        dashboardController.uploadData();
        Get.offAllNamed('/main');
      } else {
        Get.snackbar('Upload Failed', response.data['message'] ?? 'Unknown error');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload files: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
