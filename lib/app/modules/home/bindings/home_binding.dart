import 'package:get/get.dart';
import 'package:vfca2/app/modules/fuel_consumption/controller/fuel_consumpstion_controller.dart';
import 'package:vfca2/app/modules/maps/controller/maps_controller.dart';
import 'package:vfca2/app/modules/quote_view/controller/quote_controller.dart';
import 'package:vfca2/app/modules/trip_conusmption_view/controller/trip_consumption_controller.dart';
import 'package:vfca2/app/modules/trip_conusmption_view/controller/trip_consumption_controller.dart';

import '../controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<FuelConsumptionController>(() => FuelConsumptionController());
    Get.lazyPut<TripConsumptionController>(() => TripConsumptionController());
    Get.lazyPut<QuoteController>(() => QuoteController());
    Get.put(MapsController());
  }
}
