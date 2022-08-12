import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled2/dio_helper/login_dio_helper.dart';
import 'package:untitled2/models/categories_model.dart';
import 'package:untitled2/models/favorites_model.dart';
import 'package:untitled2/models/get_favorite_model.dart';
import 'package:untitled2/models/home_model.dart';
import 'package:untitled2/models/login_model.dart';
import 'package:untitled2/screens/categories_screen.dart';
import 'package:untitled2/screens/favorit_screen.dart';
import 'package:untitled2/screens/product_sreen.dart';
import 'package:untitled2/screens/settings_screen.dart';
import 'package:untitled2/widgets.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitial());

  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(
        icon: Icon(Icons.category_sharp), label: 'Categories'),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorite'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];
  List<Widget> pages = const [
    Products(),
    Categories(),
    Favorite(),
    Settings(),
  ];

  void bottomnav(int) {
    currentIndex = int;
    emit(BottomNavChanger());
  }

  HomeModel? homeModel;
  Map<dynamic, bool> favorites = {};

  void getHomeData() {
    emit(ShopDataLoadingState());
    DioHelper.getData(url: 'home', token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      print(value);
      homeModel!.data.products.forEach((element) {
        favorites.addAll({
          element.id: element.inFavorites,
        });
      });
      print(favorites.toString());

      emit(ShopDataSuccessState());
    }).catchError((e) {
      print(e.toString());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategories() {
    emit(CategoriesDataLoadingState());
    DioHelper.getData(url: 'categories').then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      print(value);
      emit(CategoriesDataSuccessState());
    }).catchError((e) {
      emit(CategoriesDataErrorState());
      print(e.toString());
    });
  }

  FavoritesModel? favoritesModel;

  void editFavorites(int id) {
    DioHelper.postData(url: 'favorites', token: token, data: {'product_id': id})
        .then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      print(value.data);
      if (favoritesModel!.status) {
        favorites[id] = !(favorites[id] ?? false);
        getFavoriteList();
      } else {
        Fluttertoast.showToast(
            msg: "An ERROR has happen",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.SNACKBAR,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.redAccent,
            textColor: Colors.black,
            fontSize: 20.0);
      }
      emit(FavoritesSuccessState());
    }).catchError((e) {
      emit(FavoritesErrorState());
      print(e.toString());
    });
  }

  GetFavorite? getFavorite;

  void getFavoriteList() {
    emit(GetFavoritesLoadingState());
    DioHelper.getData(
      url: 'favorites',
      token: token,
    ).then((value) {
      getFavorite = GetFavorite.fromJson(value.data);
      print(value.data);
      emit(GetFavoritesSuccessState());
    }).catchError((e) {
      emit(GetFavoritesErrorState());
      print(e.toString());
    });
  }

  LoginData? userData;

  void getProfileData() {
    emit(ProfileLoadingState());
    DioHelper.getData(
      url: 'profile',
      token: token,
    ).then((value) {
      userData = LoginData.fromJson(value.data);
      print(value.data);
      emit(ProfileSuccessState(userData!));
    }).catchError((e) {
      emit(ProfileErrorState());
      print(e.toString());
    });
  }
}
