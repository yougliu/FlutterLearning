import 'package:flutter/material.dart';
import 'package:realflutter/model/route_bean.dart';
import 'package:toast/toast.dart';

//登录框
class LoginInDialog extends Dialog{

  final RouteBean _router;
  final VoidCallback _callback;


  LoginInDialog(this._router, this._callback);

  @override
  Widget build(BuildContext context) {
    return new Material(
      type: MaterialType.transparency,//透明层
      child: new Center(
        child: new SizedBox(
          width: 300,
          height: 210,
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
                        hintText: _router.name,
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
                          onTap: ()=>onTapCancel(context),
                          child: new Padding(
                            padding: new EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                            child: new Text('取消',style: new TextStyle(color: Colors.black,fontSize: 20.0),textAlign: TextAlign.center,),
                          ),
                        ),
                      ),
                      new Container(
                        height: 30.0,
                        child: new VerticalDivider(
                          width: 1.0,
                          color: Colors.grey,
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                            child: new Padding(
                              padding: new EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                              child: new Text('确定',style: new TextStyle(color: Colors.lightBlueAccent,fontSize: 20.0),textAlign: TextAlign.center,),
                            ),
                          onTap: (){
                            onTapSure(context);
                          }
                        ),
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
    onTapCancel(context);
    if(null != _callback){
      _callback();
    }
  }
}