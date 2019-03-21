import 'package:dio/dio.dart';

final apiId='3912d4054f7a22e0b88d9d0f5fb18f69';
final defaultCity='Weifang';


Future<Map> getData(String apiUrl) async {
  try {
    Response response = await Dio().get(apiUrl);

    return response.data;
  } catch (e) {
    
  }

  return null;
}

Future<Map> postJson(String apiUrl,FormData formData) async {

  try {
    Response response = await Dio().post(apiUrl, data: formData);

    return response.data;
  } catch (e) {
    
  }

  return null;
}