// following code is checked in 2016/03/16

import 'dart:async';
import 'dart:ui' as sky;

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

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
      image = await ImageLoader.load("assets/sample.jpeg");
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
    Paint paint = new Paint()..color = new Color.fromARGB(0xff, 0xff, 0xff, 0xff);
    if (image == null) {
      Rect rect = new Rect.fromLTWH(x, y, 50.0, 50.0);
      context.canvas.drawRect(rect, paint);
      return;
    }
    context.canvas.setMatrix(new Matrix4.identity().storage);
    context.canvas.translate(10.0, 10.0);
    for (int i = 0; i < 3; i++) {
      context.canvas.translate(x + 5, y + 5);
      context.canvas.rotate(0.3);
      context.canvas.scale(0.5, 0.5);
      context.canvas.drawImage(image, new Point(0.0, 0.0), paint);
    }
    context.canvas.setMatrix(new Matrix4.identity().storage);
    context.canvas.translate(10.0, 400.0);
    for (int i = 0; i < 3; i++) {
      context.canvas.translate(x - 5, y - 5);
      context.canvas.rotate(-0.3);
      context.canvas.scale(0.5, 0.5);
      context.canvas.drawImage(image, new Point(0.0, 0.0), paint);
    }
  }
}

class ImageLoader {
  static AssetBundle getAssetBundle() => (rootBundle != null)
      ? rootBundle
      : new NetworkAssetBundle(new Uri.directory(Uri.base.origin));


  static Future<sky.Image> load(String url) async {
    ImageStream stream = new AssetImage(url, bundle: getAssetBundle()).resolve(ImageConfiguration.empty);
    Completer<sky.Image> completer = new Completer<sky.Image>();
    void listener(ImageInfo frame) {
      final sky.Image image = frame.image;
      completer.complete(image);
      stream.removeListener(listener);
    }
    stream.addListener(listener);
    return completer.future;
  }
}
