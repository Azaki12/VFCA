import 'package:get/get.dart';
import 'package:vfca2/app/modules/quote_managment/controller/quote_management_controller.dart';

class QuoteManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuoteManagementController>(() => QuoteManagementController());
  }
}
