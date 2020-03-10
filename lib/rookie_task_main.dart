import 'package:flutter/material.dart';

//新手任务主页面
class RookieTaskMain extends StatefulWidget {
  @override
  _RookieTaskMainState createState() => _RookieTaskMainState();
}

class _RookieTaskMainState extends State<RookieTaskMain> {
  @override
  Widget build(BuildContext context) {
    return concatBuild(context);
  }

  Widget concatBuild(BuildContext context) {
    return Material(
      child: CustomScrollView(
        slivers: <Widget>[
          //appbar
          SliverAppBar(
            pinned: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
            ),
            automaticallyImplyLeading: true,
            expandedHeight: 245,
            title: const Text('新手任务'),
            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: <StretchMode>[
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
                StretchMode.fadeTitle,
              ],
              collapseMode: CollapseMode.parallax,
              background: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Image.asset(
                    './images/rookie_task_bg.png',
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(14.0, 100.0, 0.0, 0.0),
                    child: Text(
                      'Hi Flutter',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(14.0, 130.0, 0.0, 0.0),
                    child: Text(
                      '完成全部新手任务，可获得新手毕业勋章',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: buildMiddleView(context),
          ),
          SliverFixedExtentList(
            itemExtent: 50.0,
            delegate: new SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return new Container(
                  alignment: Alignment.center,
                  color: Colors.lightBlue,
                  child: Text('list item $index'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMiddleView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.5, 0.0, 8.5, 0.0),
      child: SizedBox(
        child: Card(
          elevation: 10.0,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: Row(
            children: <Widget>[
              Column(
                children: <Widget>[Text('免费阅读已结束')],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
