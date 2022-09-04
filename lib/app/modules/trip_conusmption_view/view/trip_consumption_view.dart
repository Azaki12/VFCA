import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:vfca2/app/core/utils/extensions.dart';
import 'package:vfca2/app/modules/trip_conusmption_view/controller/trip_consumption_controller.dart';

import '../../../routes/app_pages.dart';
import '../../../widgets/custom_wave_clipper.dart';
import '../../maps/controller/maps_controller.dart';

class TripConsumptionView extends GetView<TripConsumptionController> {
  const TripConsumptionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          color: Colors.white,
          child: Column(
            children: [
              Stack(
                children: [
                  Opacity(
                    opacity: 0.5,
                    child: ClipPath(
                      clipper: WaveClipper(),
                      child: Container(
                        color: Colors.deepOrangeAccent,
                        height: 150,
                      ),
                    ),
                  ),
                  ClipPath(
                    clipper: WaveClipper(),
                    child: Container(
                      color: Colors.red,
                      height: 100,
                      alignment: Alignment.center,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              CircularPercentIndicator(
                radius: 80,
                animation: true,
                circularStrokeCap: CircularStrokeCap.round,
                curve: Curves.fastLinearToSlowEaseIn,
                progressColor: Colors.yellow,
                backgroundColor: Colors.grey,
                lineWidth: 15,
                percent: controller.percent!.value,
                center: '${(controller.percent!.value * 100).truncate()}%'.title(),
                // center: controller.appServices.info!.totalDistance.title(),
              ),
              const SizedBox(
                height: 40,
              ),
              if (controller.mapsController.info != null)
                // todo change to predicted trip consumption while changing the progress indicator
                GetBuilder<MapsController>(
                    builder: (mapController) => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            mapController.info!.totalDistance.title(),
                            const SizedBox(
                              width: 40,
                            ),
                            mapController.info!.totalDuration.title(),
                          ],
                        )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: () {
                    Get.toNamed(Routes.quoteManagementScreen);
                  }, child: const Text('QM')),
                  const SizedBox(
                    width: 40,
                  ),
                  ElevatedButton(onPressed: () {
                    Get.toNamed(Routes.driverAnalysisScreen);

                  }, child: const Text('DBA')),
                ],
              ),
            ],
          ),
        ));
  }
}
