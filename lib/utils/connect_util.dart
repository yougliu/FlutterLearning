import 'package:connectivity/connectivity.dart';

class ConnectUtil{

  //是否联网
  static Future<bool> isConnectd() async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  //是否连接wifi
  static Future<bool> isConnectWifi() async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult == ConnectivityResult.wifi;
  }

  //获取wifi名称
  static Future<String> getWifiName() async{
    String wifiName = await (Connectivity().getWifiName());
    return wifiName;
  }

}