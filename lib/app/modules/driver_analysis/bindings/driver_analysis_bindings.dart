import 'package:get/get.dart';
import 'package:vfca2/app/modules/quote_managment/controller/quote_management_controller.dart';

import '../controller/driver_analysis_controller.dart';

class DriverAnalysisBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DriverAnalysisController>(() => DriverAnalysisController());
  }
}
