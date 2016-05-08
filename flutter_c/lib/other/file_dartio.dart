//
// following code is checked in 2016/01/13
//

import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/src/services/path_provider.dart';

main() async {
  Text t = new Text("Hello");
  Center c = new Center(child: t);
  runApp(c);
  //
  PathProvider p;
  await new Future.delayed(new Duration(seconds: 3));

  print("-----001");
  StringBuffer buffer = new StringBuffer();

  Directory dir = await PathProvider.getApplicationDocumentsDirectory();
  print("-----002");

  //
  // create File
  print("###${dir.path}/dummy.txt");
  File f = new File("${dir.path}/dummy.txt");
  try {
    await f.create(recursive: true);
    RandomAccessFile rfile = await f.open(mode: FileMode.WRITE);
    await rfile.writeString("hello!!");
    rfile.close();
  } catch (e) {
    print("${e}");
  }

  // permission
  // https://github.com/dart-lang/sdk/issues/15078
  // https://github.com/dart-lang/sdk/issues/22036
  // (await f.stat()).mode = 777;
  Permission.chmod(777, f);

  // list
  await for (FileSystemEntity fse in dir.list()) {
    print("${fse} ${(await fse.stat()).modeString()} ${(await fse.stat()).modified}");
    buffer.write("${fse} ${(await fse.stat()).modeString()} ${(await fse.stat()).modified}\n");
  }

  print(buffer.toString());
}

class Permission {
  // http://stackoverflow.com/questions/27494933/create-write-a-file-which-is-having-execute-permission
  static chmod(int mode, File f) {
    ProcessResult result = Process.runSync("chmod", ["${mode}", "${f.absolute.path}"]);
    return result.exitCode;
  }
}
