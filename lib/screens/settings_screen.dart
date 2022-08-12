import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/cubit/login_cubit/login_cubit.dart';
import 'package:untitled2/widgets.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = LoginCubit.get(context).loginData;

    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, shopState) {},
      builder: (context, shopState) {
        nameController.text = model!.data.name;
        emailController.text = model.data.email;
        phoneController.text = model.data.phone;
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: ConditionalBuilder(
            condition: nameController.text != null,
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
            builder: (context) => Column(
              children: [
                buildTextFormField(
                    obsecureText: false,
                    controller: nameController,
                    label: const Text('Name'),
                    prefixIcon: const Icon(CupertinoIcons.person_alt),
                    functionValidator: (s) {},
                    keyboardType: TextInputType.text),
                buildTextFormField(
                    obsecureText: false,
                    controller: emailController,
                    label: const Text('Email'),
                    prefixIcon: const Icon(CupertinoIcons.envelope),
                    functionValidator: (s) {},
                    keyboardType: TextInputType.emailAddress),
                buildTextFormField(
                    obsecureText: false,
                    controller: phoneController,
                    label: const Text('Phone Number'),
                    prefixIcon: const Icon(CupertinoIcons.phone),
                    functionValidator: (s) {},
                    keyboardType: TextInputType.text),
              ],
            ),
          ),
        );
      },
    );
  }
}
