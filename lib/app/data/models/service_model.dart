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
  late String subTitle;
  late String desc;
  late String image;
  late String bgCardColor;
  late List<String> station;
  late double price;
  late List<String> work;
  late SpareCategory spareCategory;

  Service(
      {this.id = '',
      this.title = '',
      this.subTitle = '',
      this.desc = '',
      this.image = '',
      this.bgCardColor = '',
      this.station = const [],
      this.price = 0,
      this.work = const [],
      required this.spareCategory});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subTitle = json['sub_title'];
    desc = json['desc'];
    image = json['image'];
    bgCardColor = json['bg_card_color'];
    station = json['station'].cast<String>();
    price = json['price'];
    work = json['work'].cast<String>();
    spareCategory = json['spare_category'] != null
        ? SpareCategory.fromJson(json['spare_category'])
        : SpareCategory();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['sub_title'] = subTitle;
    data['desc'] = desc;
    data['image'] = image;
    data['bg_card_color'] = bgCardColor;
    data['station'] = station;
    data['price'] = price;
    data['work'] = work;
    return data;
  }
}
