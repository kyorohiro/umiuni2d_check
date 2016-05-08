// following code is checked in 2016/03/16

import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/http.dart' as http;
import 'dart:ui' as sky;

main() async {
  runApp(new DemoWidget());
}

class DemoWidget extends SingleChildRenderObjectWidget {
  @override
   RenderObject createRenderObject(BuildContext context) {
    return new DemoObject();
  }
}

class DemoObject extends RenderConstrainedBox {
  double x = 50.0;
  double y = 50.0;
  sky.Image image = null;

  loadImage() async {
    if (image == null) {
      image = await ImageLoader.load("https://avatars0.githubusercontent.com/u/1310669?v=3&s=460");
      this.markNeedsPaint();
    }
  }

  DemoObject() : super(additionalConstraints: const BoxConstraints.expand()) {
    ;
  }

  @override
  bool hitTestSelf(Point position) => true;

  @override
  void handleEvent(PointerEvent event, BoxHitTestEntry entry) {}

  @override
  void paint(PaintingContext context, Offset offset) {
    loadImage();
    Paint paint = new Paint()
      ..color = new Color.fromARGB(0xff, 0xff, 0xff, 0xff);
    Point point = new Point(x, y);
    if (image == null) {
      Rect rect = new Rect.fromLTWH(x, y, 50.0, 50.0);
      context.canvas.drawRect(rect, paint);
    } else {
      context.canvas.drawImage(image, point, paint);
    }
  }
}

class ImageLoader {
  static Future<sky.Image> load(String url) async {
    http.Response response = await http.get(url);
    if (response.body == null) {
      throw {"message":"failed to load ${url}"};
    } else {
      // normally use following
      // import 'package:flutter/services.dart';
      // Future<ui.Image> decodeImageFromDataPipe(MojoDataPipeConsumer consumerHandle)
      // Future<ui.Image> decodeImageFromList(Uint8List list) {
      Completer<sky.Image> completer = new Completer();
      sky.decodeImageFromList(response.bodyBytes,(sky.Image image) {
        completer.complete(image);
      });
      return completer.future;
    }
  }
}
