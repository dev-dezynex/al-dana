class UserResult {
  late String status, message;
  late User user;

  UserResult({this.status = '', this.message = '', required this.user});

  UserResult.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    user = json['data'] != null ? User?.fromJson(json['data']) : User();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['data'] = user.toJson();
    return data;
  }
}

class User {
  late String id, name, email, image, scope;
  late int mobile;
  late bool status;

  User(
      {this.id = '',
      this.name = '',
      this.mobile = 0,
      this.email = '',
      this.image = '',
      this.scope = '',
      this.status = false});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    name = json['name'] ?? '';
    mobile = json['mobile'] ?? 0;
    email = json['email'] ?? '';
    image = json['image'] ?? '';
    scope = json['scope'] ?? '';
    status = json['status'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['mobile'] = mobile;
    data['email'] = email;
    data['image'] = image;
    data['scope'] = scope;
    data['status'] = status;
    return data;
  }
}
