import 'package:get/get.dart';
import 'package:compfest/core/network/dio_client.dart';
import 'package:compfest/core/network/api_endpoints.dart';

class DashboardController extends GetxController {
  var isDataUploaded = false.obs;
  var stockBatches = <String>[].obs;
  var isLoadingBatches = false.obs;
  var selectedBatchId = ''.obs;

  var deadStockItems = <Map<String, dynamic>>[].obs;
  var isLoadingItems = false.obs;

  double get totalCapitalLocked {
    return deadStockItems.fold(0.0, (sum, item) {
      final value = item['value_locked'];
      if (value is num) return sum + value;
      if (value is String) return sum + (double.tryParse(value) ?? 0.0);
      return sum;
    });
  }

  var selectedStatusFilter = 'All'.obs;
  var selectedSort = 'Default'.obs;

  List<Map<String, dynamic>> get filteredAndSortedItems {
    List<Map<String, dynamic>> items = List.from(deadStockItems);
    
    // Filter
    if (selectedStatusFilter.value != 'All') {
      items = items.where((item) {
        final status = (item['deadstock_status']?.toString() ?? '').toLowerCase().trim();
        final filter = selectedStatusFilter.value.toLowerCase().trim();
        if (filter.contains('healthy') && status.contains('healthy')) return true;
        if (filter.contains('slow') && status.contains('slow')) return true;
        if (filter.contains('dead') && status.contains('dead')) return true;
        return false;
      }).toList();
    }
    
    // Sort
    if (selectedSort.value != 'Default') {
      items.sort((a, b) {
        final valA = double.tryParse(a['value_locked']?.toString() ?? '0') ?? 0.0;
        final valB = double.tryParse(b['value_locked']?.toString() ?? '0') ?? 0.0;
        if (selectedSort.value == 'Value (High to Low)') {
          return valB.compareTo(valA);
        } else {
          return valA.compareTo(valB);
        }
      });
    }
    
    return items;
  }

  @override
  void onInit() {
    super.onInit();
    fetchStockBatches();
  }

  Future<void> fetchStockBatches() async {
    isLoadingBatches.value = true;
    try {
      final dio = DioClient().dio;
      final response = await dio.get(ApiEndpoints.getStocks);
      
      if (response.statusCode == 200) {
        final List<dynamic> dataList = response.data['data'] ?? [];
        stockBatches.value = dataList.map((e) => e.toString()).toList();
        
        if (stockBatches.isNotEmpty) {
          isDataUploaded.value = true;
          selectedBatchId.value = stockBatches.first;
          await fetchStockItems(stockBatches.first);
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load stock batches');
    } finally {
      isLoadingBatches.value = false;
    }
  }

  Future<void> fetchStockItems(String batchId) async {
    isLoadingItems.value = true;
    try {
      final dio = DioClient().dio;
      final response = await dio.get(ApiEndpoints.getStockItems(batchId));
      
      if (response.statusCode == 200) {
        final List<dynamic> dataList = response.data['data'] ?? [];
        deadStockItems.value = List<Map<String, dynamic>>.from(dataList);
      }
    } catch (e) {
      print('Fetch Stock Items Error: $e');
      Get.snackbar('Error', 'Failed to load stock items');
    } finally {
      isLoadingItems.value = false;
    }
  }

  void uploadData() {
    isDataUploaded.value = true;
    fetchStockBatches(); // Refresh after upload
  }
}

