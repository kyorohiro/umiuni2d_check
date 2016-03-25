// following code is checked in 2016/03/16
// flutter: ">=0.0.15"
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:async';

main() async {
  runApp(new Center(child: new Text("Hello!!")));
  await new Future.delayed(new Duration(seconds:1));

  PathServiceProxy pathServiceProxy = new PathServiceProxy.unbound();
  shell.connectToService("dummy", pathServiceProxy);
  StringBuffer buffer = new StringBuffer();
  buffer.write("Directory.current = ${Directory.current} \n");
  buffer.write("Directory.systemTemp = ${Directory.systemTemp} \n");
  buffer.write("Directory.systemTemp = ${new Directory("./").absolute} \n");
  buffer.write("PathService.getAppDataDir = ${await pathServiceProxy.ptr.getAppDataDir()} \n");
  buffer.write("PathService.getCacheDir = ${await pathServiceProxy.ptr.getCacheDir()} \n");
  buffer.write("PathService.getFileDir = ${await pathServiceProxy.ptr.getFilesDir()} \n");
  pathServiceProxy.close();
  print("${buffer.toString()}");
}
