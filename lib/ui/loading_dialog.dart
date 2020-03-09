import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

//加载框
class LoadingDialog extends Dialog{
  @override
  Widget build(BuildContext context) {
    return new Material(
      type: MaterialType.transparency,//透明层
      child: new Center(
        child: new SizedBox(
          width: 160,
          height: 160,
          child: SizedBox.expand(
            child: new Container(
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
              ),
              child: new Stack(
                children: <Widget>[
                  new Padding(
                    padding: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 35.0),
                    child: new Center(
                      child: new SpinKitFadingCircle(
                        color: Colors.lightBlueAccent,
                        size: 30.0,
                      ),
                    ),
                  ),
                  new Padding(
                    padding: new EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                    child: new Center(
                      child: new Text('加载中，请稍后'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}