import 'package:get/get.dart';

import '../controller/driver_analysis_controller.dart';

class DriverAnalysisBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DriverAnalysisController>(() => DriverAnalysisController());
  }
}
