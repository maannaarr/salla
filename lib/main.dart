import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/cache_helper.dart';
import 'package:untitled2/cubit/login_cubit/login_cubit.dart';
import 'package:untitled2/cubit/register_cubit/register_cubit.dart';
import 'package:untitled2/cubit/shop_cubit/shop_cubit.dart';
import 'package:untitled2/screens/home.dart';
import 'package:untitled2/screens/login.dart';
import 'package:untitled2/themes.dart';
import 'package:untitled2/widgets.dart';
import 'cache_helper.dart';
import 'dio_helper/login_dio_helper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // late Widget widget;
  // bool onBoarding = CacheHelper.getBoolData('onBoarding');
  // if (onBoarding != null) {
  //   if (token != null) {
  //     widget = HomePage();
  //   } else {
  //     widget = LoginScreen();
  //   }
  // } else {
  //   widget = ONBoardingScreen();
  // }
  // runApp(MyApp(
  //   widget: widget,
  // ));
  runApp(MyApp());
  CacheHelper.init();
  DioHelper.init();
  token = CacheHelper.getStringData('token');
}

class MyApp extends StatelessWidget {
  // final Widget widget;

  MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(
          create: (BuildContext context) => LoginCubit(),
        ),
        BlocProvider<ShopCubit>(
          create: (BuildContext context) => ShopCubit()
            ..getHomeData()
            ..getCategories()
            ..getFavoriteList()
            ..getProfileData(),
        ),
        BlocProvider<RegisterCubit>(
          create: (BuildContext context) => RegisterCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        // home: onBoarding? LoginScreen() : const ONBoardingScreen(),
        home: HomePage(),
      ),
    );
  }
}
