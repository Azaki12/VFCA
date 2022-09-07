import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vfca2/app/data/services/app_services.dart';
import 'package:vfca2/app/modules/fuel_consumption/view/fuel_consumption_view.dart';
import 'package:vfca2/app/modules/quote_view/view/quote_view.dart';
import 'package:vfca2/app/modules/trip_conusmption_view/view/trip_consumption_view.dart';

class HomeController extends GetxController {
  final AppServices appServices = Get.find<AppServices>();
  RxInt cindex = 0.obs;
  List<Widget>? pages = [
    const QuoteView(),
    const FuelConsumptionView(),
    const TripConsumptionView(),
  ];
  List<String> titles = ['Quote','Fuel Consumption', 'Trip Consumption'];
  List<Color> iconsColor = [
    const Color(0xFF4F4FBF),
    Colors.black,
    Colors.black
  ];
}
