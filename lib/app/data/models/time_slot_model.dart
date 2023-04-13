class TimeSlotResult {
  String? status;
  String? message;
  List<TimeSlot>? timeSlotList;

  TimeSlotResult({this.status, this.message, this.timeSlotList});

  TimeSlotResult.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      timeSlotList = <TimeSlot>[];
      json['data'].forEach((v) {
        timeSlotList!.add(TimeSlot.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (timeSlotList != null) {
      data['data'] = timeSlotList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TimeSlot {
  String? sId;
  String? startTime;
  String? endTime;
  int? maxBooking;
  bool? status;
  bool? deletable;
  int? iV;

  TimeSlot(
      {this.sId,
      this.startTime,
      this.endTime,
      this.maxBooking,
      this.status,
      this.deletable,
      this.iV});

  TimeSlot.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    maxBooking = json['maxBooking'];
    status = json['status'];
    deletable = json['deletable'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['maxBooking'] = maxBooking;
    data['status'] = status;
    data['deletable'] = deletable;
    data['__v'] = iV;
    return data;
  }
}






















// class TimeSlotResult {
//   late String status, message;
//   late List<TimeSlot> timeSlotList;

//   TimeSlotResult({this.status='', this.message='', this.timeSlotList=const[]});

//   TimeSlotResult.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     if (json['data'] != null) {
//       timeSlotList = <TimeSlot>[];
//       json['data'].forEach((v) {
//         timeSlotList.add(TimeSlot.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['status'] = status;
//     data['message'] = message;
//     data['data'] = timeSlotList.map((v) => v.toJson()).toList();
//     return data;
//   }
// }

// class TimeSlot {
//   late String id, day, createdBy, createdAt;
//   late List<String> slotes;
//   late bool status;

//   TimeSlot(
//       {this.id = '',
//       this.day = '',
//       this.slotes = const [],
//       this.status = false,
//       this.createdBy = '',
//       this.createdAt = ''});

//   TimeSlot.fromJson(Map<String, dynamic> json) {
//     id = json['id'] ?? '';
//     day = json['day'] ?? '';
//     slotes = json['slotes'] != null ? json['slotes'].cast<String>() : [];
//     status = json['status'] ?? false;
//     createdBy = json['created_by'] ?? '';
//     createdAt = json['created_at'] ?? '';
//   }

//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['_id'] = id;
//     data['day'] = day;
//     data['slotes'] = slotes;
//     data['status'] = status;
//     data['created_by'] = createdBy;
//     data['created_at'] = createdAt;
//     return data;
//   }
// }
