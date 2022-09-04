import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:vfca2/app/core/utils/extensions.dart';
import 'package:vfca2/app/modules/quote_view/controller/quote_controller.dart';

import '../../../widgets/custom_wave_clipper.dart';

class QuoteView extends GetView<QuoteController> {
  const QuoteView({Key? key}) : super(key: key);

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
            'Total Fuel'.title(),
            const SizedBox(
              height: 40,
            ),
            CircularPercentIndicator(
              radius: 80,
              animation: true,
              progressColor: Colors.yellow,
              circularStrokeCap: CircularStrokeCap.round,
              curve: Curves.fastLinearToSlowEaseIn,
              backgroundColor: Colors.grey,
              lineWidth: 15,
              percent: controller.percent!.value,
              center: '${(controller.percent!.value * 100).truncate()}%'.title(),
            ),
            ElevatedButton(
                onPressed: () {
                  Random r = Random();
                  controller.percent!.value = r.nextDouble();
                  print(controller.percent!.value);
                },
                child: Text('NExt')),
          ],
        ));
  }
}
