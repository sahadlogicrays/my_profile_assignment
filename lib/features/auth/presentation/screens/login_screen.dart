import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_profile/core/constants/app_strings.dart';
import 'package:my_profile/core/extensions/context_extension.dart';
import 'package:my_profile/core/snackbar_message.dart';
import 'package:my_profile/core/theme/color_palette.dart';
import 'package:my_profile/core/validators/form_field_validators.dart';
import 'package:my_profile/features/auth/presentation/bloc/login_bloc.dart';
import 'package:my_profile/features/profile/presentation/screen/user_profile_screen.dart';
import 'package:my_profile/features/shared/widgets/custom_buttons.dart';
import 'package:my_profile/features/shared/widgets/custom_round_text_field.dart';
import 'package:my_profile/features/shared/widgets/space_vertical.dart';

final userKey = GlobalKey<FormState>();
final passwordKey = GlobalKey<FormState>();

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();

    TextEditingController passwordController = TextEditingController();
    ValueNotifier<bool> isChecked = ValueNotifier(false);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 27),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SpaceVertical(context.height * 0.12),
              Text(
                AppStrings.login,
                style: context.textTheme.displayLarge!.copyWith(
                  color: ColorPalette.colorBlack,
                  fontSize: 42,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SpaceVertical(30),
              Form(
                  key: userKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: CustomRoundTextField(
                      validator: FormFieldValidators.emailValidator,
                      labelText: AppStrings.userName,
                      hintText: AppStrings.hintEmail,
                      textEditingController: emailController)),
              const SpaceVertical(15),
              Form(
                  key: passwordKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: CustomRoundTextField(
                      validator: FormFieldValidators.passwordValidator,
                      hintText: AppStrings.hintPassword,
                      labelText: AppStrings.password,
                      textEditingController: passwordController)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  ValueListenableBuilder(
                      valueListenable: isChecked,
                      builder: (context, value, _) {
                        return Checkbox(
                          value: value,
                          onChanged: (val) {
                            isChecked.value = val ?? false;
                          },
                          checkColor: ColorPalette.colorWhite,
                          activeColor: ColorPalette.primaryColor,
                        );
                      }),
                  const Text(
                    AppStrings.rememberMe,
                    style:
                        TextStyle(fontSize: 14, color: ColorPalette.colorBlack),
                  ),
                ]),
              ),
              BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
                if (state is LoginFail) {
                  ShowMessage.errorMessage(context, AppStrings.errorLogIn);
                } else if (state is LoginSucess) {
                  UserProfileScreen.navigateTo(context);
                }
              }, builder: (context, state) {
                if (state is LoginLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: ColorPalette.primaryColor,
                    ),
                  );
                }
                return CommonButtonView(
                    text: AppStrings.login,
                    textColor: ColorPalette.colorWhite,
                    backgroundColor: ColorPalette.primaryColor,
                    height: 50,
                    borderRadius: 15,
                    onTap: () => userKey.currentState!.validate() &&
                            passwordKey.currentState!.validate()
                        ? context.read<LoginBloc>().add(LogInTapped(
                            isRemebered: isChecked.value,
                            email: emailController.text.trim(),
                            password: passwordController.text.trim()))
                        : null);
              })
            ]),
          ),
        ),
      ),
    );
  }
}
