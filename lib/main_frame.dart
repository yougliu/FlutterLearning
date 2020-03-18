import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:realflutter/common/common.dart';
import 'package:realflutter/common/common_static.dart';
import 'package:realflutter/http/login_in.dart';
import 'package:realflutter/rookie_task_main.dart';
import 'package:realflutter/utils/connect_util.dart';
import 'package:realflutter/utils/rount_util.dart';
import 'package:realflutter/utils/toast_util.dart';
import 'package:realflutter/ui/common_ui.dart';
import 'package:realflutter/ui/login_dialog.dart';
import 'package:realflutter/webview/w_webview.dart';
import 'package:toast/toast.dart';
import 'package:realflutter/utils/aes_util.dart';

import 'model/route_bean.dart';
import 'ui/loading_dialog.dart';
import 'package:rxdart/rxdart.dart';

//主页面--进行udp 路由检索
class MainFrame extends StatelessWidget {

  List<RouteBean> mList = [
    RouteBean('中兴路由',''),
    RouteBean('华为路由',''),
    RouteBean('小米路由',''),
    RouteBean('TPlink路由',''),
    RouteBean('大米路由',''),
    RouteBean('水稻路由',''),
  ];

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

class _RouterListPageState extends State<RouterListPage> with WidgetsBindingObserver{

  //1、网络连接 2、搜索中 3、结果展示
  RouteBean _selectRouter;
  Timer _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    timerStart();
  }

  timerStart(){
    _timer = Timer.periodic(Duration(seconds: 2), (timer){
      //进行刷新 30s
      searchRouter();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch(state){
      case AppLifecycleState.resumed:
        //回到前台
        timerStart();
        break;
      case AppLifecycleState.paused:
        //后台
        _timer?.cancel();
        break;
      case AppLifecycleState.inactive:
        // TODO: Handle this case.
        break;
      case AppLifecycleState.detached:
        // TODO: Handle this case.
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  searchRouter(){
    print('search router');
  }

  freshUI(){
    setState(() {

    });
  }

  _onNetTap(int netState){
    freshUI();
  }

  Future<int> mockNewData() async{
    bool connected = await ConnectUtil.isConnectWifi();
    if(!connected){
      await Future.delayed(Duration(seconds: 0));
      return 0;
    }else{
      //进行检索
      await Future.delayed(Duration(seconds : 2));
      return 3;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<int>(
        future: mockNewData(),
        builder: (BuildContext context,AsyncSnapshot snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.hasError){
              return Text("Error: ${snapshot.error}");
            }else{
              if(snapshot.data == 1){
                return NetHelpUi(_onNetTap);
              }else if(snapshot.data == 3){
                return BuildListView(context);
              }
            }
          }else{
            //加载中
            return LoadingUi();
          }
        },
      ),
    );
  }

  //登录回调
  loginInCallback(){
    if(null == _selectRouter){
      return;
    }
    showDialog(context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return new LoadingDialog();
      },
    );
    //进行登录请求--模拟三秒
    Stream.fromIterable([3,2,1])
        .delay(Duration(seconds: 1))
        .listen((int i){
      if(i == 1){
        //跳转本地H5页面--动态配置跳转页面
        Navigator.pop(context);
        Navigator.of(context).push(
          new MaterialPageRoute(
            builder: (BuildContext context){
              String loadUrl = "https://www.vmall.com/index.html";
              return WidgetWebview(loadUrl);
            }
          ),
        );
      }
    });
  }

  //显示登录框
  showLoginInDialog(RouteBean router){
    if(null == router){
      return;
    }
    _selectRouter = router;
    showDialog(context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return new LoginInDialog(router,loginInCallback);
      }
    );
  }

  //跳转到路由器详情页面
//  jumpRouterDetailPage(){
//    print('jumpRouterDetailPage');
//    Navigator.of(context).push(new PageRouteBuilder(
//        pageBuilder: (BuildContext context,Animation<double> animation,Animation<double> secondaryAnimation){
//          //跳转页面
//          return null;
//        },
//        transitionsBuilder: (BuildContext context,Animation<double> animation,Animation<double> secondAnimation,Widget child){
//          //动画
//          return createTransition(animation,child);
//        }
//    ));
//  }
//
//  //创建动画
//  SlideTransition createTransition(Animation<double> animation , Widget child){
//    return new SlideTransition(
//        position: new Tween<Offset>(
//          begin: const Offset(1.0, 0.0),
//          end:const Offset(0.0, 0.0),
//        ).animate(animation),
//      child: child,
//    );
//  }

  Widget BuildListView(BuildContext context){
    final tiles = CommonContant.mDataList.map((router){
      return new ListTile(
        title: new Text(router.name),
        leading: new Icon(Icons.account_circle),
        trailing: new Icon(Icons.navigate_next),
//        onTap: ()=>showLoginInDialog(router),
        onTap: ()=> RouteUtil.pushReplacementNamed(context,CommonConstant.rookieTask),
      );
    });
    final divided = ListTile.divideTiles(
      tiles: tiles,
      context:context,
    ).toList();
    return new Scaffold(
      body: new ListView(children: divided,),
    );
  }
}

