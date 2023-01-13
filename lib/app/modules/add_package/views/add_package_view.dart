import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_package_controller.dart';

class AddPackageView extends GetView<AddPackageController> {
  const AddPackageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddPackageView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'AddPackageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
