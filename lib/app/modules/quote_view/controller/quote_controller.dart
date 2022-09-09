import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vfca2/app/data/services/app_services.dart';

import '../../../widgets/global_textfield.dart';

class QuoteController extends GetxController{
  RxDouble? percent = 0.0.obs;
  // RxDouble fuel = 0.0.obs;
  AppServices appServices = Get.find<AppServices>();


}