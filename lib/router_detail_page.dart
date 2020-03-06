import 'package:flutter/material.dart';
import 'package:realflutter/model/route_bean.dart';

//路由器详情页面
class RouterDetailPage extends StatefulWidget {

  RouteBean _routeBean;

  RouterDetailPage(this._routeBean);

  @override
  _RouterDetailPageState createState() => _RouterDetailPageState();
}

class _RouterDetailPageState extends State<RouterDetailPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('1111'),
      ),
    );
  }
}
