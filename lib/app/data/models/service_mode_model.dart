class ServiceModeResult {
  String? status;
  String? message;
  List<ServiceMode>? serviceModeList;

  ServiceModeResult({this.status, this.message, this.serviceModeList});

  ServiceModeResult.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      serviceModeList = <ServiceMode>[];
      json['data'].forEach((v) {
        serviceModeList?.add(ServiceMode.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['data'] = serviceModeList?.map((v) => v.toJson()).toList();
    return data;
  }
}

class ServiceMode {
 late String id,title,desc, bgCardColor;
 late bool status;
  

  ServiceMode({this.id='', this.title='', this.desc='', this.bgCardColor='',this.status=false});

  ServiceMode.fromJson(Map<String, dynamic> json) {
    id = json['_id']??'';
    title = json['title']??'';
    desc = json['description']??'';
    bgCardColor = json['bg_card_color']??'';
    status = json['status']??false;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['title'] = title;
    data['description'] = desc;
    data['bg_card_color'] = bgCardColor;
    data['status'] = status;
    return data;
  }
}
