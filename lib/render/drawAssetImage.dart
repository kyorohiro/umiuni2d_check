// following code is checked in 2016/03/16

import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:ui' as sky;

main() async {
  runApp(new DemoWidget());
}

AssetBundle getAssetBundle() =>
  (rootBundle != null)? rootBundle:new NetworkAssetBundle(new Uri.directory(Uri.base.origin));


class ImageLoader {
  static Future<sky.Image> load(String url) async {
    AssetBundle bundle = getAssetBundle();
    ImageResource resource = bundle.loadImage(url);
    ImageInfo imgaeinfo = await resource.first;
    return imgaeinfo.image;
  }
}

class DemoWidget extends SingleChildRenderObjectWidget {
  @override
  RenderObject createRenderObject(BuildContext context) {
    return new DrawImageObject();
  }
}

class DrawImageObject extends RenderConstrainedBox {
  double x = 50.0;
  double y = 50.0;
  sky.Image image = null;

  void loadImage() {
    if (image == null) {
      ImageLoader.load("assets/sample.jpeg").then((sky.Image img) {
        image = img;
        this.markNeedsPaint();
      });
    }
  }

  @override
  bool hitTestSelf(Point position) => true;

  @override
  void handleEvent(PointerEvent event, BoxHitTestEntry entry) {}
  @override
  void paint(PaintingContext context, Offset offset) {
    loadImage();
    Paint paint = new Paint()..color = new Color.fromARGB(0xff, 0xff, 0xff, 0xff);
    Point point = new Point(x, y);
    if (image == null) {
      Rect rect = new Rect.fromLTWH(x, y, 50.0, 50.0);
      context.canvas.drawRect(rect, paint);
    } else {
      context.canvas.drawImage(image, point, paint);
    }
  }
}