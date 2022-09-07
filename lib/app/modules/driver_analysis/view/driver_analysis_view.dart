import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:vfca2/app/core/utils/extensions.dart';
import 'package:vfca2/app/modules/driver_analysis/controller/driver_analysis_controller.dart';
import 'package:vfca2/app/widgets/global_bg.dart';
import '../../maps/controller/maps_controller.dart';

class DriverAnalysisView extends GetView<DriverAnalysisController> {
  const DriverAnalysisView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6E9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F6E9),
        title: 'Driver Behavior Analysis'.title(),
      ),
      body: GlobalBG(
        body: Obx(() => Center(
              child: Column(
                children: [
                  // Stack(
                  //   children: [
                  //     Opacity(
                  //       opacity: 0.5,
                  //       child: ClipPath(
                  //         clipper: WaveClipper(),
                  //         child: Container(
                  //           color: Colors.deepOrangeAccent,
                  //           height: 150,
                  //         ),
                  //       ),
                  //     ),
                  //     ClipPath(
                  //       clipper: WaveClipper(),
                  //       child: Container(
                  //         color: Colors.red,
                  //         height: 100,
                  //         alignment: Alignment.center,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Container(
                    width: Get.width * 0.8,
                    height: Get.height * 0.36,
                    color: Colors.transparent,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: Get.height * 0.25,
                          width: Get.width * 0.8,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        const Positioned(
                          top: 0,
                          child: Image(
                            image: Svg(
                              'assets/svg/driver.svg',
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const ImageIcon(
                                  Svg(
                                    'assets/svg/analysis.svg',
                                  ),
                                ),
                                controller.modelReading.value.isEmpty
                                    ? 'Unknown'.title()
                                    : controller.modelReading.value.title(),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const ImageIcon(
                                  Svg(
                                    'assets/svg/distance.svg',
                                  ),
                                ),
                                GetBuilder<MapsController>(
                                    builder: (mapsController) {
                                  if (mapsController.info != null) {
                                    return mapsController.info!.totalDistance
                                        .title();
                                  }
                                  return '0.0KM'.title();
                                })
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const ImageIcon(
                                  Svg(
                                    'assets/svg/time.svg',
                                  ),
                                ),
                                GetBuilder<MapsController>(
                                    builder: (mapsController) {
                                  if (mapsController.info != null) {
                                    return mapsController.info!.totalDuration
                                        .title();
                                  }
                                  return '0.0KM'.title();
                                }),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  // ElevatedButton(
                  //     onPressed: () {
                  //       Random r = Random();
                  //       controller.index.value = r.nextInt(3);
                  //     },
                  //     child: const Text('dsad')),
                  'Tips'.title(),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularPercentIndicator(
                        radius: 80,
                        animation: true,
                        progressColor:
                            controller.categoryColors[controller.index.value],
                        circularStrokeCap: CircularStrokeCap.round,
                        backgroundColor: Colors.grey,
                        lineWidth: 15,
                        percent:
                            controller.categoryPercent[controller.index.value],
                        center:
                            controller.categoryNames[controller.index.value],
                      ),
                      const SizedBox(
                        width: 20,
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
                ],
              ),
            )),
      ),
    );
  }
}
