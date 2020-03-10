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
  RouteBean _selectRouter;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();
  }

  freshUI(){
    setState(() {

    });
  }

  //初始化--状态：1、网络连接 2、搜索中 3、结果展示
  void _init(){
    ConnectUtil.isConnectd().then((result){
      if(!result){
        _pageState = 1;
        freshUI();
      }else{
        ConnectUtil.isConnectWifi().then((result){
          if(!result){
            _pageState = 1;
            freshUI();
          }else{
            //连接到wifi--进行搜索
            _pageState = 3;
            freshUI();
          }
        });
      }
    });
  }

  _onNetTap(int netState){
    _pageState = netState;
    freshUI();
  }

  @override
  Widget build(BuildContext context) {
    Widget childWidget;
    if(_pageState == 1){
      //网络提示
      childWidget = new NetHelpUi(_onNetTap);
    } else if(_pageState == 2){
      //loading搜索
      childWidget = new LoadingUi();
    } else if(_pageState == 3){
      //结果展示
      childWidget = BuildListView(context);
    }
    return childWidget;
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

