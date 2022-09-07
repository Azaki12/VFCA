import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vfca2/app/core/utils/extensions.dart';

class DriverAnalysisController extends GetxController {
  RxDouble percent = 0.5.obs;
  RxInt index = 0.obs;
  RxString modelReading = ''.obs;
  List<Color> categoryColors = [
    Colors.red,
    Colors.yellowAccent,
    Colors.green,
  ];

  List<Widget> categoryNames = [
    'Bad'.subtitle(),
    'Medium'.subtitle(),
    'Good'.subtitle(),
  ];

  List<double> categoryPercent = [
    1.0,
    0.5,
    1.0,
  ];
}
