import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../constants/constants.dart';
import '../models/service_model.dart';

class ServiceProvider extends GetConnect {

  Future<ServiceResult> getDummyData() async {
    final file = await rootBundle.loadString('assets/json/service.json');
    final data = await jsonDecode(file);
    ServiceResult result = ServiceResult.fromJson(data);
    return result;
  }

  Future<ServiceResult> getExtraDummyData() async {
    final file = await rootBundle.loadString('assets/json/extra_service.json');
    final data = await jsonDecode(file);
    ServiceResult result = ServiceResult.fromJson(data);
    return result;
  }



  Future<ServiceResult> getServices() async {
    ServiceResult result;

    final response = await get(
      apiListService,
      headers: Auth().requestHeaders,
    ).timeout(Duration(minutes: 1));

    print('auth ${Auth().requestHeaders}');
    print('path $apiListService');
    print('responseCode ${response.statusCode}');
    print('response ${response.body}');
    if (response.statusCode == 401) {
      Auth().authFailed(response.body['message']);
    }
    result = ServiceResult.fromJson(response.body);
    return result;
  }
}
