part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class  RegisterSuccessState extends RegisterState {
  final RegisterData registerData;

  RegisterSuccessState(this.registerData);
}

class RegisterErrorState extends RegisterState {}

class ChangeObscureText extends RegisterState {}

