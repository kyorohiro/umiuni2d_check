// check 2018 1/13
import 'package:flutter/widgets.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:test/test.dart' as test;

main() async {
  runApp( new Directionality(
      textDirection: TextDirection.ltr,
      child: new Center (
          child: new Text("Hello World",
              style: new TextStyle(color:new Color.fromARGB(0xff,0xff,0xff,0xff)))
      )
  ));
  //await new Future.delayed(new Duration(seconds: 1));
  try {
    test.group("group", () {
      test.test("test 001", () {
        test.expect("A", "AI");
      });
    });
  } catch (e, t) {
    print("${e} ${t}");
  }
}
