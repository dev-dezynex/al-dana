class ServiceModeResult {
  String? status;
  String? message;
  List<ServiceMode>? data;

  ServiceModeResult({this.status, this.message, this.data});

  ServiceModeResult.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ServiceMode>[];
      json['data'].forEach((v) {
        data?.add(ServiceMode.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['data'] = this.data?.map((v) => v.toJson()).toList();
    return data;
  }
}

class ServiceMode {
  String? id;
  String? title;
  String? desc;
  String? bgCardColor;

  ServiceMode({this.id, this.title, this.desc, this.bgCardColor});

  ServiceMode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    desc = json['desc'];
    bgCardColor = json['bg_card_color'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['desc'] = desc;
    data['bg_card_color'] = bgCardColor;
    return data;
  }
}
