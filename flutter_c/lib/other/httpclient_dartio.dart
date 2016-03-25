// check 2016 3/16
import 'package:flutter/widgets.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';

main() async {
  runApp(new Center(child: new Text("Hello!!")));
  // https unsupport
  try {
    //
    // 2015/10/16
    //
    // ANDROID: I/sky     : Invalid argument(s): Secure Sockets unsupported on this platform
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
    print("[B ok] ${await postTest('http://httpbin.org/post', "hello!!")}");
  } catch (e) {
    print("[B error] ${e}");
  }
}

Future<String> getTest(String uri) async {
  HttpClient client = new HttpClient();
  HttpClientRequest request = await client.getUrl(Uri.parse(uri));
  HttpClientResponse response = await request.close();
  StringBuffer builder = new StringBuffer();
  await for (String a in await response.transform(UTF8.decoder)) {
    builder.write(a);
  }
  return builder.toString();
}

Future<String> postTest(String uri, String message) async {
  HttpClient client = new HttpClient();
  HttpClientRequest request = await client.postUrl(Uri.parse(uri));
  request.write(message);
  HttpClientResponse response = await request.close();
  StringBuffer builder = new StringBuffer();
  await for (String a in await response.transform(UTF8.decoder)) {
    builder.write(a);
  }
  return builder.toString();
}
