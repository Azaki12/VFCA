import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:vfca2/app/core/utils/extensions.dart';
import 'package:vfca2/app/modules/maps/controller/maps_controller.dart';
import 'package:vfca2/app/routes/app_pages.dart';

import '../../../widgets/custom_wave_clipper.dart';
import '../controller/fuel_consumpstion_controller.dart';

class FuelConsumptionView extends GetView<FuelConsumptionController> {
  const FuelConsumptionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
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
              progressColor: Colors.yellow,
              circularStrokeCap: CircularStrokeCap.round,
              backgroundColor: Colors.grey,
              lineWidth: 15,
              percent: controller.percent!.value,
              center:
                  '${(controller.percent!.value * 100).truncate()}%'.title(),
            ),
            ElevatedButton(
                onPressed: () {
                  Get.toNamed(Routes.mapView);
                },
                child: const Text('Choose Destination')),
          ],
        ));
  }
}
