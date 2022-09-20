import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:vfca2/app/core/theme/theme.dart';
import 'package:vfca2/app/core/utils/extensions.dart';
import 'package:vfca2/app/routes/app_pages.dart';
import 'package:vfca2/app/widgets/global_bg.dart';

import '../../maps/controller/maps_controller.dart';
import '../controller/fuel_consumpstion_controller.dart';

class FuelConsumptionView extends GetView<FuelConsumptionController> {
  const FuelConsumptionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => GlobalBG(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: Get.width * 0.8,
                  height: Get.height * 0.36,
                  color: Colors.transparent,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: Get.height * 0.15,
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
                            'assets/svg/fuel_can.svg',
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
                                  'assets/svg/average_fuel.svg',
                                ),
                              ),
                              '${(controller.appServices.fuelConsumption.value).toStringAsFixed(3)}L'
                                  .subtitle(),
                            ],
                          ),
                          const SizedBox(
                            width: 20,
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
                                      .subtitle();
                                }
                                return '0.0KM'.subtitle();
                              })
                            ],
                          ),
                          const SizedBox(
                            width: 20,
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
                                      .subtitle();
                                }
                                return '0.0min'.subtitle();
                              })
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                // CircularPercentIndicator(
                //   radius: 80,
                //   animation: true,
                //   progressColor: Colors.yellow,
                //   circularStrokeCap: CircularStrokeCap.round,
                //   backgroundColor: Colors.grey,
                //   lineWidth: 15,
                //   percent: controller.percent.value,
                //   center:
                //       '${(controller.percent.value * 100).truncate()}%'.title(),
                // ),
                'Open Google maps and choose destination to find the Fuel Consumption'
                    .title(
                  center: true,
                ),
                const SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {
                    if (controller.appServices.totalFuel.value == 0) {
                      UiTheme.errorGetBar('Please set the Fuel First');
                    } else {
                      Get.toNamed(Routes.mapView);
                    }
                  },
                  child: Container(
                    width: Get.width * 0.16,
                    height: Get.height * 0.08,
                    decoration: BoxDecoration(
                      color: const Color(0xFF005792),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: const Center(
                      child: Image(
                        image: Svg('assets/svg/maps.svg'),
                        width: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
