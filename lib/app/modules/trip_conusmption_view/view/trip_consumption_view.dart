import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:vfca2/app/core/utils/extensions.dart';
import 'package:vfca2/app/modules/trip_conusmption_view/controller/trip_consumption_controller.dart';
import 'package:vfca2/app/widgets/global_bg.dart';

import '../../../routes/app_pages.dart';
import '../../maps/controller/maps_controller.dart';

class TripConsumptionView extends GetView<TripConsumptionController> {
  const TripConsumptionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlobalBG(
      body: Obx(() => Column(
            children: [
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
                          'assets/svg/distance_covered.svg',
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Column(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     const ImageIcon(
                        //       Svg(
                        //         'assets/svg/driver.svg',
                        //       ),
                        //     ),
                        //     controller.modelReading.value.isEmpty
                        //         ? 'Unknown'.title()
                        //         : controller.modelReading.value.title(),
                        //   ],
                        // ),
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
                            })
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
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
              CircularPercentIndicator(
                radius: 80,
                animation: true,
                circularStrokeCap: CircularStrokeCap.round,
                curve: Curves.fastLinearToSlowEaseIn,
                progressColor: const Color(0xFFFD5F00),
                backgroundColor: Colors.grey,
                lineWidth: 15,
                percent: controller.percent.value,
                center:
                    '${(controller.percent.value * 100).truncate()}%'.title(),
                // center: controller.appServices.info!.totalDistance.title(),
              ),
              const SizedBox(
                height: 20,
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
                  Column(
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xFF13334C)),
                        ),
                        onPressed: () {
                          Get.toNamed(Routes.quoteManagementScreen);
                        },
                        child: const ImageIcon(
                          Svg(
                            'assets/svg/tachometer.svg',
                            color: Colors.white,
                          ),
                        ),
                      ),
                      'Quote Management'.subtitle(),
                    ],
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xFF13334C)),
                        ),
                        onPressed: () {
                          Get.toNamed(Routes.driverAnalysisScreen);
                        },
                        child: const ImageIcon(
                          Svg(
                            'assets/svg/driver.svg',
                            color: Colors.white,
                          ),
                        ),
                      ),
                      'Behaviour Analysis'.subtitle(),
                    ],
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
