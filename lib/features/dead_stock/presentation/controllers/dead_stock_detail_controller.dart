import 'package:compfest/core/network/api_endpoints.dart';
import 'package:compfest/core/network/dio_client.dart';
import 'package:get/get.dart';

class DeadStockDetailController extends GetxController {
  final String itemsId;
  DeadStockDetailController(this.itemsId);

  var isLoading = true.obs;
  var itemDetails = {}.obs;

  var isLoadingDiagnose = true.obs;
  var itemDiagnose = {}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchItemDetails();
    fetchItemDiagnose();
  }

  Future<void> fetchItemDetails() async {
    isLoading.value = true;
    try {
      final dio = DioClient().dio;
      final response = await dio.get(ApiEndpoints.getItemDetails(itemsId));
      
      if (response.statusCode == 200) {
        itemDetails.value = response.data['data'] ?? {};
      }
    } catch (e) {
      print('Fetch Item Details Error: $e');
      Get.snackbar('Error', 'Failed to fetch item details');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchItemDiagnose() async {
    isLoadingDiagnose.value = true;
    try {
      final dio = DioClient().dio;
      final response = await dio.get(ApiEndpoints.getItemDiagnose(itemsId));
      
      if (response.statusCode == 200) {
        itemDiagnose.value = response.data['data'] ?? {};
      }
    } catch (e) {
      print('Fetch Item Diagnose Error: $e');
      Get.snackbar('Error', 'Failed to fetch item diagnose');
    } finally {
      isLoadingDiagnose.value = false;
    }
  }
}
