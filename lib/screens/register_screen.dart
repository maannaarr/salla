import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/cubit/register_cubit/register_cubit.dart';

import '../widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _scaffoldKey = GlobalKey<FormState>();

    var userNameController = TextEditingController();
    var passwordController = TextEditingController();
    var phoneController = TextEditingController();
    var emailController = TextEditingController();

    return BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            key: _scaffoldKey,
            body: Center(
              child: SingleChildScrollView(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Register',
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: const Color(0XFF67595E),
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text('Register now to browse our hot offers',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.grey)),
                  ),

                  ///username
                  buildTextFormField(
                    obsecureText: false,
                    controller: userNameController,
                    prefixIcon: const Icon(
                      Icons.account_circle_outlined,
                      color: Colors.grey,
                    ),
                    functionValidator: (input) =>
                        input!.isEmpty ? 'Enter Your UserName' : null,
                    keyboardType: TextInputType.text,
                    label: Text('Username'),
                  ),

                  ///email
                  buildTextFormField(
                    obsecureText: false,
                    controller: emailController,
                    prefixIcon: const Icon(
                      CupertinoIcons.envelope,
                      color: Colors.grey,
                    ),
                    functionValidator: (input) =>
                        input!.isEmpty ? 'Enter Your Email' : null,
                    keyboardType: TextInputType.text,
                    label: const Text('Email'),
                  ),

                  ///Password Field
                  buildTextFormField(
                    suffixIcon: IconButton(
                        onPressed: () {
                          RegisterCubit.get(context).changeObscureText();
                        },
                        icon: RegisterCubit.get(context).passwordVisible
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off)),
                    obsecureText: RegisterCubit.get(context).passwordVisible,
                    controller: passwordController,
                    prefixIcon: const Icon(
                      Icons.lock_outline_sharp,
                      color: Colors.grey,
                    ),
                    functionValidator: (input) =>
                        input!.isEmpty ? 'Enter Your Password' : null,
                    keyboardType: TextInputType.text,
                    label: const Text('Password'),
                  ),

                  ///phone
                  buildTextFormField(
                    obsecureText: false,
                    controller: phoneController,
                    prefixIcon: const Icon(
                      CupertinoIcons.phone,
                      color: Colors.grey,
                    ),
                    functionValidator: (input) =>
                        input!.isEmpty ? 'Enter Your Phone' : null,
                    keyboardType: TextInputType.text,
                    label: const Text('Phone'),
                  ),

                  ConditionalBuilder(
                    condition: true,
                    fallback: (BuildContext context) =>
                        const CircularProgressIndicator(),
                    builder: (BuildContext context) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                          style: ButtonStyle(
                              fixedSize:
                                  MaterialStateProperty.all(const Size(300, 40)),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.indigo)),

                          ///onPressed

                          onPressed: () {
                            if (_scaffoldKey.currentState!.validate()) {
                              // RegisterCubit.get(context).loginUser(
                              //     emailController.text,
                              //     passwordController.text);
                              // // navigateAndFinish(context, const HomePage());

                            }
                          },
                          child: const Text(
                            'Register',
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ),
                 ],
              )),
            ),
          );
        });
  }
}
