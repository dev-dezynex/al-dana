import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../models/service_mode_model.dart';

class ServiceModeProvider extends GetConnect {
  Future<ServiceMode> getDummyData() async {
    final file = await rootBundle.loadString('assets/json/service_mode.json');
    final data = await jsonDecode(file);
    ServiceMode result = ServiceMode.fromJson(data);
    return result;
  }
}
