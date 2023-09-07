import 'package:flutter/material.dart';
import 'package:my_profile/core/theme/color_palette.dart';

class CommonButtonView extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final double height;
  final double? width;
  final VoidCallback onTap;
  final bool isShowBorder;
  final bool isShowReportIcon;
  final double borderRadius;

  const CommonButtonView(
      {Key? key,
      required this.text,
      required this.textColor,
      required this.backgroundColor,
      required this.height,
      this.width,
      required this.onTap,
      this.isShowReportIcon = false,
      this.isShowBorder = false,
      this.borderRadius = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Material(
          color: backgroundColor,
          child: SizedBox(
            width: isShowReportIcon ? double.infinity : width,
            child: InkWell(
                onTap: onTap,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  isShowReportIcon
                      ? const Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Icon(
                            Icons.report_problem_rounded,
                            color: ColorPalette.colorBlack,
                          ))
                      : const Offstage(),
                  Container(
                    width: width,
                    height: height,
                    decoration: BoxDecoration(
                      border: isShowBorder
                          ? Border.all(color: ColorPalette.colorGrey, width: 2)
                          : null,
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                    child: Center(
                      child: Text(
                        text,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: textColor, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ])),
          ),
        ));
  }
}
