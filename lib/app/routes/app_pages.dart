import 'dart:collection';

import 'package:get/get.dart';
import 'package:vfca2/app/modules/maps/view/map_view.dart';
import 'package:vfca2/app/modules/quote_managment/view/quote_management_view.dart';
import 'package:vfca2/app/modules/trip_conusmption_view/view/trip_consumption_view.dart';

import '../modules/driver_analysis/bindings/driver_analysis_bindings.dart';
import '../modules/driver_analysis/view/driver_analysis_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/view/home_view.dart';
import '../modules/quote_managment/bindings/quote_management_bindings.dart';


part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.home;

  static final routes = [
    // GetPage(
      // name: Routes.splash,
      // page: () => const SplashView(),
      // binding: SplashBinding(),
    // ),
    GetPage(
      name: Routes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.mapView,
      page: () => const MapScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.tripConsumptionScreen,
      page: () => const TripConsumptionView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.driverAnalysisScreen,
      page: () => const DriverAnalysisView(),
      binding: DriverAnalysisBinding(),
    ),
    GetPage(
      name: Routes.quoteManagementScreen,
      page: () => const QuoteManagementView(),
      binding: QuoteManagementBinding(),
    ),
  ];
}
