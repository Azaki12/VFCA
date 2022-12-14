import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:vfca2/app/core/theme/theme.dart';
import 'package:vfca2/app/core/utils/extensions.dart';
import 'package:vfca2/app/modules/quote_view/controller/quote_controller.dart';
import 'package:vfca2/app/routes/app_pages.dart';
import 'package:vfca2/app/widgets/global_bg.dart';
import 'package:vfca2/app/widgets/global_textfield.dart';

import '../../maps/controller/maps_controller.dart';

class QuoteView extends GetView<QuoteController> {
  const QuoteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => GlobalBG(
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: Get.width * 0.8,
                    height: Get.height * 0.25,
                    color: Colors.transparent,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          bottom: 10,
                          child: Container(
                            height: Get.height * 0.15,
                            width: Get.width * 0.8,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        Positioned(
                          top: -10,
                          child: Image.asset(
                            'assets/images/car.png',
                            width: Get.width * 0.7,
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          child: Row(
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
                                      ? '0.0 L'.subtitle()
                                      : '${(controller.appServices.currentFuel.value).toStringAsFixed(3)} L'
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
                                    return '0.0 KM'.subtitle();
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
                                    return '0.0 min'.subtitle();
                                  })
                                ],
                              ),
                            ],
                          ),
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
                    center: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        controller.appServices.totalFuel.value == 0.0
                            ? 'Total Fuel: 0.0L'.title()
                            : 'Total Fuel: ${controller.appServices.fuelController.text}L'
                                .subtitle(),
                        controller.appServices.totalFuel.value == 0.0
                            ? 'Current Fuel: 0.0 L'.subtitle()
                            : 'Current Fuel: ${(controller.appServices.currentFuel.value).toStringAsFixed(2)} L'
                                .subtitle(),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () async => Get.dialog(
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
                                    controller:
                                        controller.appServices.fuelController,
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
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  GlobalTextField(
                                    hintText: 'RPM'.tr,
                                    prefixIcon: 'tachometer',
                                    inputType: TextInputType.number,
                                    textInputAction: TextInputAction.done,
                                    controller:
                                        controller.appServices.rpmController,
                                    validator: (String? val) {
                                      if (val!.isEmpty) {
                                        return 'Please enter your RPM'.tr;
                                      } else if (!val.isAlphabetOnly) {
                                        return 'Please enter a Number'.tr;
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        if (controller
                                                .appServices.totalFuel.value !=
                                            0) {
                                          controller.appServices.init();
                                        }
                                        controller.appServices.totalFuel.value =
                                            double.parse(controller.appServices
                                                .fuelController.text);
                                        controller.appServices.rpm.value =
                                            double.parse(controller.appServices
                                                .rpmController.text);

                                        if (controller
                                                .appServices.totalTime.value ==
                                            0) {
                                          Get.toNamed(Routes.mapView);
                                          UiTheme.successGetBar(
                                              'Please Choose Destination');
                                        }
                                      },
                                      child: const Text('Set Fuel')),
                                ],
                              ),
                            ),
                          ),
                          barrierDismissible: false,
                          transitionCurve: Curves.easeInOutBack,
                        ),
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
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          // run model fuel
                          // controller.appServices.runModelFuel();
                          if (controller.appServices.totalFuel.value == 0 ||
                              controller.appServices.totalTime.value == 0) {
                            UiTheme.errorGetBar('Set the fuel first');
                          } else {
                            controller.appServices.runModelTestFuel();
                          }
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
                              'Predict',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  'Predicted Fuel Consumption: '.title(),
                  '${(controller.appServices.fuelModelConsumption.value).toStringAsFixed(3)} L/H'
                      .title(),
                ],
              ),
            ),
          ),
        ));
  }
}
