import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vfca2/app/core/utils/extensions.dart';
import 'package:vfca2/app/data/services/app_services.dart';

class DriverAnalysisController extends GetxController {
  RxDouble percent = 0.5.obs;
  RxInt index = 0.obs;
  List<Color> categoryColors = [
    Colors.red,
    Colors.yellowAccent,
    Colors.green,
  ];

  List<Widget> categoryNames = [
    'Aggressive'.title(),
    'Risky'.title(),
    'Normal'.title(),
  ];

  List<double> categoryPercent = [
    1.0,
    0.5,
    1.0,
  ];

  AppServices appServices = Get.find<AppServices>();

  @override
  void onInit() {
    appServices.runModel();
    super.onInit();
  }
}
