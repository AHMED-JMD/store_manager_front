import 'package:dio/dio.dart';

final dio = Dio();
String apiUrl = 'http://localhost:8000/api/v1/transaction';

class TranApi {
  static Future addTran (data) async {
    try{
      final response = await dio.post(apiUrl, data: data);

      return response;
    } catch (e) {
      return e;
    }
  }

  static Future getAll () async {
    try{
      final response = await dio.get(apiUrl);

      return response;
    } catch (e) {
      return e;
    }
  }

  static Future getById (String id) async {
    try{
      final response = await dio.get('$apiUrl/$id');

      return response;
    } catch (e) {
      return e;
    }
  }

  static Future updateTran (String id, data) async {
    try{
      final response = await dio.put('$apiUrl/$id', data: data);

      return response;
    } catch (e) {
      return e;
    }
  }

  static Future deleteTran (String id) async {
    try{
      final response = await dio.delete('$apiUrl/$id');

      return response;
    } catch (e) {
      return e;
    }
  }
}

