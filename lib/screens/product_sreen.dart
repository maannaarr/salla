import 'dart:ui';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/cubit/shop_cubit/shop_cubit.dart';
import 'package:untitled2/models/categories_model.dart';
import 'package:untitled2/models/home_model.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../themes.dart';

class Products extends StatelessWidget {
  const Products({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ShopCubit, ShopState>(
        listener: (BuildContext context, Object? state) {},
        builder: (BuildContext context, Object? state) =>
            builtConditionalBuilder(
          ShopCubit.get(context).homeModel,
          context,
          ShopCubit.get(context).categoriesModel,
        ),
      ),
    );
  }

  ConditionalBuilder builtConditionalBuilder(
      HomeModel? model, BuildContext context,
      [CategoriesModel? categoriesModel]) {
    return ConditionalBuilder(
      condition: model != null && categoriesModel != null,
      fallback: (context) => const Center(child: CircularProgressIndicator()),
      builder: (context) => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            CarouselSlider(
                items: model?.data.banners.map((e) {
                  return Image(image: NetworkImage('${e.image}'));
                }).toList(),
                options: CarouselOptions(
                    height: 250,
                    viewportFraction: 1,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(seconds: 1),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal)),
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Categories',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
                builtCategoriesItems(ShopCubit.get(context).categoriesModel),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'New Products',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
                GridView.count(
                  childAspectRatio: 1 / 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: List.generate(model!.data.products.length, (index) {
                    return Column(
                      children: [
                        Stack(
                          children: [
                            Image(
                              image: NetworkImage(
                                model.data.products[index].image,
                              ),
                              height: 250,
                              fit: BoxFit.cover,
                            ),
                            if (model.data.products[index].discount != 0)
                              Container(
                                child: const Text(
                                  'DISCOUNT',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                color: Colors.red,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                              ),
                          ],
                          alignment: Alignment.bottomLeft,
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.all(5),
                          child: Text(
                            model.data.products[index].name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                height: 1.3,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Text(
                                model.data.products[index].price.toString(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.deepOrangeAccent,
                                    height: 1.3,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              if (model.data.products[index].discount != 0)
                                Text(
                                  model.data.products[index].oldPrice
                                      .toString(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      height: 1.3,
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              const Spacer(),
                              IconButton(
                                  onPressed: () {
                                    print(model.data.products[index].id);
                                    ShopCubit.get(context).editFavorites(
                                        model.data.products[index].id);
                                  },
                                  icon: (ShopCubit.get(context).favorites[
                                              model.data.products[index].id] ??
                                          false )
                                      ? const Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        )
                                      : const Icon(Icons.favorite_border))
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                        )
                      ],
                    );
                  }),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  SizedBox builtCategoriesItems(CategoriesModel? categoriesModel) {
    return SizedBox(
      height: 100,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ListView.separated(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return SizedBox(
                height: 100,
                width: 100,
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Image(
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            categoriesModel!.data.categoriesData[index].image)),
                    Container(
                      width: 100,
                      child: Text(
                        categoriesModel.data.categoriesData[index].name
                            .toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                      color: CupertinoColors.black.withOpacity(.7),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemCount: categoriesModel!.data.categoriesData.length),
      ),
    );
  }
}
