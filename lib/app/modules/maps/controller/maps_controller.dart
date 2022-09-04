import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vfca2/app/data/models/directions_model.dart';
import 'package:vfca2/app/data/services/app_services.dart';
import 'package:vfca2/app/data/services/direction_repository.dart';
import 'package:vfca2/app/routes/app_pages.dart';

class MapsController extends GetxController {
  var initialCameraPosition =
      const CameraPosition(target: LatLng(30.135513, 31.366180), zoom: 11.5);
  GoogleMapController? googleMapController;
  AppServices appServices = Get.find<AppServices>();
  Marker? origin;
  Marker? destination;
  Directions? info;

  @override
  void onClose() {
    googleMapController!.dispose();
    super.onClose();
  }

  void addMarker(LatLng pos) async {
    if (origin == null || (origin != null && destination != null)) {
      // Origin is not set OR Origin/Destination are both set
      // Set origin
      origin = Marker(
        markerId: const MarkerId('origin'),
        infoWindow: const InfoWindow(title: 'Origin'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        position: pos,
      );
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
      Future.delayed(const Duration(seconds: 2)).then((value) {
        // todo run phase 2 model
        // todo save cache to retrieve later
        appServices.consumptions.addAll({
          appServices.index.value++: [info!.totalDistance, info!.totalDuration],
        });
        Get.back();
      });
      update();
    }
  }
}
