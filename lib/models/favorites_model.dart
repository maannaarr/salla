class FavoritesModel {
  late bool status;
  late String message;
  // late DataFavorite data;

  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    // data = DataFavorite.fromJson(json['data']);
  }
}

class DataFavorite {
  late int id;

  late FavoriteData product;

  DataFavorite.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = FavoriteData.fromJson(json['product']);
  }
}

class FavoriteData {
  late int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  late String image;

  FavoriteData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
  }
}
