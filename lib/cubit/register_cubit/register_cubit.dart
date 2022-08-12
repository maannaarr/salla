import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:untitled2/dio_helper/login_dio_helper.dart';
import 'package:untitled2/models/register_model.dart';
part 'register_state.dart';



class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  static RegisterCubit get(context) => BlocProvider.of(context);
  RegisterData?  registerData;

  void loginUser(String email, String password) {
    emit(RegisterLoadingState());
    DioHelper.postData(query: {'email': email, 'password': password}, url: 'login')
        .then((value) {
      print(value.data);
      registerData = RegisterData.fromJson(value.data);
      print(registerData!.status.toString());
      print(registerData!.data.name);

      emit(RegisterSuccessState(registerData!));
    }).catchError((e) {
      print(e.toString());
      emit(RegisterErrorState());
    });
  }

  bool passwordVisible = true;

  changeObscureText() {
    passwordVisible = !passwordVisible;
    emit(ChangeObscureText());
  }
}
