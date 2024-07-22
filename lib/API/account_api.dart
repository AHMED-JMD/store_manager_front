import 'package:dio/dio.dart';

final dio = Dio();
String apiUrl = 'http://localhost:8000/api/v1/employee';

class AccountApi {
  static Future getAll() async {
    try{
      final response = await dio.get(apiUrl);

      return response;
    } catch (e){
      rethrow;
    }
  }

  static Future getById(String id) async {
    try{
      final response = await dio.get('$apiUrl/$id');

      return response;
    } catch (e){
      rethrow;
    }
  }

  static Future add(Map data) async {
    try{
      final response = await dio.post(apiUrl, data: data);

      return response;
    } catch (e){
      rethrow;
    }
  }

  static Future update(String id, Map data) async {
    try{
      final response = await dio.put('$apiUrl/$id', data: data);

      return response;
    } catch (e){
      rethrow;
    }
  }

  static Future delete(String id) async {
    try{
      final response = await dio.delete('$apiUrl/$id');

      return response;
    } catch (e){
      return e;
    }
  }
}