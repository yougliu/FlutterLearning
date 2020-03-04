import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:realflutter/common/common.dart';
import 'package:realflutter/main_frame.dart';
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
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TimerUtil _timerUtil;

  void _init(){
    Stream.fromIterable([1])
        .delay(Duration(seconds: 1))
        .listen((int i){
        if(i == 1){
          print('setOnTimerTickCallback');
          RouteUtil.goMain(context);
        }
    });

//    _timerUtil = new TimerUtil(mTotalTime: 1000);
//    _timerUtil.setOnTimerTickCallback((int timerTick){
//      if(timerTick == 1000){
//        //主页面
//        print('setOnTimerTickCallback');
//        RouteUtil.goMain(context);
//      }
//    });
//    _timerUtil.startCountDown();
    print('startCountDown');
  }

  @override
  void initState() {
    super.initState();
    print('initState');
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: new FlutterLogo(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (_timerUtil != null) _timerUtil.cancel(); //记得在dispose里面把timer cancel。
  }
}
