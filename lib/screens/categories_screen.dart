import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/cubit/shop_cubit/shop_cubit.dart';
import 'package:untitled2/models/categories_model.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
            itemBuilder: (context, index) {
              return builtItem(ShopCubit.get(context)
                  .categoriesModel!
                  .data
                  .categoriesData[index]);
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: ShopCubit.get(context)
                .categoriesModel!
                .data
                .categoriesData
                .length);
      },
    );
  }

  Widget builtItem(CategoriesList categoriesList) {
    return Row(
      children: [
        Image(
            width: 120, height: 120, image: NetworkImage(categoriesList.image)),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(categoriesList.name,style: const TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
        ),
        const Spacer(),
          IconButton( icon:const Icon(Icons.arrow_forward_ios),onPressed: (){},),
      ],
    );
  }
}
