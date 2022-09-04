import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:vfca2/app/core/utils/extensions.dart';
import 'package:vfca2/app/modules/quote_managment/controller/quote_management_controller.dart';

import '../../../widgets/custom_wave_clipper.dart';
import '../../maps/controller/maps_controller.dart';

class QuoteManagementView extends GetView<QuoteManagementController> {
  const QuoteManagementView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Fuel Quote Management'.title(),
      ),
      body: Column(
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
            height: 20,
          ),
          'Consumption after current Trip'.title(),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularPercentIndicator(
                radius: 80,
                animation: true,
                circularStrokeCap: CircularStrokeCap.round,
                curve: Curves.fastLinearToSlowEaseIn,
                progressColor: Colors.red,
                backgroundColor: Colors.grey,
                lineWidth: 15,
                reverse: true,
                percent: 1.0 - controller.percent!.value,
                // center: '${((1 - controller.percent!.value) * 100).truncate()}%'.title(),
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    'Wasted'.title(),
                    '${((1 - controller.percent!.value) * 100).truncate()}%'
                        .title()
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              CircularPercentIndicator(
                radius: 80,
                animation: true,
                circularStrokeCap: CircularStrokeCap.round,
                curve: Curves.fastLinearToSlowEaseIn,
                progressColor: Colors.green,
                backgroundColor: Colors.grey,
                lineWidth: 15,
                percent: controller.percent!.value,
                // center: '${(controller.percent!.value * 100).truncate()}%'.title(),
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    'Remaining'.title(),
                    '${(controller.percent!.value * 100).truncate()}%'.title()
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: Get.width * 0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                'History'.title(),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.white,
                  child: MaterialButton(
                    child: Row(
                      children: [
                        Icon(
                          Icons.remove_red_eye,
                          color: Get.theme.colorScheme.secondary,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        'View all'.subtitle(
                            color: Colors.grey, weight: FontWeight.bold)
                      ],
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: Get.width * 0.95,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
              child: GetBuilder<MapsController>(
                // todo change to the number from the phase 2 model indicating each trip consumption
                builder: (mapsController) =>
                    ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        if (controller.mapsController.info != null) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      'Trip ${index + 1}'.title(),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      mapsController.appServices
                                          .consumptions[index]![0].title(),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      mapsController.appServices
                                          .consumptions[index]![1].title(),
                                    ]
                                ),
                              ),
                            ),
                          );
                        }

                        return 'null'.title();
                      },
                      itemCount: mapsController.appServices.consumptions.length,
                    ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
