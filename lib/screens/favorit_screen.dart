import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/cubit/shop_cubit/shop_cubit.dart';
import 'package:untitled2/models/get_favorite_model.dart';

class Favorite extends StatelessWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! GetFavoritesLoadingState,
          fallback: (context) => const CircularProgressIndicator(),
          builder: (context) => ListView.separated(
              itemBuilder: (context, index) {
                return builtItem(
                    ShopCubit.get(context)
                        .getFavorite!
                        .data
                        .data[index]
                        .product,
                    context);
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: ShopCubit.get(context).getFavorite!.data.data.length),
        );
      },
    );
  }

  Widget builtItem(ProductData product, BuildContext context) {
    return SizedBox(
      height: 120,
      child: Row(
        children: [
          Stack(
            children: [
              Image(
                  width: 120, height: 120, image: NetworkImage(product.image)),
            ],
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 15),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      product.price.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 20),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    if (product.discount != 0)
                      Text(
                        product.oldPrice.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: Colors.grey),
                      ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          print(product.id);
                          ShopCubit.get(context).editFavorites(product.id);
                        },
                        icon: (ShopCubit.get(context).favorites[product.id] ??
                                false)
                            ? const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            : const Icon(Icons.favorite_border))
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
