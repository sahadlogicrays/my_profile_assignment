import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_profile/core/app_preference/app_preferences.dart';
import 'package:my_profile/core/constants/app_strings.dart';
import 'package:my_profile/features/shared/widgets/utilities.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  UserProfileBloc() : super(GetUserProfileInitial()) {
    /// Get all User's data on profile Load
    on<GetAllUsersProfile>((event, emit) async {
      emit(GetAllUserProfileLoading());
      String? userName = await AppPreferences().sharedPrefRead(
        AppStrings.labelName,
      );
      String? userEmail = await AppPreferences().sharedPrefRead(
        AppStrings.labelEmail,
      );
      dynamic userSkills = await AppPreferences().sharedPrefRead(
        AppStrings.labelSkills,
      );
      String? startDate = await AppPreferences().sharedPrefRead(
        AppStrings.labelStartDate,
      );
      String? endDate = await AppPreferences().sharedPrefRead(
        AppStrings.labelEndDate,
      );
      String? totalExperience = await AppPreferences().sharedPrefRead(
        AppStrings.labelTotalExperience,
      );
      String? profileImage = await AppPreferences().sharedPrefRead(
        AppStrings.labelProfile,
      );
      emit(GetAllUsersProfileSucess(
          profileImage: profileImage,
          userName: userName,
          userEmail: userEmail,
          userSkills: userSkills,
          startDate: startDate,
          endDate: endDate,
          totalExperience: totalExperience));
    });

    /// Get Perticular user detilas for edit page
    on<GetUserProfile>((event, emit) {
      emit(GetUserProfileLoading());
      Object? value = AppPreferences().sharedPrefRead(
        event.key,
      );
      emit(GetUserProfileSucess(result: value));
    });

    /// On update Textfield
    on<OnValueChanged>((event, emit) {
      emit(OnValueChangeTextField(changedValue: event.input));
      emit(GetUserProfileInitial());
    });

    /// Update user's profile picture get from gallery and show image
    on<OnEditProfilePicture>((event, emit) async {
      String? imagePath;
      emit(EditProfilePictureLoading());
      try {
        await Utilities.imagePicker().then((value) {
          if (value is String) {
            emit(EditProfilePictureFail(message: value));
          } else {
            imagePath = value?.path;
          }
        });
      } catch (e) {
        emit(const EditProfilePictureFail(message: AppStrings.errorImage));
      }
      emit(EditProfilePictureSucess(image: imagePath ?? ''));
    });

    /// Update user's details on save
    on<UpdateUsersProfile>((event, emit) {
      emit(UpdateUserProfileLoading());
      AppPreferences().sharedPrefWrite(event.textFieldKey, event.updatedValue);
      emit(const UpdateUserProfileSucess(
          message: AppStrings.profileUpdatedSucess));
    });

    /// On logout Delete all User's data
    on<DeleteUsersProfile>((event, emit) {
      emit(DeleteUserProfileLoading());
      try {
        AppPreferences().sharedPrefEraseAllData();
      } catch (e) {
        emit(const DeleteUserProfileFail(message: AppStrings.errorLogout));
      }

      emit(DeleteUserProfileSucess());
    });
  }
}
