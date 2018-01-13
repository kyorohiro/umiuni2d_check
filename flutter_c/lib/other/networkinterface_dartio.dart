// check 2018 1/13
import 'package:flutter/widgets.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';

main() async {
  runApp( new Directionality(
      textDirection: TextDirection.ltr,
      child: new Center (
          child: new Text("Hello World",
              style: new TextStyle(color:new Color.fromARGB(0xff,0xff,0xff,0xff)))
      )
  ));
  //
  try {
    // 2015/10/16
    // begining of crash
    // 2016-
    //   android not support
    print("[B ok] ${await getNetworkInterface()}");
  } catch (e) {
    print("[B error] ${e}");
  }
}

Future<String> getNetworkInterface() async {
  List<NetworkInterface> interfaces = await NetworkInterface.list(
      includeLoopback: true, includeLinkLocal: true);
  StringBuffer buffer = new StringBuffer();
  for (NetworkInterface i in interfaces) {
    buffer.write("${i.addresses} ${i.name}");
  }
  return buffer.toString();
}
