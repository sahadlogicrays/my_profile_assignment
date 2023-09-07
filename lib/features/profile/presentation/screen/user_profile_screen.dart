import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_profile/core/constants/ui_constants.dart';
import 'package:my_profile/core/extensions/context_extension.dart';
import 'package:my_profile/core/routes/route_path.dart';
import 'package:my_profile/core/theme/color_palette.dart';
import 'package:my_profile/features/profile/presentation/bloc/user_profile_bloc.dart';
import 'package:my_profile/features/profile/presentation/screen/edit_profile_screen.dart';
import 'package:my_profile/features/profile/presentation/widget/chip_widget.dart';
import 'package:my_profile/features/profile/presentation/widget/profile_image_widget.dart';
import 'package:my_profile/features/shared/widgets/utilities.dart';
import 'package:my_profile/features/shared/widgets/custom_round_text_field.dart';
import 'package:my_profile/features/shared/widgets/space_vertical.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../shared/widgets/space_horizontal.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);
  static Widget routeBuilder(
    BuildContext context,
    GoRouterState state,
  ) {
    return BlocProvider(
        create: (context) => UserProfileBloc()..add(GetAllUsersProfile()),
        child: const UserProfileScreen());
  }

  static navigateTo(BuildContext context) {
    context.push(
      RoutePath.profile,
    );
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController startDateController = TextEditingController();
    TextEditingController endDateController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    List<String> skills = [];
    String experience = '';
    String profileImage = '';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.colorWhite,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: () => Utilities.customDialog(context,
                  title: AppStrings.logOut,
                  content: AppStrings.labellogOut,
                  onTap: () => context.read<UserProfileBloc>()
                    ..add(DeleteUsersProfile())),
              child: const Icon(
                Icons.exit_to_app_sharp,
                color: ColorPalette.primaryColor,
                size: 24,
              ),
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: BlocConsumer<UserProfileBloc, UserProfileState>(
              listener: (context, state) {
            if (state is GetAllUsersProfileSucess) {
              skills.clear();
              experience = '';
              nameController.text = state.userName ?? '';
              emailController.text = state.userEmail ?? '';

              if (state.userSkills != null) {
                state.userSkills
                    // ignore: avoid_function_literals_in_foreach_calls
                    .forEach((element) => skills.add(element));
              }

              startDateController.text = state.startDate ?? '';
              endDateController.text = state.endDate ?? '';
              experience = state.totalExperience ?? '';
              profileImage = state.profileImage ?? '';
              startDateController.text.isNotEmpty &&
                      endDateController.text.isNotEmpty
                  ? experience = Utilities.yearExperience(
                      DateTime.parse(startDateController.text),
                      DateTime.parse(endDateController.text))
                  : null;
            }
            if (state is DeleteUserProfileSucess) {
              context.push(RoutePath.intialRoute);
            }
          }, builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BlocListener<UserProfileBloc, UserProfileState>(
                  listener: (context, state) {
                    if (state is EditProfilePictureSucess) {}
                  },
                  child: Stack(
                    children: [
                      CustomProfilePictureWidget(
                        profilePicture: profileImage,
                      ),
                      Positioned(
                        right: 0,
                        child: GestureDetector(
                          onTap: () => EditProfileScreen.navigateTo(context, {
                            AppStrings.label: AppStrings.labelProfile,
                          }),
                          child: Container(
                            padding: allPadding4,
                            decoration: BoxDecoration(
                              color: ColorPalette.primaryColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: ColorPalette.colorWhite,
                              size: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SpaceVertical(15),
                CustomRoundTextField(
                  onTapSuffixIcon: () => EditProfileScreen.navigateTo(context, {
                    AppStrings.label: AppStrings.labelName,
                    AppStrings.hint: AppStrings.hintEnterYourName
                  }),
                  isShowEditButton: true,
                  isReadOnly: true,
                  hintText: AppStrings.hintEnterYourName,
                  labelText: AppStrings.labelName,
                  textEditingController: nameController,
                ),
                const SpaceVertical(15),
                CustomRoundTextField(
                  onTapSuffixIcon: () => EditProfileScreen.navigateTo(context, {
                    AppStrings.label: AppStrings.labelEmail,
                    AppStrings.hint: AppStrings.hintEnterYourEmail
                  }),
                  isShowEditButton: true,
                  isReadOnly: true,
                  hintText: AppStrings.hintEnterYourEmail,
                  labelText: AppStrings.labelEmail,
                  textEditingController: emailController,
                ),
                const SpaceVertical(15),
                CustomRoundTextField(
                  onTapSuffixIcon: () => EditProfileScreen.navigateTo(context, {
                    AppStrings.label: AppStrings.labelSkills,
                    AppStrings.hint: AppStrings.hintEnterYourSkills
                  }),
                  isShowEditButton: true,
                  isReadOnly: true,
                  hintText: AppStrings.hintEnterYourSkills,
                  labelText: AppStrings.labelSkills,
                ),
                const SpaceVertical(10),
                skills.isNotEmpty
                    ? Align(
                        alignment: Alignment.centerLeft,
                        child: Wrap(
                          children: List.generate(
                            skills.length,
                            (index) => CustomChipWidget(name: skills[index]),
                          ),
                        ),
                      )
                    : const Offstage(),
                const SpaceVertical(10),
                Row(
                  children: [
                    Expanded(
                      child: CustomRoundTextField(
                        onTapSuffixIcon: () => EditProfileScreen.navigateTo(
                          context,
                          {
                            AppStrings.label: AppStrings.labelStartDate,
                            AppStrings.hint: AppStrings.hintdate
                          },
                        ),
                        isReadOnly: true,
                        isShowEditButton: true,
                        hintText: AppStrings.hintdate,
                        labelText: AppStrings.labelStartDate,
                        textEditingController: startDateController,
                      ),
                    ),
                    const SpaceHorizontal(10),
                    Expanded(
                      child: CustomRoundTextField(
                        onTapSuffixIcon: () => EditProfileScreen.navigateTo(
                            context, {
                          AppStrings.label: AppStrings.labelEndDate,
                          AppStrings.hint: AppStrings.hintdate
                        }),
                        isReadOnly: true,
                        isShowEditButton: true,
                        hintText: AppStrings.hintdate,
                        labelText: AppStrings.labelEndDate,
                        textEditingController: endDateController,
                      ),
                    ),
                  ],
                ),
                const SpaceVertical(10),
                experience.isNotEmpty
                    ? Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${AppStrings.hintExperience} $experience',
                          style: context.textTheme.bodySmall!.copyWith(
                            color: ColorPalette.colorBlack,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    : const Offstage(),
              ],
            );
          }),
        ),
      ),
    );
  }
}
