// following code is checked in 2016/03/16
// flutter: ">=0.0.15"
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';

main() async {
  runApp(new Center(child: new Text("Hello!!")));
  await new Future.delayed(new Duration(seconds: 1));
  print("[--a---]");
  StringBuffer buffer = new StringBuffer("[--b---]\n");
  //try {
    buffer.write("Directory.current = ${Directory.current} \n");
  //} catch (e, t) {
  //  print("[e1] ${e} ${t}");
//  }

  try {
    buffer.write("Directory.systemTemp = ${Directory.systemTemp} \n");
  } catch (e, t) {
    print("[e2] ${e} ${t}");
  }
  try {
    buffer.write("Directory.systemTemp = ${new Directory("./").absolute} \n");
  } catch (e, t) {
    print("[e3] ${e} ${t}");
  }
  try {
    PathServiceProxy pathServiceProxy = new PathServiceProxy.unbound();
    shell.connectToService("dummy", pathServiceProxy);
    buffer.write("PathService.getAppDataDir = ${await pathServiceProxy.ptr.getAppDataDir()} \n");
    buffer.write("PathService.getCacheDir = ${await pathServiceProxy.ptr.getCacheDir()} \n");
    buffer.write("PathService.getFileDir = ${await pathServiceProxy.ptr.getFilesDir()} \n");
    pathServiceProxy.close();
  } catch (e, t) {
    print("[e4] ${e} ${t}");
  }
  print("${buffer.toString()}");
}
