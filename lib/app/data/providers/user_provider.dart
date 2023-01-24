import 'package:get/get.dart';

import '../models/user_model.dart';

class UserProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return UserResult.fromJson(map);
      if (map is List) {
        return map.map((item) => UserResult.fromJson(item)).toList();
      }
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<UserResult?> getUser(int id) async {
    final response = await get('user/$id');
    return response.body;
  }

  Future<Response<UserResult>> postUser(UserResult user) async =>
      await post('user', user);
  Future<Response> deleteUser(int id) async => await delete('user/$id');
}
