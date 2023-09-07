import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:my_profile/core/constants/app_strings.dart';
import 'package:my_profile/core/extensions/context_extension.dart';

import '../../../core/constants/app_images.dart';
import '../../../core/theme/color_palette.dart';

class Utilities {
  static Widget getPlaceHolder({double? height, double? width}) {
    return Container(
      color: Colors.white,
      child: Image.asset(
        AppImages.dummmyPrfileImage,
        width: width,
        height: height,
        fit: BoxFit.cover,
      ),
    );
  }

  static dynamic imagePicker() async {
    try {
      return await ImagePicker().pickImage(source: ImageSource.gallery);
    } catch (e) {
      return e;
    }
  }

  static String yearExperience(DateTime doPurchase, DateTime doRenewel) {
    try {
      Duration parse = doPurchase.difference(doRenewel).abs();
      if (parse.inDays ~/ 360 > 0 && ((parse.inDays % 360) ~/ 30) > 0) {
        return "${parse.inDays ~/ 360} Years ${((parse.inDays % 360) ~/ 30)} Months";
      } else if (parse.inDays ~/ 360 == 0) {
        return "${((parse.inDays % 360) ~/ 30)} Months";
      } else {
        return "${parse.inDays ~/ 360} Years";
      }
    } catch (e) {
      return '';
    }
  }

  static String dateFormate(DateTime pickedDate) {
    return DateFormat('yyyy-MM-dd').format(pickedDate);
  }

  static Future customDialog(
    BuildContext context, {
    required String title,
    required String content,
    required Function()? onTap,
  }) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                onPressed: () {
                  context.pop();
                },
                child: Text(
                  AppStrings.cancel,
                  style: context.textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: ColorPalette.primaryColor,
                  ),
                ),
              ),
              TextButton(
                onPressed: onTap,
                child: Text(
                  AppStrings.yes,
                  style: context.textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: ColorPalette.primaryColor,
                  ),
                ),
              ),
            ],
          );
        });
  }

  static Future<DateTime?> openDatePicker(BuildContext context,
      {DateTime? startDate}) {
    return showDatePicker(
      context: context,
      initialDate: startDate ?? DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme:
                const ColorScheme.light(primary: ColorPalette.primaryColor),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
  }
}
