import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:vfca2/app/data/models/directions_model.dart';
import 'package:vfca2/app/data/services/app_services.dart';
import 'package:vfca2/app/data/services/direction_repository.dart';
import 'package:vfca2/app/routes/app_pages.dart';

import '../../../core/theme/theme.dart';

class MapsController extends GetxController {
  var initialCameraPosition =
      const CameraPosition(target: LatLng(30.135513, 31.366180), zoom: 18);
  GoogleMapController? googleMapController;
  AppServices appServices = Get.find<AppServices>();
  Marker? origin;
  Marker? destination;
  Directions? info;
  Location location = Location();

  @override
  void onInit() {
    getLocationData().then((value) {
      initialCameraPosition = CameraPosition(
          target: LatLng(value!.latitude!, value.longitude!), zoom: 18);
      if (origin == null || (origin != null && destination != null)) {
        // Origin is not set OR Origin/Destination are both set
        // Set origin
        origin = Marker(
          markerId: const MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'Origin'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: LatLng(value.latitude!, value.longitude!),
        );
        // Reset destination
        destination = null;

        // Reset info
        info = null;

        update();
      }
    });
    super.onInit();
  }

  // @override
  // void onClose() {
  // googleMapController!.dispose();
  // super.onClose();
  // }

  Future<LocationData?> getLocationData() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }
    locationData = await location.getLocation();
    return locationData;
  }

  void addMarker(LatLng pos) async {
    if (origin == null || (origin != null && destination != null)) {
      // Reset destination
      destination = null;
      // Reset info
      info = null;
      update();
    } else {
      // Origin is already set
      // Set destination
      destination = Marker(
        markerId: const MarkerId('destination'),
        infoWindow: const InfoWindow(title: 'Destination'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: pos,
      );
      // Get directions
      final directions = await DirectionsRepository()
          .getDirections(origin: origin!.position, destination: pos);
      info = directions;
      Future.delayed(const Duration(seconds: 2)).then((value) async {
        // todo save cache to retrieve later
        List time = [];
        appServices.totalTime.value = 0;
        time = info!.totalDuration.split(' ');

        if (time.length == 4) {
          appServices.totalTime.value += int.parse(time[0]) * 60;
          appServices.totalTime.value += int.parse(time[2]);
        } else {
          appServices.totalTime.value += int.parse(time[0]);
        }

        await appServices.runModelFuel(appServices.totalTime.value);

        if (!appServices.neg.value) {
          appServices.consumptions.addAll({
          appServices.index.value++: [
            info!.totalDistance,
            info!.totalDuration,
            appServices.fuelConsumption.value.toStringAsFixed(3)
          ],
        });
          Get.back();
          Get.back();
        }else{
          Get.back();
          Get.back();
          UiTheme.errorGetBar('Your Current fuel wont last this trip you need to re fuel, cancelling the trip');
        }

      });
      update();
    }
  }
}
