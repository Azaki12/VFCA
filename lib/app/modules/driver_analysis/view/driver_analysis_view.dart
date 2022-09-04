import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:vfca2/app/core/utils/extensions.dart';
import 'package:vfca2/app/modules/driver_analysis/controller/driver_analysis_controller.dart';

import '../../../widgets/custom_wave_clipper.dart';

class DriverAnalysisView extends GetView<DriverAnalysisController> {
  const DriverAnalysisView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Driver Behavior Analysis'.title(),
      ),
      body: Obx(() => Center(
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
                CircularPercentIndicator(
                  radius: 80,
                  animation: true,
                  progressColor:
                      controller.categoryColors[controller.index.value],
                  circularStrokeCap: CircularStrokeCap.round,
                  backgroundColor: Colors.grey,
                  lineWidth: 15,
                  percent: controller.categoryPercent[controller.index.value],
                  center: controller.categoryNames[controller.index.value],
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    onPressed: () {
                      Random r = Random();
                      controller.index.value = r.nextInt(3);
                    },
                    child: const Text('dsad')),
                'Tips'.title(),
                const SizedBox(
                  height: 30,
                ),
                CircularPercentIndicator(
                  radius: 80,
                  animation: true,
                  progressColor:
                      controller.categoryColors[controller.index.value],
                  circularStrokeCap: CircularStrokeCap.round,
                  backgroundColor: Colors.grey,
                  lineWidth: 13,
                  percent: 0.5,
                  center: 'Following the Tips will save you 50%'.body(
                    center: true,
                    color: Colors.red,
                    weight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
