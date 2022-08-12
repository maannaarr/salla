part of 'shop_cubit.dart';

@immutable
abstract class ShopState {}

class ShopInitial extends ShopState {}

class BottomNavChanger extends ShopState {}

class ShopDataLoadingState extends ShopState {}

class ShopDataErrorState extends ShopState {}

class ShopDataSuccessState extends ShopState {}

class CategoriesDataLoadingState extends ShopState {}

class CategoriesDataSuccessState extends ShopState {}

class CategoriesDataErrorState extends ShopState {}

class FavoritesSuccessState extends ShopState {}

class FavoritesErrorState extends ShopState {}

class GetFavoritesLoadingState extends ShopState {}

class GetFavoritesSuccessState extends ShopState {}

class GetFavoritesErrorState extends ShopState {}

class ProfileLoadingState extends ShopState {}

class ProfileSuccessState extends ShopState {
  final LoginData userData;

  ProfileSuccessState(this.userData);
}

class ProfileErrorState extends ShopState {}
