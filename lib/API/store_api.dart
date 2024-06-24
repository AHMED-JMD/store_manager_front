import 'package:dio/dio.dart';

final dio = Dio();
String apiUrl = 'http://localhost:8000/api/v1/item';

class StoreApi {
  static Future getItems () async {
    try{
      final response = await dio.get(apiUrl);

      return response;
    } catch (err){
      throw err;
    }
  }

  static Future getItemsById (String id) async {
    try{
      final response = await dio.get('$apiUrl/$id');

      return response;
    } catch (err){
      throw err;
    }
  }

  static Future addItems (data) async {
    try{
      Response response = await dio.post(apiUrl, data: data);

      return response;
    } catch (err){
      return err;
    }
  }

  static Future updateItems (String id, data) async {
    try{
      Response response = await dio.put('$apiUrl/$id', data: data);

      return response;
    } catch (err){
      return err;
    }
  }

  static Future deleteItems (String id) async {
    try{
      Response response = await dio.delete('$apiUrl/$id');

      return response;
    } catch (err){
      return err;
    }
  }
}