import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WidgetWebview extends StatefulWidget {

  String loadUrl = '';
  String title = '';

  WidgetWebview(this.loadUrl);

  @override
  State<StatefulWidget> createState() {
    State webViewState;
    if(loadUrl.isEmpty){
      //404页面
    } else if(loadUrl.startsWith('http')){
      //网络页面
      webViewState = _WebViewNetState();
    } else{
      //本地页面
      webViewState = _WebviewLocalState();
    }
    return webViewState;
  }
}

abstract class _WidgetWebviewState extends State<WidgetWebview> {

  WebViewController _webViewController;

  _getTitle() async {
    if(null == _webViewController){
      return;
    }
    String title = await _webViewController.getTitle();
    setState(() {
      widget.title = title;
    });
  }


}

//网络页面
class _WebViewNetState extends _WidgetWebviewState{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: FutureBuilder(
        builder: (context,snapshot){
          return WebView(
            initialUrl: widget.loadUrl,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (controller){
              _webViewController = controller;
            },
            onPageFinished: (url){
              _getTitle();
            },
          );
        },
      ),
    );
  }

}

//本地加载
class _WebviewLocalState extends _WidgetWebviewState {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _loadHtmlFile(),
        builder: (context, snapshot) {
          return WebView(
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl: Uri.dataFromString(snapshot.data,
                    mimeType: 'text/html',
                    encoding: Encoding.getByName('utf-8'))
                .toString(),
            javascriptChannels: [_toastJsChannel(context)].toSet(),
            onWebViewCreated: (WebViewController controller) {
              print("webview page: webview created...");
              _webViewController = controller;
              _webViewController.loadUrl(new Uri.dataFromString(snapshot.data,
                      mimeType: 'text/html',
                      encoding: Encoding.getByName('utf-8'))
                  .toString());
            },
            onPageFinished: (url) {
              print("webview page: load finished...url=$url");
              _getTitle();
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          /// 调用 JS 的方法
          _webViewController.evaluateJavascript(
              "flutterCallJsMethod('message from Flutter!')");
        },
      ),
    );
  }

  // 创建 JavascriptChannel
  JavascriptChannel _toastJsChannel(BuildContext context) => JavascriptChannel(
      name: 'show_flutter_toast',
      onMessageReceived: (JavascriptMessage message) {
        print("get message from JS, message is: ${message.message}");
      });

  /// 加载本地 HTML 文件
  Future<String> _loadHtmlFile() async {
    return await rootBundle.loadString(widget.loadUrl);
  }
}

