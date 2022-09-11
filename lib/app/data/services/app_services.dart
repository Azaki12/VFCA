import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
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
  TextEditingController fuelController = TextEditingController();
  TextEditingController rpmController = TextEditingController();

  // currentFuel is from the subtraction of the totalFuel and the consumed after the trip
  RxDouble currentFuel = 0.0.obs;
  RxDouble totalFuel = 0.0.obs;
  RxDouble rpm = 0.0.obs;
  List? accelerationX;
  List? accelerationY;
  List? accelerationZ;
  List? gyroscopeX;
  List? gyroscopeY;
  List? gyroscopeZ;

  List<String> tips = [
    '-	You are maintaining relatively steady and high demand for power\n-	Your dynamic control of the vehicle is not stable.\n-	Your acceleration rates are high, and your pedal control behaviour is not stable.',
    '-  You have high speed distribution.\n- Your gas and brake pedal operations are not stable.',
    '-	You are maintaining a consistent speed.\n-	Your dynamic control of the vehicle is stable.',
  ];

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

  Future<void> getData() async {
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

  List means = [];
  List medians = [];

  Future<void> getMedian() async {
    medians = [];
    List sortedAccX = accelerationX!..sort();
    List sortedAccY = accelerationY!..sort();
    List sortedAccZ = accelerationZ!..sort();
    List sortedGyroX = gyroscopeX!..sort();
    List sortedGyroY = gyroscopeY!..sort();
    List sortedGyroZ = gyroscopeZ!..sort();
    // 25, 26
    // acceleration
    medians.add((sortedAccX[25] + sortedAccX[26]) / 2);
    medians.add((sortedAccY[25] + sortedAccY[26]) / 2);
    medians.add((sortedAccZ[25] + sortedAccZ[26]) / 2);
    // gryoscopes
    medians.add((sortedGyroX[25] + sortedGyroX[26]) / 2);
    medians.add((sortedGyroY[25] + sortedAccX[26]) / 2);
    medians.add((sortedGyroZ[25] + sortedAccX[26]) / 2);
  }

  List vars = [];

  Future<void> getVariance() async {
    vars = [0, 0, 0, 0, 0, 0];
    await getMean();
    for (int i = 0; i < 50; i++) {
      vars[0] += pow(accelerationX![i] - means[0], 2);
      vars[1] += pow(accelerationY![i] - means[1], 2);
      vars[2] += pow(accelerationZ![i] - means[2], 2);
      vars[3] += pow(gyroscopeX![i] - means[3], 2);
      vars[4] += pow(gyroscopeY![i] - means[4], 2);
      vars[5] += pow(gyroscopeZ![i] - means[5], 2);
    }

    // get the mean
    vars[0] /= 50;
    vars[1] /= 50;
    vars[2] /= 50;
    vars[3] /= 50;
    vars[4] /= 50;
    vars[5] /= 50;
  }

  List stds = [];

  Future<void> getStandardDeviation() async {
    await getVariance();
    stds = [0, 0, 0, 0, 0, 0];
    stds[0] = sqrt(vars[0]);
    stds[1] = sqrt(vars[1]);
    stds[2] = sqrt(vars[2]);
    stds[3] = sqrt(vars[3]);
    stds[4] = sqrt(vars[4]);
    stds[5] = sqrt(vars[5]);
  }

  Future<void> getMean() async {
    means = [0, 0, 0, 0, 0, 0];
    await getData();
    // get the sum
    for (int i = 0; i < 50; i++) {
      means[0] += accelerationX![i];
      means[1] += accelerationY![i];
      means[2] += accelerationZ![i];
      means[3] += gyroscopeX![i];
      means[4] += gyroscopeY![i];
      means[5] += gyroscopeZ![i];
    }
    // get the mean
    means[0] /= 50;
    means[1] /= 50;
    means[2] /= 50;
    means[3] /= 50;
    means[4] /= 50;
    means[5] /= 50;
  }

  List modelInput = [];

  Future<void> loadModelData() async {
    await getStandardDeviation();
    await getMedian();
    modelInput = [];
    modelInput.add(means[0]);
    modelInput.add(means[1]);
    modelInput.add(means[2]);
    modelInput.add(medians[0]);
    modelInput.add(medians[1]);
    modelInput.add(medians[2]);
    modelInput.add(vars[0]);
    modelInput.add(vars[1]);
    modelInput.add(vars[2]);
    modelInput.add(stds[0]);
    modelInput.add(stds[1]);
    modelInput.add(stds[2]);
    modelInput.add(means[3]);
    modelInput.add(means[4]);
    modelInput.add(means[5]);
    modelInput.add(medians[3]);
    modelInput.add(medians[4]);
    modelInput.add(medians[5]);
    modelInput.add(vars[3]);
    modelInput.add(vars[4]);
    modelInput.add(vars[5]);
    modelInput.add(stds[3]);
    modelInput.add(stds[4]);
    modelInput.add(stds[5]);
  }

  Location location = Location();

  Future<LocationData?> getLocationData() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }
    locationData = await location.getLocation();
    return locationData;
  }

  double speed = 0.0;

  Future<double> getSpeed() async {
    return getLocationData().then((value) {
      speed = value!.speed! * 3.6;
      return speed;
    });
  }

  RxInt modelOut = 4.obs;

  Future<void> runModel() async {
    await loadModelData();
    // List modelInput = [];
    // await getSpeed().then((value) {
    //
    // });
    // modelInput.add(speed);
    // modelInput.add(rpm.value);
    List afterEquation = [];
    afterEquation = await decodeTxtMagnetic(
        'assets/pre_process/behaviour/behaviour.txt', modelInput);

    List<String> models = ['models/behaviour/behaviour.tflite'];

    List<Interpreter> interpreters = [
      for (int i = 0; i < models.length; i++)
        await Interpreter.fromAsset(models[i]),
    ];

    var output = List.filled(3, 0).reshape([1, 3]);
    // var output = List.filled(1, 0).reshape([1, 1]);

    interpreters[0].run(afterEquation, output);
    double max = 0;
    for (int i = 0; i < 3; i++) {
      if (output[0][i] > max) {
        modelOut.value = i;
        max = output[0][i];
      }
    }
    print(modelOut.value);
    // the max index is the output
    // 0: normal
    // 1: aggressive
    // 2: risky
    print('model out: $output');
  }

  RxDouble fuelConsumption = 0.0.obs;

  Future<void> runModelFuel(int time) async {
    List input = [];
    // await getSpeed().then((value) {
    //
    // });
    var s = await getSpeed();
    input.add(s);
    input.add(rpm.value);
    List afterEquation = [];
    afterEquation =
        await decodeTxtMagnetic('assets/pre_process/fuel/fuel.txt', input);

    List<String> models = ['models/fuel/fuel.tflite'];

    List<Interpreter> interpreters = [
      for (int i = 0; i < models.length; i++)
        await Interpreter.fromAsset(models[i]),
    ];

    // var output = List.filled(3, 0).reshape([1, 3]);
    var output = List.filled(1, 0).reshape([1, 1]);

    interpreters[0].run(afterEquation, output);

    fuelConsumption.value = output[0][0];
    fuelConsumption.value = (fuelConsumption.value * time) / (60);
    if (currentFuel.value == 0) {
      currentFuel.value = (totalFuel.value - fuelConsumption.value);
    } else {
      currentFuel.value -= fuelConsumption.value;
    }
    print(currentFuel.value);
    print('model out: $output');
  }

  Map model = {};
  List afterEquationMagnetic = [];

  Future<List> decodeTxtMagnetic(String path, List data) async {
    model = {};
    String file = await rootBundle.loadString(path);
    model = jsonDecode(file);
    print(data);
    afterEquationMagnetic = [];
    for (int i = 0; i < data.length; i++) {
      double afterEq =
          (data[i] - model['mean'][i]) / (model['StandardDeviation'][i]);
      afterEquationMagnetic.add(afterEq);
    }
    print(afterEquationMagnetic);
    return afterEquationMagnetic;
  }
}
