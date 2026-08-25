import 'package:get/get.dart';

class DashboardController extends GetxController {
  var isDataUploaded = false.obs;

  void uploadData() {
    isDataUploaded.value = true;
  }
}
