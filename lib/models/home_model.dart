class HomeModel {
  var status;
  late HomeDataModel data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {
  List<BannersModel> banners = [];

  List<ProductsModel> products = [];

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((e) {
      banners.add(BannersModel.fromJson(e));
    });
    json['products'].forEach((e) {
      products.add(ProductsModel.fromJson(e));
    });
  }
}

class BannersModel {
  var id;

  String? image;

  BannersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductsModel {
  late int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  late String image;
  late String name;
  late bool inFavorites;
  late bool inCart;

  ProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
