import 'package:get/get.dart';

import '../models/spare_category_model.dart';

class SpareCategoryProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return SpareCategoryResult.fromJson(map);
      if (map is List)
        return map.map((item) => SpareCategoryResult.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<SpareCategoryResult?> getSpareCategory(int id) async {
    final response = await get('sparecategory/$id');
    return response.body;
  }

  Future<Response<SpareCategoryResult>> postSpareCategory(
          SpareCategoryResult sparecategory) async =>
      await post('sparecategory', sparecategory);
  Future<Response> deleteSpareCategory(int id) async =>
      await delete('sparecategory/$id');
}
