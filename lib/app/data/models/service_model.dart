import 'package:al_dana/app/data/data.dart';

class ServiceResult {
  late String status;
  late String message;
  late List<Service> serviceList;

  ServiceResult(
      {this.status = '', this.message = '', this.serviceList = const []});

  ServiceResult.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      serviceList = <Service>[];
      json['data'].forEach((v) {
        serviceList.add(Service.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['data'] = serviceList.map((v) => v.toJson()).toList();
    return data;
  }
}

class Service {
  late String id;
  late String title;
  late String desc;
  late String image;
  late String bgCardColor;
  late List<Branch> branchList;
  late double price;
  late SpareCategory spareCategory;
  late List<ServiceMode> serviceModeList;

  Service(
      {this.id = '',
      this.title = '',
      this.desc = '',
      this.image = '',
      this.bgCardColor = '',
      this.branchList = const [],
      this.price = 0,
      this.serviceModeList = const [],
      required this.spareCategory});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    desc = json['description'];
    image = json['image'];
    bgCardColor = json['bg_card_color'];
    if (json['branch'] != null) {
      branchList = <Branch>[];
      json['branch'].forEach((v) {
        branchList.add(Branch.fromJson(v));
      });
    }
    price = json['price'];

    if (json['serviceModeId'] != null) {
      serviceModeList = <ServiceMode>[];
      json['serviceModeId'].forEach((v) {
        serviceModeList.add(ServiceMode.fromJson(v));
      });
    }
    spareCategory = json['spare_category'] != null
        ? SpareCategory.fromJson(json['spare_category'])
        : SpareCategory();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['title'] = title;
    data['description'] = desc;
    data['image'] = image;
    data['bg_card_color'] = bgCardColor;
    data['branch'] = branchList.map((v) => v.toJson()).toList();
    data['price'] = price;

    return data;
  }
}
