import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_profile/core/constants/app_images.dart';
import 'package:my_profile/core/extensions/context_extension.dart';
import 'package:my_profile/core/theme/color_palette.dart';

class CustomProfilePictureWidget extends StatelessWidget {
  final Function()? onProfilePictureTap;
  final String profilePicture;
  const CustomProfilePictureWidget(
      {Key? key, this.onProfilePictureTap, this.profilePicture = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onProfilePictureTap,
      child: Container(
        width: context.width * 0.3,
        height: context.height * 0.15,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ColorPalette.colorLightGrey,
            image: DecorationImage(
                image: profilePicture.isNotEmpty
                    ? FileImage(File(profilePicture))
                    : const AssetImage(AppImages.dummmyPrfileImage)
                        as ImageProvider,
                fit: BoxFit.cover)),
      ),
    );
  }
}
