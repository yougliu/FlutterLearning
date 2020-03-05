import 'package:flutter/material.dart';
import 'package:realflutter/utils/connect_util.dart';
import 'package:realflutter/utils/toast_util.dart';

//主页面--进行udp 路由检索
class MainFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('中兴智能路由器'),
        centerTitle: true,
      ),
      body: new RouterListPage(),
    );
  }
}

class RouterListPage extends StatefulWidget {

  @override
  _RouterListPageState createState() => _RouterListPageState();
}

class _RouterListPageState extends State<RouterListPage> {

  //1、网络连接 2、搜索中 3、结果展示
  int _pageState = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();
  }

  //初始化--状态：1、网络连接 2、搜索中 3、结果展示
  void _init(){
    ConnectUtil.isConnectd().then((result){
      if(!result){
        ToastUtil.showToast(context, "请检查网络连接");
      }else{
        ConnectUtil.isConnectWifi().then((result){
          if(!result){
            ToastUtil.showToast(context, "请连接到wifi");
          }else{
            //连接到wifi--进行搜索
            _pageState = 2;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
    );
  }
}

