part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LogInTapped extends LoginEvent {
  final String email;
  final String password;
  final bool isRemebered;

  const LogInTapped(
      {required this.isRemebered, required this.email, required this.password});
}
