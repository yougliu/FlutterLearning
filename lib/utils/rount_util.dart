
import 'package:flutter/material.dart';
import 'package:realflutter/common/common.dart';

class RouteUtil{

  static void pushReplacementNamed(BuildContext context,String pageName){
    if(null == pageName || pageName.length == 0){
      return;
    }
    Navigator.of(context).pushReplacementNamed(pageName);
  }

  static void goMain(BuildContext context){
    print('goMain');
    pushReplacementNamed(context, CommonConstant.routeMain);
//    Navigator.of(context).pushNamed(CommonConstant.routeMain);
  }
}