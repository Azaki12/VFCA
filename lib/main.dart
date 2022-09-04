import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'app/core/theme/theme.dart';
import 'app/data/services/app_services.dart';
import 'app/routes/app_pages.dart';

Future<void> initServices() async {
  Get.log('starting services ...');
  await Get.putAsync<AppServices>(() async => AppServices());
  Get.log('All services started...');
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final appServices = Get.find<AppServices>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        title: 'VFCA',
        theme: UiTheme.light,
        darkTheme: UiTheme.dark,
        themeMode: appServices.isDark.value ? ThemeMode.dark : ThemeMode.light,
        debugShowCheckedModeBanner: false,
        initialRoute: AppPages.initial,
        getPages: AppPages.routes,
        defaultTransition: Transition.cupertino,
      ),
    );
    // return MaterialApp(home: MapSample());
  }
}
