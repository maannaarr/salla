import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/cache_helper.dart';
import 'package:untitled2/cubit/login_cubit/login_cubit.dart';
import 'package:untitled2/screens/register_screen.dart';
import '../widgets.dart';
import 'home.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  GlobalKey<FormState> _scaffoldKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (BuildContext context, state) {
        if (state is LoginSuccessState) {
          if (state.loginModel.status) {
            print('${state.loginModel.status}');
            CacheHelper.saveData('token', state.loginModel.data.token)
                .then((value) {
              print('saved token = ${state.loginModel.data.token}');
              token = state.loginModel.data.token;
              print(token.toString());
              navigateAndFinish(context, const HomePage());
              myFlutterToast(state.loginModel.message, ToastStates.SUCCESS);
            });
          } else {
            print('${state.loginModel.status}');
            myFlutterToast(state.loginModel.message, ToastStates.ERROR);
          }
        }
      },
      builder: (BuildContext context, Object? state) => Form(
        key: _scaffoldKey,
        child: Scaffold(
          body: Center(
            child: SingleChildScrollView(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'LOGIN',
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: const Color(0XFF67595E),
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text('Login now to browse our hot offers',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.grey)),
                ),
                buildTextFormField(
                  obsecureText: false,
                  controller: emailController,
                  prefixIcon: const Icon(
                    Icons.account_circle_outlined,
                    color: Colors.grey,
                  ),
                  functionValidator: (input) =>
                      input!.isEmpty ? 'Enter Your UserName' : null,
                  keyboardType: TextInputType.text,
                  label: Text(''),
                ),
                //Password Field
                buildTextFormField(
                  suffixIcon: IconButton(
                      onPressed: () {
                        LoginCubit.get(context).changeObscureText();
                      },
                      icon: LoginCubit.get(context).passwordVisible
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off)),
                  obsecureText: LoginCubit.get(context).passwordVisible,
                  controller: passwordController,
                  prefixIcon: const Icon(
                    Icons.lock_outline_sharp,
                    color: Colors.grey,
                  ),
                  functionValidator: (input) =>
                      input!.isEmpty ? 'Enter Your Password' : null,
                  keyboardType: TextInputType.text,
                  label: const Text(''),
                ),
                ConditionalBuilder(
                  condition: state is! LoginLoadingState,
                  fallback: (BuildContext context) =>
                      const CircularProgressIndicator(),
                  builder: (BuildContext context) => TextButton(
                      style: ButtonStyle(
                          fixedSize:
                              MaterialStateProperty.all(const Size(300, 40)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.indigo)),

                      ///!!!onPressed

                      onPressed: () {
                        if (_scaffoldKey.currentState!.validate()) {
                          LoginCubit.get(context).loginUser(
                              emailController.text, passwordController.text);
                          // navigateAndFinish(context, const HomePage());

                        }
                      },
                      child: const Text(
                        'LOGIN',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: Colors.grey),
                    ),
                    TextButton(
                        onPressed: () {
                          navigateTo(context, const RegisterScreen());
                        },
                        child: const Text('Register'))
                  ],
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
