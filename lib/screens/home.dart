import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/cubit/shop_cubit/shop_cubit.dart';
import 'package:untitled2/screens/search_screen.dart';
import 'package:untitled2/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
        listener: (context, shopState) {},
        builder: (context, shopState) {
          var cubit = ShopCubit.get(context);
          return Scaffold(
            body: cubit.pages[cubit.currentIndex],
            appBar: AppBar(
              title: const Text(
                'Salla',
                style: const TextStyle(fontSize: 25),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    navigateTo(context, const Search());
                  },
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              items: cubit.items,
              onTap: (i) {
                cubit.bottomnav(i);
              },
            ),
          );
        });
  }
}
