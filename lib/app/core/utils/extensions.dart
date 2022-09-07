import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';

import '../../data/services/app_services.dart';
import 'constants.dart';

extension CustomBoxDecoration on Widget {
  Widget decorate(
      {Color? color,
      double? radius,
      double? width,
      double? height,
      double? padding}) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      padding:
          padding == null ? const EdgeInsets.all(0) : EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: color ?? Get.theme.primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 12)),
        boxShadow: [
          BoxShadow(
            color: Get.theme.colorScheme.shadow,
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: this,
    );
  }
}

extension CustomInputDecoration on InputDecoration {
  static InputDecoration decorate(
      {required String hintText,
        String? prefixIcon,
        String? suffixIcon,
        String? suffixText,
        Color? suffixColor,
        VoidCallback? onSuffixTap,
        bool? filled = true}) {
    AppServices appServices = Get.find<AppServices>();
    return InputDecoration(
      hintText: hintText,
      hintStyle: Get.textTheme.caption!.copyWith(
        color: Get.theme.primaryColor.withOpacity(0.4),
        fontSize: 14,
      ),
      prefixIcon: prefixIcon != null
          ? prefixIcon.icon(color: Get.theme.primaryColor)
          : const SizedBox(),
      prefixIconConstraints: prefixIcon != null
          ? const BoxConstraints.expand(width: 55, height: 55)
          : const BoxConstraints.expand(width: 10, height: 10),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      contentPadding: const EdgeInsets.all(22),
      fillColor: (appServices.isDark.value)
          ? Constants.lightGrey
          : Constants.lightBlue,
      filled: filled,
      suffixIconColor: Get.theme.colorScheme.secondary,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
          BorderSide(color: Get.theme.colorScheme.secondary, width: 1)),
      suffixIconConstraints: (suffixIcon == null)
          ? const BoxConstraints.expand(width: 60, height: 22)
          : null,
      suffixIcon: (suffixIcon == null)
          ? (suffixText == null)
          ? null
          : suffixText.body(color: Constants.accentColor, center: true)
          : IconButton(
        onPressed: onSuffixTap,
        icon: suffixIcon.icon(color: suffixColor),
      ),
    );
  }
}

extension CustomIconProvider on String {
  Widget icon({Color? color, double? size}) => ImageIcon(
        Svg('${Constants.iconsPath}$this.svg'),
        color: color ?? Get.theme.colorScheme.secondary,
        size: size ?? 24,
      );
}

extension CustomTextStyles on String {
  Text get h1 => Text(
        this,
        style: Get.textTheme.headline2!.merge(
          TextStyle(
            color: Get.theme.primaryColor,
          ),
        ),
        softWrap: true,
        textAlign: TextAlign.center,
      );

  Text get h2 => Text(
        this,
        style: Get.textTheme.headline5!.merge(
          TextStyle(
            color: Get.theme.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  Text title({Color? color, bool center = true}) => Text(
        this,
        textAlign: center ? TextAlign.center : TextAlign.left,
        style: Get.textTheme.headline6!.merge(
          TextStyle(
            color: color ?? Get.theme.primaryColor,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppin',
          ),
        ),
      );

  Text subtitle({Color? color, FontWeight? weight}) => Text(
        this,
        style: Get.textTheme.subtitle1!.merge(
          TextStyle(
            color: color ?? Get.theme.primaryColor,
            fontFamily: Get.locale == const Locale('en') ? 'Poppin' : 'Almarai',
            fontWeight: weight ?? FontWeight.normal,
          ),
        ),
      );

  Text body(
          {Color? color,
          bool center = false,
          FontWeight weight = FontWeight.normal}) =>
      Text(
        this,
        style: Get.textTheme.bodyText1!.merge(
          TextStyle(
            color: color ?? Colors.grey,
            fontFamily: Get.locale == const Locale('en') ? 'Poppin' : 'Almarai',
            height: 1.5,
            fontWeight: weight,
          ),
        ),
        textAlign: center ? TextAlign.center : TextAlign.start,
      );

  Text get caption => Text(
        this,
        style: Get.textTheme.caption!.merge(
          TextStyle(
            color: Colors.grey.shade600,
            fontFamily: Get.locale == const Locale('en') ? 'Poppin' : 'Almarai',
          ),
        ),
      );

  Text get overline => Text(
        this,
        style: Get.textTheme.overline!.merge(
          TextStyle(
            color: Get.theme.colorScheme.onPrimary,
            fontFamily: Get.locale == const Locale('en') ? 'Poppin' : 'Almarai',
          ),
        ),
      );

  Text button({Color? color}) => Text(
        this,
        style: Get.textTheme.button!.merge(
          TextStyle(
            color: color ?? Get.theme.primaryColor,
            fontWeight: FontWeight.bold,
            fontFamily: Get.locale == const Locale('en') ? 'Poppin' : 'Almarai',
          ),
        ),
      );
}
