class CategoriesModel {
  late bool status;
  late CategoriesDataModel data;
  CategoriesModel.fromJson(Map<String,dynamic> json){
    status =json['status'];
    data = CategoriesDataModel.fromJson(json['data']);

  }
}

class CategoriesDataModel {
  dynamic currentPage;
  List<CategoriesList> categoriesData = [];

  CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((e) {
      categoriesData.add(CategoriesList.fromJson(e));
    });
  }
}

class CategoriesList {
  dynamic id;
  String name = '';
  String image = '';

  CategoriesList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
