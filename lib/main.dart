import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:realflutter/common/common.dart';
import 'package:realflutter/main_frame.dart';
import 'package:realflutter/rookie_task_main.dart';
import 'package:realflutter/utils/rount_util.dart';
import 'package:rxdart/rxdart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        //定义主页面路由
        CommonConstant.routeMain: (ctx) => MainFrame(),
        CommonConstant.rookieTask:(ctx) => RookieTaskMain(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TimerUtil _timerUtil;

  void _init(){
    Stream.fromIterable([3,2,1])
        .delay(Duration(seconds: 1))
        .listen((int i){
        if(i == 1){
          RouteUtil.goMain(context);
        }
    });
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: new FlutterLogo(size: 100.0,),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (_timerUtil != null) _timerUtil.cancel(); //记得在dispose里面把timer cancel。
  }
}
