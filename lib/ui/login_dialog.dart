import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

//登录框
class LoginInDialog extends Dialog{
  @override
  Widget build(BuildContext context) {
    return new Material(
      type: MaterialType.transparency,//透明层
      child: new Center(
        child: new SizedBox(
          width: 300,
          height: 200,
          child: SizedBox.expand(
            child: new Container(
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
              ),
              child: new Column(
                children: <Widget>[
                  new Padding(
                    padding: new EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                    child: new Text(
                      '登录管理员',
                      style: new TextStyle(color: Colors.black,fontSize: 16.0,),
                    ),
                  ),
                  new Padding(
                    padding: new EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                    child: new TextField(
                      decoration: new InputDecoration(
                          hintText: '账户名'
                      ),
                    ),
                  ),
                  new Padding(
                    padding: new EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 20.0),
                    child: new TextField(
                      decoration: new InputDecoration(
                          hintText: '请输入管理员密码'
                      ),
                    ),
                  ),
                  new Divider(
                    height: 1.0,
                    indent: 0.0,
                    color: Colors.grey,
                  ),
                  new Row(
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          child: new Text('取消',style: new TextStyle(color: Colors.black,fontSize: 20.0),textAlign: TextAlign.center,),
//                          onTap: onTapCancel(context),
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        child: GestureDetector(
                          child: new Text('确定',style: new TextStyle(color: Colors.lightBlueAccent,fontSize: 20.0),textAlign: TextAlign.center,),
//                          onTap: onTapSure(context),
                        ),
                        flex: 1,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  onTapCancel(BuildContext context){
    Navigator.pop(context);
  }

  //登录
  onTapSure(BuildContext context){
    Toast.show('进行登录', context);
    onTapCancel(context);
  }
}