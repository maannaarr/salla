class RegisterData {
  var status;
  String message = '';

  late UserData data;

  RegisterData.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = (json["data"] != null ? UserData.fromJson(json['data']) : null)!;
  }
}

class UserData {
  var id;
  String name = '';
  var email;
  var phone;
  var image;
  var points;
  var credit;
  var token;

  UserData.fromJson(Map<dynamic, dynamic> json) {
    id = json["id"];
    name = json["name"];
    email = json["email"];
    phone = json["phone"];
    image = json["image"];
    points = json["points"];
    credit = json["credit"];
    token = json["token"];
  }
}
