import 'package:get/get.dart';

import '../../../data/services/app_services.dart';
import '../../maps/controller/maps_controller.dart';

class QuoteManagementController extends GetxController{
  RxDouble? percent = 0.3.obs;
  AppServices appServices = Get.find<AppServices>();
  MapsController mapsController = Get.find<MapsController>();
}