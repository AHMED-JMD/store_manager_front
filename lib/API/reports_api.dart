import 'package:dio/dio.dart';

final dio = Dio();
String apiUrl = 'http://localhost:8000/api/v1/reports';

class ReportApi {
  static Future homeReports(Map data) async {
    try {
      final response = await dio.post('$apiUrl/home_report', data: data);

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
