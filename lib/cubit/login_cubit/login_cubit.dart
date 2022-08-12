import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
        import 'package:untitled2/dio_helper/login_dio_helper.dart';
import 'package:untitled2/models/login_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);
    LoginData? loginData;

  void loginUser(String email, String password) {
    emit(LoginLoadingState());
    DioHelper.postData(query: {'email': email, 'password': password}, url: 'login')
        .then((value) {
      print(value.data);
      loginData = LoginData.fromJson(value.data);
      // loginData = value.data.map((e){});
      print(loginData!.status.toString());
      print(loginData!.data.name);

      emit(LoginSuccessState(loginData!));
    }).catchError((e) {
      print(e.toString());
      emit(LoginErrorState());
    });
  }

  bool passwordVisible = true;

  changeObscureText() {
    passwordVisible = !passwordVisible;
    emit(ChangeObscureText());
  }
}
