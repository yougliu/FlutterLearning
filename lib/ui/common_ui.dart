import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:realflutter/utils/connect_util.dart';
import 'package:realflutter/common/common_static.dart';

/**
 * 此处UI都使用Material
 */

//加载框
class LoadingUi extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 35.0),
            child: new Center(
              child: new SpinKitFadingCircle(
                color: Colors.lightBlueAccent,
                size: 30.0,
              ),
            ),
          ),
          new Padding(
            padding: new EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
            child: new Center(
              child: new Text('正在搜索中，请稍后'),
            ),
          ),
        ],
      ),
    );
  }
}

typedef NetWorkCallback = void Function(int netState);

//网络提示
class NetHelpUi extends StatelessWidget{

  NetWorkCallback _callback;


  NetHelpUi(this._callback);

  checkNetWork(){
    print('checkNetWork');
    ConnectUtil.isConnectWifi().then((result){
      if(result){
        ConnectUtil.isConnectWifi().then((result){
          if(result && null != _callback){
            _callback(CommonContant.status_net_wifi_connected);
          }
        });
      }else{
        if(null != _callback){
          _callback(CommonContant.status_net_connecting);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          new GestureDetector(
            onTap: checkNetWork(),
            child: new Padding(
              padding: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 50.0),
              child: new Center(
                child: new Icon(
                  Icons.portable_wifi_off,
                  size: 60.0,
                ),
              ),
            ),
          ),
          new Padding(
            padding: new EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
            child: new Center(
              child: new Text("找不到网络，请检查您的设置"),
            ),
          ),
        ],
      ),
    );
  }

}