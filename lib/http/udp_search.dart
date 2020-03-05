import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

//UDP 广播搜索--在判断wifi连接的前提下
class UdpSearch{
  VoidCallback _callback;
  String _mIp;
  Utf8Codec _utf8codec;
  RawDatagramSocket _udpSocket;

  void sendData(var sendData){
    //进行配置文件读取
    int port = 8080;
    init("", port);
    if(null == _udpSocket || null == sendData || _mIp.isEmpty){
      throw new Exception("udp 初始化失败 ");
    }
    var jsonData = jsonEncode(sendData);
    var dataToSend = _utf8codec.encode(jsonData);
    _udpSocket.send(dataToSend, new InternetAddress(_mIp), port);
    print("Did send data on the stream");
  }

  void init(String host,int port){
    if(host.isEmpty){
      throw new Exception("域名不能为空！");
    }
    var listAddr = InternetAddress.lookup(host);
    listAddr.then((list){
      list.forEach((addr){
        _mIp = addr.address;
      });
    });
    _utf8codec = new Utf8Codec();
    _initUdp(port);
  }

  //udp初始化
  _initUdp(int port){
    if(port == 0){
      throw new Exception("端口号不能为0");
    }
    var addressesIListenForm = InternetAddress.anyIPv4;
    RawDatagramSocket.bind(addressesIListenForm, port)
        .then((RawDatagramSocket udpSocket){
      _udpSocket = udpSocket;
      _onReceiveData(udpSocket);
    });
  }

  //消息监听及消息发送
  _onReceiveData(RawDatagramSocket udpSocket){
    udpSocket.listen((RawSocketEvent event){
      if(event == RawSocketEvent.read){
        Datagram dg = udpSocket.receive();
        try{
          String res = _utf8codec.decode(dg.data);
          print("_onReceiveData : "+res);
        } catch(e){
          print(e);
        }
      }
    });
  }
}