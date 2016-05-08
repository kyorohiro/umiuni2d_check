// following code is checked in 2016/03/16
// flutter: ">=0.0.15"
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/services/path_provider.dart';
import 'dart:io';
import 'dart:async';

main() async {
  runApp(new Center(child: new Text("Hello!!")));
  await new Future.delayed(new Duration(seconds:1));


  Directory dd = await PathProvider.getApplicationDocumentsDirectory();
  Directory td = await PathProvider.getTemporaryDirectory();

  StringBuffer buffer = new StringBuffer();
  buffer.write("Directory.current = ${Directory.current} \n");
  buffer.write("Directory.systemTemp = ${Directory.systemTemp} \n");
  buffer.write("Directory.systemTemp = ${new Directory("./").absolute} \n");
  buffer.write("PathService.getAppDataDir = ${dd} \n");
  buffer.write("PathService.getCacheDir = ${td} \n");
  print("${buffer.toString()}");
}
