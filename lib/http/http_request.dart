import 'dart:io';
import 'package:dio/dio.dart';
import 'dart:collection';

//http请求管理类
class HttpRequest{

  static String _baseUrl;
  static const CONTENT_TYPE_JSON = "application/json";
  static const CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";
  static Map optionParams = {
    "timeoutMs":15000,
    "token":null,
    "authorizationCode":null,
  };

  static setBaseUrl(String baseUrl){
    _baseUrl = baseUrl;
  }

  static request(url,params,Map<String,String> header,Options options,{noTip = false}) async{
//    var connectivtityResult = await
  }
}