class GetFavorite {
  late bool status;
  String? message;
  late GetFavoriteData data;

  GetFavorite.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = GetFavoriteData.fromJson(json['data']);
  }
}

class GetFavoriteData {
  late int currentPage;
  List<FavoriteListData> data = [];

  GetFavoriteData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((e) {
      data.add(FavoriteListData.fromJson(e));
    });
  }
}

class FavoriteListData {
  dynamic id;
  late ProductData product;

  FavoriteListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = ProductData.fromJson(json['product']);
  }
}

class ProductData {
  dynamic id;
  dynamic price;
  dynamic oldPrice;
  late int discount;
  late String image;
  late String name;
  late String description;

  ProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['oldPrice'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
