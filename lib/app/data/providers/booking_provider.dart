import 'package:get/get.dart';

import '../models/booking_model.dart';

class BookingProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return BookingResult.fromJson(map);
      if (map is List)
        return map.map((item) => BookingResult.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<BookingResult?> getBooking(int id) async {
    final response = await get('booking/$id');
    return response.body;
  }

  Future<Response<BookingResult>> postBooking(BookingResult booking) async =>
      await post('booking', booking);
  Future<Response> deleteBooking(int id) async => await delete('booking/$id');
}
