import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_profile/core/constants/ui_constants.dart';
import 'package:my_profile/core/theme/color_palette.dart';

class CustomRoundTextField extends StatelessWidget {
  final String? hintText;
  final String labelText;
  final bool? isRequireField;
  final Function()? onTapSuffixIcon;
  final int? maxLength;
  final double labelFontSize;
  final TextEditingController? textEditingController;
  final bool? isPasswordField;
  final String? errorText;
  final TextInputAction? keyBoardAction;
  final FocusNode? focusScope;
  final TextInputType? textInputType;
  final Function(String?)? onChange;
  final Function(String?)? onFieldSubmitted;
  final Function()? onTap;
  final String? Function(String?)? validator;
  final bool? isReadOnly;
  final bool isAbscureText = false;
  final bool labelVisible;
  final int? maxLines;
  final Color? backgroundColor;
  final List<TextInputFormatter>? inputFormatter;
  final bool isShowEditButton;
  final Function()? onEditButtonTap;

  const CustomRoundTextField(
      {Key? key,
      this.hintText,
      required this.labelText,
      this.labelFontSize = 14,
      this.isRequireField,
      this.onTapSuffixIcon,
      this.textEditingController,
      this.isPasswordField,
      this.errorText,
      this.keyBoardAction,
      this.focusScope,
      this.textInputType,
      this.onTap,
      this.validator,
      this.onChange,
      this.onFieldSubmitted,
      this.maxLength = 1000,
      this.maxLines = 1,
      this.isReadOnly,
      this.labelVisible = true,
      this.inputFormatter,
      this.backgroundColor,
      this.isShowEditButton = false,
      this.onEditButtonTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelVisible
            ? Padding(
                padding: const EdgeInsets.only(
                  bottom: 5,
                ),
                child: Text(
                  labelText,
                  style: const TextStyle(
                      fontSize: 14, color: ColorPalette.colorBlack),
                ),
              )
            : const Offstage(),
        TextFormField(
          validator: validator,
          textCapitalization: TextCapitalization.sentences,
          readOnly: isReadOnly ?? false,
          cursorColor: ColorPalette.primaryColor,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            fillColor: backgroundColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: const BorderSide(
                color: ColorPalette.primaryColor,
                width: 1,
              ),
            ),
            counterText: '',
            hintText: hintText,
            hintStyle:
                const TextStyle(fontSize: 14, color: ColorPalette.colorGrey),
            suffixIcon: isShowEditButton
                ? InkWell(
                    onTap: onTapSuffixIcon,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.edit,
                        size: 18,
                      ),
                    ),
                  )
                : const Offstage(),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: const BorderSide(
                color: ColorPalette.primaryColor,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: const BorderSide(
                color: ColorPalette.primaryColor,
                width: 1,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: const BorderSide(
                color: ColorPalette.primaryColor,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: const BorderSide(
                color: ColorPalette.primaryColor,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: const BorderSide(
                color: ColorPalette.primaryColor,
                width: 1,
              ),
            ),
          ),
          keyboardType: textInputType,
          obscureText: isPasswordField ?? false,
          obscuringCharacter: "*",
          controller: textEditingController,
          textInputAction: keyBoardAction,
          focusNode: focusScope,
          maxLength: maxLength,
          maxLines: maxLines,
          onChanged: onChange,
          onTap: onTap,
          onFieldSubmitted: onFieldSubmitted,
          inputFormatters: inputFormatter,
        ),
      ],
    );
  }
}
