import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:vfca2/app/core/utils/extensions.dart';
import 'package:vfca2/app/modules/home/controller/home_controller.dart';
import 'package:vfca2/app/widgets/custom_wave_clipper.dart';

import '../../../routes/app_pages.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      appBar: AppBar(
        title: Text(controller.titles[controller.cindex.value]),
        actions: [
          IconButton(
            onPressed: () {
              // Get.toNamed(Routes.info);
            },
            icon: ImageIcon(
              const Svg('assets/svg/info.svg'),
              color: Get.theme.colorScheme.secondary,
            ),
          ),
        ],
      ),
      body: controller.pages?[controller.cindex.value],

//AIzaSyA5O4WeWvknLgymMrMSSti7U0u5wYbbcKE
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(3),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: NavigationBar(
            destinations: [
              NavigationDestination(
                icon: ImageIcon(
                  const Svg('assets/svg/home.svg'),
                  color: controller.appServices.isDark.value
                      ? Colors.white
                      : Colors.black,
                ),
                label: 'Home',
              ),
              NavigationDestination(
                icon: ImageIcon(
                  const Svg('assets/svg/fuel.svg'),
                  color: controller.appServices.isDark.value
                      ? Colors.white
                      : Colors.black,
                ),
                label: 'Fuel Consumption',
              ),
              NavigationDestination(
                icon: ImageIcon(
                  const Svg('assets/svg/trip.svg'),
                  color: controller.appServices.isDark.value
                      ? Colors.white
                      : Colors.black,
                ),
                label: 'Trip Consumption',
              ),
            ],
            height: kBottomNavigationBarHeight + 20,
            selectedIndex: controller.cindex.value,
            onDestinationSelected: (val) {
              controller.cindex.value = val;
            },
          ),
        ),
      ),

    ));
  }
}

