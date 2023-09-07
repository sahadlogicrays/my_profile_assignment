import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_profile/core/constants/app_strings.dart';
import 'package:my_profile/core/extensions/context_extension.dart';
import 'package:my_profile/core/routes/route_path.dart';
import 'package:my_profile/core/snackbar_message.dart';
import 'package:my_profile/core/theme/color_palette.dart';
import 'package:my_profile/features/profile/presentation/widget/chip_widget.dart';
import 'package:my_profile/features/profile/presentation/widget/profile_image_widget.dart';
import 'package:my_profile/features/shared/widgets/utilities.dart';
import 'package:my_profile/features/shared/widgets/custom_buttons.dart';
import 'package:my_profile/features/shared/widgets/custom_round_text_field.dart';
import 'package:my_profile/features/shared/widgets/space_vertical.dart';

import '../bloc/user_profile_bloc.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key, required this.userData}) : super(key: key);
  static Widget routeBuilder(
    BuildContext context,
    GoRouterState state,
  ) {
    var userData = state.extra as Map<String, dynamic>;
    return BlocProvider(
        create: (context) => UserProfileBloc()
          ..add(GetUserProfile(key: userData[AppStrings.label])),
        child: EditProfileScreen(userData: userData));
  }

  static navigateTo(BuildContext context, Map<String, dynamic> userData) async {
    await context.push(RoutePath.editProfile, extra: userData);
    // ignore: use_build_context_synchronously
    context.read<UserProfileBloc>().add(GetAllUsersProfile());
  }

  final Map<String, dynamic> userData;

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    String initTextValue = '';
    List<String> skills = [];
    return BlocConsumer<UserProfileBloc, UserProfileState>(
      listener: (context, state) {
        if (state is GetUserProfileSucess) {
          if (state.result is String) {
            textEditingController.text = state.result ?? '';
            initTextValue = state.result;
          } else if (state.result is List<dynamic>) {
            state.result.isNotEmpty
                ? state.result.forEach((element) => skills.add(element))
                : null;
            initTextValue = skills.length.toString();
          } else if (userData[AppStrings.label] == AppStrings.labelSkills) {
            initTextValue = skills.length.toString();
          }
        } else if (state is OnValueChangeTextField) {
          textEditingController.text = state.changedValue;
          if (userData[AppStrings.label] == AppStrings.labelSkills) {
            skills.add(textEditingController.text);
            textEditingController.clear();
          }
        } else if (state is UpdateUserProfileSucess) {
          ShowMessage.errorMessage(context, state.message);

          context.pop();
        }
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () {
            if ((initTextValue != textEditingController.text.trim() &&
                    userData[AppStrings.label] != AppStrings.labelSkills) ||
                (userData[AppStrings.label] == AppStrings.labelSkills &&
                    skills.length.toString() != initTextValue &&
                    skills.isNotEmpty)) {
              Utilities.customDialog(
                context,
                title: AppStrings.alert,
                content: AppStrings.labelPendingChanges,
                onTap: () {
                  context.pop();
                  context.pop();
                },
              );
            } else {
              context.pop();
            }
            return Future.value(false);
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text('${AppStrings.edit} ${userData[AppStrings.label]}'),
            ),
            body: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 20),
                    child: userData[AppStrings.label] == AppStrings.labelProfile
                        ? BlocListener<UserProfileBloc, UserProfileState>(
                            listener: (context, state) {
                              if (state is EditProfilePictureFail) {
                                ShowMessage.errorMessage(
                                    context, state.message);
                              } else if (state is EditProfilePictureSucess) {
                                textEditingController.text = state.image;
                              }
                            },
                            child: Center(
                              child: CustomProfilePictureWidget(
                                profilePicture: textEditingController.text,
                                onProfilePictureTap: () {
                                  context
                                      .read<UserProfileBloc>()
                                      .add(OnEditProfilePicture());
                                },
                              ),
                            ))
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                CustomRoundTextField(
                                  hintText: userData[AppStrings.hint],
                                  labelText: userData[AppStrings.label],
                                  isRequireField: true,
                                  keyBoardAction: TextInputAction.done,
                                  onFieldSubmitted: (value) {
                                    context
                                        .read<UserProfileBloc>()
                                        .add(OnValueChanged(value ?? ''));
                                  },
                                  onChange: (val) {
                                    if (userData[AppStrings.label] ==
                                        AppStrings.labelSkills) {
                                    } else {
                                      context
                                          .read<UserProfileBloc>()
                                          .add(OnValueChanged(val ?? ''));
                                    }
                                  },
                                  onTap: AppStrings.hintdate ==
                                          userData[AppStrings.hint]
                                      ? () {
                                          Utilities.openDatePicker(context,
                                                  startDate: initTextValue != ''
                                                      ? DateTime.parse(
                                                          initTextValue)
                                                      : null)
                                              .then((value) {
                                            if (value != null) {
                                              context
                                                  .read<UserProfileBloc>()
                                                  .add(OnValueChanged(
                                                      Utilities.dateFormate(
                                                          value)));
                                            }
                                          });
                                        }
                                      : null,
                                  isReadOnly: AppStrings.hintdate ==
                                          userData[AppStrings.hint]
                                      ? true
                                      : false,
                                  textEditingController: textEditingController,
                                ),
                                const SpaceVertical(5),
                                userData[AppStrings.label] ==
                                        AppStrings.labelSkills
                                    ? Text(
                                        AppStrings.hintSkills,
                                        textAlign: TextAlign.start,
                                        style: context.textTheme.labelMedium!
                                            .copyWith(
                                          color: ColorPalette.colorRed,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )
                                    : const Offstage(),
                                const SpaceVertical(10),
                                skills.isNotEmpty
                                    ? Align(
                                        alignment: Alignment.centerLeft,
                                        child: Wrap(
                                          children: List.generate(
                                            skills.length,
                                            (index) => CustomChipWidget(
                                              name: skills[index],
                                            ),
                                          ),
                                        ),
                                      )
                                    : const Offstage(),
                              ]))),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: CommonButtonView(
                  text: AppStrings.save,
                  textColor: ColorPalette.colorWhite,
                  backgroundColor: initTextValue ==
                              textEditingController.text.trim() &&
                          userData[AppStrings.label] != AppStrings.labelSkills
                      ? ColorPalette.colorGrey
                      : skills.length.toString() == initTextValue &&
                              userData[AppStrings.label] ==
                                  AppStrings.labelSkills
                          ? ColorPalette.colorGrey
                          : ColorPalette.primaryColor,
                  height: 50,
                  borderRadius: 15,
                  onTap: initTextValue != textEditingController.text.trim() &&
                          userData[AppStrings.label] != AppStrings.labelSkills
                      ? () {
                          context.read<UserProfileBloc>().add(
                              UpdateUsersProfile(
                                  textFieldKey: userData[AppStrings.label],
                                  updatedValue:
                                      textEditingController.text.trim()));
                        }
                      : skills.length.toString() != initTextValue &&
                              userData[AppStrings.label] ==
                                  AppStrings.labelSkills
                          ? () {
                              context.read<UserProfileBloc>().add(
                                  UpdateUsersProfile(
                                      textFieldKey: userData[AppStrings.label],
                                      updatedValue: skills));
                            }
                          : () {}),
            ),
          ),
        );
      },
    );
  }
}
