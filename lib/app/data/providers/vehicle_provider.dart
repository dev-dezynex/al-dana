import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../data.dart';
import '../models/vehicle_model.dart';

class VehicleProvider extends GetConnect {
  // Future<VehicleResult> getDummyData() async {
  //   final file = await rootBundle.loadString('assets/json/vehicle.json');
  //   final data = await jsonDecode(file);
  //   VehicleResult result = VehicleResult.fromJson(data);
  //   return result;
  // }

  Future<VehicleResult> addVehicle({required Vehicle vehicle}) async {
    final response = await post(apiAddVehicle, vehicle.toPost(),
        headers: Auth().requestHeaders);

    if (response.statusCode == 401) {
      Auth().authFailed(response.body['message']);
    }
    print('response ${jsonEncode(response.body)}');
    return VehicleResult.fromJson(response.body);
  }

  Future<VehicleResult> getVehicles() async {
    final response = await get('$apiListActiveVehicle/641d36d719d46e11c8253d85',
        headers: Auth().requestHeaders);

    if (response.statusCode == 401) {
      Auth().authFailed(response.body['message']);
    }
    print('auth ${Auth().requestHeaders}');
    print('path $apiListActiveVehicle/641d36d719d46e11c8253d85');
    print('response ${jsonEncode(response.body)}');

    return VehicleResult.listFromJson(response.body);
  }
}
