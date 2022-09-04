import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/directions_model.dart';

class AppServices extends GetxService {
  @override
  onInit() {
    super.onInit();
    SystemChrome.setPreferredOrientations(const [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }


  /*--------------------------------------------------------------------------*/
  /*------------------------------  Variables  -------------------------------*/
  /*--------------------------------------------------------------------------*/
  RxBool isDark = false.obs;
  RxInt index = 0.obs;
  RxMap<int, List<String>> consumptions = <int, List<String>>{}.obs;
}
