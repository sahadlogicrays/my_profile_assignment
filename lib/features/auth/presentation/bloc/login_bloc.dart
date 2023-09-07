import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_profile/core/app_preference/app_preferences.dart';
import 'package:my_profile/core/constants/app_strings.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    /// Save all the data to localDatabase.
    on<LogInTapped>((event, emit) {
      emit(LoginLoading());
      try {
        AppPreferences().sharedPrefWrite(AppStrings.labelEmail, event.email);
        AppPreferences().sharedPrefWrite(AppStrings.labelName, event.password);
        AppPreferences()
            .sharedPrefWrite(AppStrings.rememberMe, event.isRemebered);
      } catch (e) {
        emit(const LoginFail(message: AppStrings.errorLogIn));
      }
      emit(LoginSucess());
    });
  }
}
