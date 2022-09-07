import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/utils/constants.dart';
import '../data/services/app_services.dart';

class DecorationCircles extends StatelessWidget {
  final double? width, height;

  const DecorationCircles({Key? key, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFF1DA5FF),
      ),
      child: Container(
        margin: const EdgeInsets.all(35),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color:  Color(0xFFF6F6E9),
        ),
      ),
    );
  }
}
