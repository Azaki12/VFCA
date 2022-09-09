import 'dart:async';
import 'package:get/get.dart';
import '../../../data/services/app_services.dart';
import '../../../routes/app_pages.dart';

class SplashScreenController extends GetxController {
  final AppServices _appServices = Get.find<AppServices>();

  @override
  void onInit() {
    startTimer();
    super.onInit();
  }

  startTimer() {
    Timer(
      const Duration(seconds: 3),
      () {
        Get.offAllNamed(Routes.home);
      },
    );
  }
}
