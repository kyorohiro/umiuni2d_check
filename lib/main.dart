// check 2016 3/16
import 'package:flutter/widgets.dart';
import 'package:flutter/http.dart' as http;
import 'dart:async';
import 'dart:convert';

main() async {
  runApp(new Center(child: new Text("Hello!!")));
  // https unsupport
  try {
    print("#[A ok] #${await getTest('https://raw.githubusercontent.com/kyorohiro/hello_skyengine/master/SUMMARY.md')}");
  } catch (e) {
    print("#[A error] ${e}");
  }

  try {
    print("[B ok] ${await getTest('http://httpbin.org/get')}");
  } catch (e) {
    print("[B error] ${e}");
  }

  try {
    print("[C ok] ${await postTest('http://httpbin.org/post', "hello!!")}");
  } catch (e) {
    print("[C error] ${e}");
  }
}

Future<String> getTest(String uri) async {
  http.Response resp = await http.get(Uri.parse(uri));
  return resp.body;
}

Future<String> postTest(String uri, String message) async {
  http.Response resp = await http.post(Uri.parse(uri), body:message);
  return resp.body;
}
