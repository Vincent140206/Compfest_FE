import 'package:get/get.dart';
import 'package:compfest/core/network/dio_client.dart';
import 'package:compfest/core/network/api_endpoints.dart';
import 'package:compfest/features/dashboard/presentation/controllers/dashboard_controller.dart';

class ForecastController extends GetxController {
  var projections = [].obs;
  var isLoading = true.obs;
  var selectedRange = 7.obs; // Just a dummy UI state for the 7/14/30 day toggle
  var selectedFilter = 'All'.obs;

  List<dynamic> get filteredProjections {
    if (selectedFilter.value == 'All') return projections;
    return projections.where((item) {
      final decision = item['decision']?.toString().toUpperCase() ?? 'UNKNOWN';
      return decision == selectedFilter.value.toUpperCase();
    }).toList();
  }

  @override
  void onInit() {
    super.onInit();
    fetchProjections();
  }

  void fetchProjections() async {
    isLoading.value = true;
    try {
      // Find the dashboard controller to get the current selected batch
      String stockId = "";
      if (Get.isRegistered<DashboardController>()) {
        final dashboardController = Get.find<DashboardController>();
        stockId = dashboardController.selectedBatchId.value;
      }
      
      if (stockId.isEmpty) {
        // If there is no stockId, just skip or handle error
        isLoading.value = false;
        return;
      }

      final dio = DioClient().dio;
      final response = await dio.get(ApiEndpoints.getStockProjections(stockId));
      if (response.statusCode == 200) {
        projections.value = response.data['data'] ?? [];
      }
    } catch (e) {
      print('Fetch Projections Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void setRange(int days) {
    selectedRange.value = days;
  }
}
