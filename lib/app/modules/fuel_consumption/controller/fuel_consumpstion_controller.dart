import 'package:get/get.dart';
import 'package:vfca2/app/data/services/app_services.dart';
import 'package:vfca2/app/modules/maps/controller/maps_controller.dart';

class FuelConsumptionController extends GetxController{
  RxDouble percent = 0.0.obs;
  RxDouble modelReading = 3.0.obs;
  AppServices appServices = Get.find<AppServices>();
  MapsController mapsController = Get.find<MapsController>();
}