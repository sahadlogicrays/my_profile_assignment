import 'package:flutter/material.dart';
import 'package:my_profile/core/constants/ui_constants.dart';
import 'package:my_profile/core/extensions/context_extension.dart';
import 'package:my_profile/core/theme/color_palette.dart';

class CustomChipWidget extends StatelessWidget {
  final String? name;
  const CustomChipWidget({
    Key? key,
    this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: horizontalPadding4,
      padding: horizontalPadding12 + verticalPadding8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: ColorPalette.colorLightBlue,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            name ?? '',
            style: context.textTheme.bodyLarge!.copyWith(
              color: ColorPalette.colorBlack,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
