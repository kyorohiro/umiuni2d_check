// check 2016 3/16
import 'package:flutter/widgets.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';

main() async {
  runApp(new Center(child: new Text("Hello!!")));
  //
  try {
    // 2015/10/16
    // begining of crash
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
