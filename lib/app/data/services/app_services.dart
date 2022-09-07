import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;
import 'package:motion_sensors/motion_sensors.dart';

class AppServices extends GetxService {
  @override
  onInit() {
    super.onInit();
    magneticInit();
    SystemChrome.setPreferredOrientations(const [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }

  /*--------------------------------------------------------------------------*/
  /*------------------------------  Variables  -------------------------------*/
  /*--------------------------------------------------------------------------*/
  RxBool isDark = false.obs;
  RxInt index = 0.obs;
  RxMap<int, List<String>> consumptions = <int, List<String>>{}.obs;

  // currentFuel is from the subtraction of the totalFuel and the consumed after the trip
  RxDouble currentFuel = 10.0.obs;
  RxDouble totalFuel = 0.0.obs;
  List? accelerationX;
  List? accelerationY;
  List? accelerationZ;
  List? gyroscopeX;
  List? gyroscopeY;
  List? gyroscopeZ;

  // List? totalMagnetic;
  // List? orientationAzmuth;
  // List? orientationPitch;
  // List? orientationRoll;
  // List? sv;
  // List? sh;
  // List? means;
  // List iqrs = [];
  // List upper = [];
  // List lower = [];
  // List fullMagneticData = [];
  // String fullMagnetic = '';
  final Vector3 gyroscope = Vector3.zero();
  final Vector3 userAccelerometer = Vector3.zero();
  final Vector3 accelerometer = Vector3.zero();

  // Vector3 magnetometer = Vector3.zero();
  // Vector3 orientation = Vector3.zero();
  // Vector3 absoluteOrientation = Vector3.zero();
  // final Vector3 _absoluteOrientation2 = Vector3.zero();
  // double _screenOrientation = 0;

  void magneticInit() {
    motionSensors.gyroscope.listen((GyroscopeEvent event) {
      gyroscope.setValues(event.x, event.y, event.z);
    });
    motionSensors.accelerometer.listen((AccelerometerEvent event) {
      accelerometer.setValues(event.x, event.y, event.z);
    });
    motionSensors.userAccelerometer.listen((UserAccelerometerEvent event) {
      userAccelerometer.setValues(event.x, event.y, event.z);
    });
    // motionSensors.magnetometer.listen((MagnetometerEvent event) {
    //   magnetometer.setValues(event.x, event.y, event.z);
    //   var matrix =
    //       motionSensors.getRotationMatrix(_accelerometer, magnetometer);
    //   _absoluteOrientation2.setFrom(motionSensors.getOrientation(matrix));
    // });
    // motionSensors.isOrientationAvailable().then((available) {
    //   if (available) {
    //     motionSensors.orientation.listen((OrientationEvent event) {
    //       orientation.setValues(event.yaw, event.pitch, event.roll);
    //     });
    //   }
    // });
    // motionSensors.absoluteOrientation.listen((AbsoluteOrientationEvent event) {
    //   absoluteOrientation.setValues(event.yaw, event.pitch, event.roll);
    // });
  }

  void setUpdateInterval(int interval) {
    motionSensors.accelerometerUpdateInterval = interval;
    motionSensors.userAccelerometerUpdateInterval = interval;
    motionSensors.gyroscopeUpdateInterval = interval;
  }

  void magneticVarsInit() {
    accelerationX = [];
    accelerationY = [];
    accelerationZ = [];
    gyroscopeX = [];
    gyroscopeY = [];
    gyroscopeZ = [];
    // totalMagnetic = [];
    // orientationAzmuth = [];
    // orientationPitch = [];
    // orientationRoll = [];
    // sv = [];
    // sh = [];
  }

  // void meanDataInit() {
  //   magX = CentralTendency(magneticX);
  //   magY = CentralTendency(magneticY);
  //   magZ = CentralTendency(magneticZ);
  //   totalMag = CentralTendency(totalMagnetic);
  //   oriAzmuth = CentralTendency(orientationAzmuth);
  //   oriPitch = CentralTendency(orientationPitch);
  //   oriRoll = CentralTendency(orientationRoll);
  //   svAv = CentralTendency(sv);
  //   shAv = CentralTendency(sh);
  // }

  // void fillMean() {
  //   means = [];
  //   means.add(magX.arithmetic());
  //   means.add(magY.arithmetic());
  //   means.add(magZ.arithmetic());
  //   means.add(totalMag.arithmetic());
  //   means.add(oriAzmuth.arithmetic());
  //   means.add(oriPitch.arithmetic());
  //   means.add(oriRoll.arithmetic());
  //   means.add(svAv.arithmetic());
  //   means.add(shAv.arithmetic());
  // }
  //
  // void fullMagneticDataInit() {
  //   for (int i = 0; i < means.toList().length; i++) {
  //     fullMagneticData.add(means[i]);
  //   }
  //   for (int i = 0; i < iqrs.toList().length; i++) {
  //     fullMagneticData.add(iqrs[i]);
  //   }
  // }

  void getData() async {
    magneticVarsInit();
    // take first 50 readings of gyroscope
    for (int i = 0; i < 50; i++) {
      accelerationX!.add(userAccelerometer.x);
      accelerationY!.add(userAccelerometer.y);
      accelerationZ!.add(userAccelerometer.z);
      gyroscopeX!.add(gyroscope.x);
      gyroscopeY!.add(gyroscope.y);
      gyroscopeZ!.add(gyroscope.z);
      await Future.delayed(const Duration(milliseconds: 50), () {});
    }
  }

// double manualIQR(data, CentralTendency shx) {
//   final list = data.toList()..sort();
//   lower = [];
//   upper = [];
//
//   for (int i = 0; i < list.length; i++) {
//     if (i > 9) {
//       upper.add(list[i]);
//     } else {
//       lower.add(list[i]);
//     }
//   }
//   final centerLeft = lower.length ~/ 2;
//   final centerRight = upper.length ~/ 2;
//
//   double lowerValLeft, higherValLeft, higherValRight, lowerValRight;
//   if (list.length % 2 == 0) {
//     lowerValLeft = lower.elementAt(centerLeft - 1);
//     higherValLeft = lower.elementAt(centerLeft);
//
//     lowerValRight = upper.elementAt(centerRight - 1);
//     higherValRight = upper.elementAt(centerRight);
//   }
//
//   var outputLeft = lowerValLeft + (higherValLeft - lowerValLeft) * 0.75;
//   var outputRight = lowerValRight + (higherValRight - lowerValRight) * 0.25;
//
//   var finalOutput = outputRight - outputLeft;
//
//   return finalOutput;
// }
//
// void fillIQR() {
//   iqrs = [];
//   iqrs.add(manualIQR(magneticX, magX));
//   iqrs.add(manualIQR(magneticY, magY));
//   iqrs.add(manualIQR(magneticZ, magZ));
//   iqrs.add(manualIQR(totalMagnetic, totalMag));
//   iqrs.add(manualIQR(orientationAzmuth, oriAzmuth));
//   iqrs.add(manualIQR(orientationPitch, oriPitch));
//   iqrs.add(manualIQR(orientationRoll, oriRoll));
//   iqrs.add(manualIQR(sv, svAv));
//   iqrs.add(manualIQR(sh, shAv));
// }
}
