import 'dart:convert';

import 'package:al_dana/app/data/constants/api_routes.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../data.dart';
import '../models/time_slot_model.dart';

class TimeSlotProvider extends GetConnect {
  // Future<TimeSlotResult> getDummyData() async {
  //   final file = await rootBundle.loadString('assets/json/time_slot.json');
  //   final data = await jsonDecode(file);
  //   TimeSlotResult result = TimeSlotResult.fromJson(data);
  //   return result;
  // }

  Future<TimeSlotResult> getTimeSlots() async {
    Auth auth = Auth();
    Map<String, dynamic> qParams = {
      'filter[branchId]':"64141211eee221aaf21fed9c",
      'filter[categoryId]':"6406e003355da5fc60f38cac",
      'filter[date]':"21/03/2023",
    };
    final response = await get(apiGetTimeSlot, headers: auth.requestHeaders,query: qParams);

    if (response.statusCode == 401) {
      auth.authFailed(response.body['message']);
    }

    return TimeSlotResult.fromJson(response.body);
  }
}
