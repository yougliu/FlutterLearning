import 'package:flutter/cupertino.dart';
import 'package:toast/toast.dart';

class ToastUtil{

  static void showToast(BuildContext context,String content){
    if(content.isEmpty){
      return;
    }
    Toast.show(content, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER);
  }
}