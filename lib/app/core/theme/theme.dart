import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UiTheme {
  static final ThemeData light = ThemeData.light().copyWith(
    appBarTheme: commonTheme.appBarTheme,
    checkboxTheme: commonTheme.checkboxTheme,
    scaffoldBackgroundColor: commonTheme.scaffoldBackgroundColor,
    primaryColor: commonTheme.primaryColor,
    colorScheme: commonTheme.colorScheme,
    textTheme: commonTheme.textTheme,
    navigationBarTheme: commonTheme.navigationBarTheme,
  );

  static final ThemeData dark = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: const Color(0xFF16171F),
    primaryColor: commonTheme.primaryColor,
    colorScheme: commonTheme.colorScheme,
    checkboxTheme: commonTheme.checkboxTheme,
    appBarTheme: commonTheme.appBarTheme.copyWith(
      backgroundColor: const Color(0xFF21212F),
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: commonTheme.appBarTheme.titleTextStyle!.copyWith(
        color: Colors.white,
      ),
    ),
    textTheme: commonTheme.textTheme,
    navigationBarTheme: commonTheme.navigationBarTheme.copyWith(
      backgroundColor: const Color(0xFF21212F),
      labelTextStyle: MaterialStateProperty.all(const TextStyle(
        color: Colors.white,
      )),
    ),
    cardColor: const Color.fromARGB(255, 40, 40, 56),
  );
  static final ThemeData commonTheme = ThemeData(
    fontFamily: 'Poppin',
    primaryColor: const Color.fromARGB(255, 44, 44, 201),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontFamily: 'Poppin',
        color: Color.fromARGB(255, 44, 44, 201),
        fontWeight: FontWeight.bold,
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      backgroundColor: Colors.grey.shade100,
      labelTextStyle: MaterialStateProperty.all(const TextStyle(
        color: Colors.black,
      )),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: const Color.fromARGB(255, 241, 71, 49),
    ),
  );

  static GetSnackBar successSnackBar(
      {String title = 'Success', required String message}) {
    Get.log("[$title] $message");
    return GetSnackBar(
      titleText: Text(
        title.tr,
        style: Get.textTheme.headline6!.merge(
          const TextStyle(color: Colors.white),
        ),
      ),
      messageText: Text(
        message,
        style: Get.textTheme.caption!.merge(
          const TextStyle(color: Colors.white),
        ),
      ),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(20),
      backgroundColor: Get.theme.primaryColor,
      icon: const Icon(
        Icons.check_circle_outline,
        size: 32,
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 15,
      dismissDirection: DismissDirection.horizontal,
      duration: const Duration(seconds: 3),
    );
  }

  static GetSnackBar errorSnackBar(
      {String title = 'Error', required String message}) {
    Get.log("[$title] $message", isError: true);
    return GetSnackBar(
      titleText: Text(
        title.tr,
        style: Get.textTheme.headline6!.merge(
          const TextStyle(color: Colors.white),
        ),
      ),
      messageText: Text(
        message,
        style: Get.textTheme.caption!.merge(
          const TextStyle(color: Colors.white),
        ),
      ),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(20),
      backgroundColor: Get.theme.colorScheme.secondary,
      icon: const Icon(
        Icons.remove_circle_outline,
        size: 32,
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 15,
      duration: const Duration(seconds: 3),
    );
  }

  static void successGetBar(String message) {
    Get.showSnackbar(
      GetSnackBar(
        messageText: Text(
          message,
          style: Get.textTheme.caption!.merge(
            const TextStyle(color: Colors.white),
          ),
        ),
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(20),
        backgroundColor: const Color.fromARGB(255, 75, 204, 120),
        icon: const Icon(
          Icons.check_circle_outline,
          size: 32,
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        borderRadius: 15,
        dismissDirection: DismissDirection.horizontal,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  static void errorGetBar( String message) {
    Get.showSnackbar(
      GetSnackBar(
        messageText: Text(
          message,
          style: Get.textTheme.caption!.merge(
            const TextStyle(color: Colors.white),
          ),
        ),
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(20),
        backgroundColor: Get.theme.colorScheme.secondary,
        icon: const Icon(
          Icons.remove_circle_outline,
          size: 32,
          color: Colors.white,
        ),
        overlayBlur: 2.5,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        borderRadius: 15,
        duration: const Duration(seconds: 3),
      ),
    );
  }

}
