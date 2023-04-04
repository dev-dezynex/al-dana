import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../data.dart';
import '../models/branch_model.dart';

class BranchProvider extends GetConnect {
  // Future<BranchResult> getDummyData() async {
  //   final file = await rootBundle.loadString('assets/json/branch.json');
  //   final data = await jsonDecode(file);
  //   BranchResult result = BranchResult.fromJson(data);
  //   return result;
  // }

  Future<BranchResult> getBranches() async {
    BranchResult result;
    final response = await get(
      apiListBranch,
      headers: Auth().requestHeaders,
    );
    print('path $apiListBranch');
    print('response ${response.body}');
    if (response.statusCode == 200) {
      result = BranchResult.fromJson(response.body);
    } else {
      result = BranchResult.fromJson(
          {"status": "error", "message": "Server error !", "data": []});
    }

    return result;
  }


}
