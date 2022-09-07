import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:vfca2/app/core/utils/extensions.dart';
import 'package:vfca2/app/modules/quote_view/controller/quote_controller.dart';
import 'package:vfca2/app/widgets/global_bg.dart';
import 'package:vfca2/app/widgets/global_textfield.dart';

import '../../maps/controller/maps_controller.dart';

class QuoteView extends GetView<QuoteController> {
  const QuoteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => GlobalBG(
      body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: Get.width * 0.8,
                  height: Get.height * 0.39,
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
                      Positioned(
                        top: -10,
                        child: Image.asset(
                          'assets/images/car.png',
                          width: Get.width * 0.7,
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
                                  'assets/svg/fuel-consumption.svg',
                                ),
                              ),
                              controller.appServices.totalFuel.value == 0.0
                                  ? '0.0L'.title()
                                  : '${controller.appServices.currentFuel.value}L'
                                      .title(),
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
                              })
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                CircularPercentIndicator(
                  radius: 80,
                  animation: true,
                  progressColor: const Color(0xFFFD5F00),
                  circularStrokeCap: CircularStrokeCap.round,
                  curve: Curves.fastLinearToSlowEaseIn,
                  backgroundColor: Colors.grey,
                  lineWidth: 15,
                  percent: controller.appServices.totalFuel.value == 0.0
                      ? 0.0
                      : (controller.appServices.currentFuel.value) /
                          controller.appServices.totalFuel.value,
                  // center:
                  //     '${(controller.percent!.value * 100).truncate()}%'.title(),
                  center: controller.appServices.totalFuel.value == 0.0
                      ? 'Total Fuel: 0.0L'.title()
                      : 'Total Fuel: ${controller.fuelController.text}L'
                          .subtitle(),
                ),
                const SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {
                    Get.dialog(
                      Dialog(
                        backgroundColor: Colors.white,
                        insetAnimationCurve: Curves.bounceInOut,
                        insetPadding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GlobalTextField(
                                hintText: 'Fuel'.tr,
                                prefixIcon: 'fuel',
                                inputType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                controller: controller.fuelController,
                                validator: (String? val) {
                                  if (val!.isEmpty) {
                                    return 'Please enter your Fuel'.tr;
                                  } else if (!val.isAlphabetOnly) {
                                    return 'Please enter a Number'.tr;
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    controller.appServices.totalFuel.value = double.parse(
                                        controller.fuelController.text);
                                    Get.back();
                                  },
                                  child: const Text('Set Fuel')),
                            ],
                          ),
                        ),
                      ),
                      barrierDismissible: false,
                      transitionCurve: Curves.easeInOutBack,
                    );
                  },
                  child: Container(
                    width: Get.width * 0.33,
                    height: Get.height * 0.08,
                    decoration: BoxDecoration(
                      color: const Color(0xFF005792),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: const Center(
                      child: Text(
                        'Set Fuel',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
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
