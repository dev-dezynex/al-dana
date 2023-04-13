import '../data.dart';

class BookingResult {
  String? status;
  String? message;
  List<Booking>? bookingList;
  Booking? booking;

  BookingResult({this.status, this.message, this.bookingList = const []});

  BookingResult.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    booking = json['data'] != null ? Booking.fromJson(json['data']) : Booking();
  }
  BookingResult.listFromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    bookingList = <Booking>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        bookingList?.add(Booking.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['data'] = bookingList?.map((v) => v.toJson()).toList();
    return data;
  }
}

class Booking {
  String? id;
  String? date;
  String? slot;
  String? approvalStatus;
  List<PackageModel>? packageList;
  List<Service>? services;
  List<Spare>? spares;
  Vehicle? vehicle;
  Branch? branch;
  ServiceMode? mode;
  Address? address;
  late bool autoSpareSelect;
  late String couponCode;
  late double price, subscribedPrice;

  Booking({
    this.id,
    this.date,
    this.slot,
    this.approvalStatus,
    this.packageList,
    this.services,
    this.spares,
    this.vehicle,
    this.branch,
    this.mode,
    this.address,
    this.autoSpareSelect = true,
    this.couponCode = '',
    this.price = 0.0,
    this.subscribedPrice = 0.0,
  });

  Booking.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    date = json['date'];
    slot = json['slot'];
    approvalStatus = json['approval_status'];
    autoSpareSelect = json['auto_spare_select'] ?? true;
    price = double.parse(json['totalAmount'].toString());
    subscribedPrice = json['subscribed_price'] ?? 0.0;
    if (json['packages'] != null) {
      packageList = <PackageModel>[];
      json['packages'].forEach((v) {
        packageList?.add(PackageModel.fromJson(v));
      });
    }
    if (json['services'] != null) {
      services = <Service>[];
      json['services'].forEach((v) {
        services?.add(Service.fromJson(v));
      });
    }
    if (json['spares'] != null) {
      spares = <Spare>[];
      json['spares'].forEach((v) {
        spares?.add(Spare.fromJson(v));
      });
    }
    vehicle =
        json['vehicle'] != null ? Vehicle?.fromJson(json['vehicle']) : null;
    branch = json['branch'] != null ? Branch?.fromJson(json['branch']) : null;
    mode = json['mode'] != null ? ServiceMode?.fromJson(json['mode']) : null;
    address =
        json['address'] != null ? Address?.fromJson(json['address']) : null;
    couponCode = '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['date'] = date;
    data['slot'] = slot;
    data['auto_spare_select'] = autoSpareSelect;
    data['totalAmount'] = price;
    data['approval_status'] = approvalStatus;
    if (packageList != null) {
      data['packages'] = packageList?.map((v) => v.toJson()).toList();
    }
    if (services != null) {
      data['services'] = services?.map((v) => v.toJson()).toList();
    }
    if (spares != null) {
      data['spares'] = spares?.map((v) => v.toJson()).toList();
    }
    if (vehicle != null) {
      data['vehicle'] = vehicle?.toJson();
    }

    if (branch != null) {
      data['branch'] = branch?.toJson();
    }

    if (mode != null) {
      data['mode'] = mode?.toJson();
    }
    if (address != null) {
      data['address'] = address?.toJson();
    }

    return data;
  }

  Map<String, dynamic> toPost() {
    Common common = Common();
    final data = <String, dynamic>{};
    data['branchId'] = common.selectedBranch.id;
    data['customerId'] = common.currentUser.id;
    data['vehicleId'] = vehicle?.id;
    data['categoryId'] = common.selectedCategory.id;
    if (services != null && services!.isNotEmpty) {
      data['service'] = services?.map((v) => v.toPost()).toList();
    }
    if (packageList != null && packageList!.isNotEmpty) {
      data['package'] = packageList?.map((v) => v.toPost()).toList();
    }
    if (spares != null && spares!.isNotEmpty) {
      data['spareId'] = spares?.map((v) => v.toPost()).toList();
    }
    if (mode != null) {
      data['serviceModeId'] = mode?.id;
    }
    data['totalAmount'] = price;
    if (couponCode.isNotEmpty) {
      data['couponId'] = couponCode;
    }

    data['discountAmount'] = 0;
    data['date'] = date;
    data['timeSlotId'] = "643413e05251bf1ca375588e";
    if (address != null) {
      data['AddressId'] = address?.sId;
    }
    return data;
  }
}
