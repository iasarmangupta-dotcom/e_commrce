import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../remote/app_exception.dart';

class ApiHelper {
  Future<dynamic> getAPI({required String url}) async {
    try {
      var response = await http.get(Uri.parse(url));
      return returnResponse(response);
    } on SocketException catch (e) {
      throw NoInternetException(msg: e.toString());
    } catch (e) {
      throw FetchDataException(msg: e.toString());
    }
  }

  Future<dynamic> postAPI({
    required String url,
    Map<String, dynamic>? mBodyParams,
    Map<String, String>? mHeaders,
    bool isAuth = false,
  }) async {
    try {

      if(!isAuth){
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String token = prefs.getString("token") ?? "";

        mHeaders ??= {};
        mHeaders["Authorization"] = "Bearer $token";
      }

      var response = await http.post(
          Uri.parse(url),
          body: mBodyParams != null
              ? jsonEncode(mBodyParams) : null,
          headers: mHeaders
      );
      return returnResponse(response);
    } on SocketException catch (e) {
      throw NoInternetException(msg: e.toString());
    } catch (e) {
      throw FetchDataException(msg: e.toString());
    }
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        {
          dynamic data = jsonDecode(response.body);
          return data;
        }

      case 400:
        {
          dynamic data = jsonDecode(response.body);
          throw BadRequestException(msg: data['message']);
        }

      case 401:
        {
          dynamic data = jsonDecode(response.body);
          throw UnauthorisedException(msg: data['message']);
        }

      case 403:
        {
          dynamic data = jsonDecode(response.body);
          throw UnauthorisedException(msg: data['message']);
        }

      case 500:
      case 502:
        {
          dynamic data = jsonDecode(response.body);
          throw ServerException(msg: data['message']);
        }

      default:
        {
          throw FetchDataException(msg: response.body.toString());
        }
    }
  }
}