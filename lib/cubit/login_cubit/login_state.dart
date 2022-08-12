part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final LoginData loginModel;

  LoginSuccessState(this.loginModel);
}

class LoginErrorState extends LoginState {}

class ChangeObscureText extends LoginState {}
class ShopDataLoadingState extends LoginState {}
class ShopDataSuccessState extends LoginState {}
class ShopDataErrorState extends LoginState {}
