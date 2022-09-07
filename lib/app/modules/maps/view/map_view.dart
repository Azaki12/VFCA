import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vfca2/app/core/utils/extensions.dart';
import 'package:vfca2/app/modules/maps/controller/maps_controller.dart';

class MapScreen extends GetView<MapsController> {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Pick start and end'.title(),
      ),
      body: GetBuilder<MapsController>(
        builder: (controller) => Stack(
          alignment: Alignment.center,
          children: [
            GoogleMap(
              initialCameraPosition: controller.initialCameraPosition,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              onMapCreated: (mapController) =>
                  controller.googleMapController = mapController,
              markers: {
                if (controller.origin != null) controller.origin!,
                if (controller.destination != null) controller.destination!
              },
              polylines: {
                if (controller.info != null)
                  Polyline(
                    polylineId: const PolylineId('overview_polyline'),
                    color: Colors.red,
                    width: 5,
                    points: controller.info!.polylinePoints
                        .map((e) => LatLng(e.latitude, e.longitude))
                        .toList(),
                  ),
              },
              onLongPress: controller.addMarker,
            ),
            if (controller.info != null)
              Positioned(
                top: 20.0,
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  decoration: BoxDecoration(
                      color: Colors.yellowAccent,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 2),
                          blurRadius: 6.0,
                        ),
                      ]),
                  child: Text(
                    '${controller.info!.totalDistance}, ${controller.info!.totalDuration}',
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.googleMapController!.animateCamera(controller.info != null
              ? CameraUpdate.newLatLngBounds(controller.info!.bounds, 100.0)
              : CameraUpdate.newCameraPosition(
                  controller.initialCameraPosition));
        },
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }
}
