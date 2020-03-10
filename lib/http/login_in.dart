
import 'dart:convert';
import 'dart:io';

import 'dart:typed_data';
//登录
class LoginInHandler{

  static Socket _socket;
  static Stream<Uint8List> _stream;

  static initSocket(String host,int port) async{
    await Socket.connect(host,port).then((Socket socket)  {
      _socket = socket;
      _stream = _socket.asBroadcastStream();      //多次订阅的流 如果直接用socket.listen只能订阅一次
    }).catchError((e) {
      print('connectException:$e');
      initSocket(host,port);
    });
  }

  static void dispos(){
    if(null != _socket){
      _socket.close();
    }
  }

  static request() async{
    //建立连接
//    var socket=await Socket.connect("baidu.com", 80);
//    //根据http协议，发送请求头
//    socket.writeln("GET / HTTP/1.1");
//    socket.writeln("Host:baidu.com");
//    socket.writeln("Connection:close");
//    socket.writeln();
//    await socket.flush(); //发送
//    //读取返回内容
//    String _response =await socket.transform(utf8.decoder).join();
//    print('socket : $_response');
//    await socket.close();
  }



}