// check 2016 3/16
import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'dart:typed_data';

ui.Image img = null;
main() async{
  img = await ImageLoader.load("assets/sample.png");
  runApp(new DemoWidget());
}

class DemoWidget extends SingleChildRenderObjectWidget {
  @override
  RenderObject createRenderObject(BuildContext context) {
    return new DemoObject();
  }
}

class DemoObject extends RenderConstrainedBox {
  DemoObject() : super(additionalConstraints: const BoxConstraints.expand()) {
    ;
  }

  @override
  bool hitTestSelf(Point position) => true;

  @override
  void handleEvent(PointerEvent event, BoxHitTestEntry entry) {}
  @override
  void paint(PaintingContext context, Offset offset) {

       context.canvas.translate(50.0, 50.0);
       context.canvas.scale(8.0, 8.0);
       paintWithImage(context, offset);
     }

     void paintWithImage(PaintingContext context, Offset offset) {
       Paint paint = new Paint();
       ui.VertexMode vertexMode = ui.VertexMode.triangleFan;
       List<Point> vertices = [
         new Point(0.0, 0.0),
         new Point(10.0, 50.0),
         new Point(50.0, 60.0),
         new Point(40.0, 10.0)
       ];
       List<Point> textureCoordinates = [
         new Point(0.0, 0.0),
         new Point(0.0, 1.0 * img.height),
         new Point(1.0 * img.width, 1.0 * img.height),
         new Point(1.0 * img.width, 0.0)
       ];
       List<Color> colors = [
         const Color.fromARGB(0xaa, 0x00, 0x00, 0xff),
         const Color.fromARGB(0xaa, 0x00, 0x00, 0xff),
         const Color.fromARGB(0xaa, 0x00, 0x00, 0xff),
         const Color.fromARGB(0xaa, 0x00, 0x00, 0xff)
       ];
       ui.TransferMode transferMode = ui.TransferMode.color;
       ui.TileMode tmx = ui.TileMode.clamp;
       ui.TileMode tmy = ui.TileMode.clamp;
       Float64List matrix4 = new Matrix4.identity().storage;
       ui.ImageShader imgShader = new ui.ImageShader(img, tmx, tmy, matrix4);
       paint.shader = imgShader;
       List<int> indicies = [0, 1, 2, 3];
       context.canvas.drawVertices(vertexMode, vertices, textureCoordinates,
           colors, transferMode, indicies, paint);
     }
}

class ImageLoader {
  static AssetBundle getAssetBundle() => (rootBundle != null)
      ? rootBundle
      : new NetworkAssetBundle(new Uri.directory(Uri.base.origin));


  static Future<ui.Image> load(String url) async {
    ImageStream stream = new AssetImage(url, bundle: getAssetBundle()).resolve(ImageConfiguration.empty);
    Completer<ui.Image> completer = new Completer<ui.Image>();
    void listener(ImageInfo frame) {
      final ui.Image image = frame.image;
      completer.complete(image);
      stream.removeListener(listener);
    }
    stream.addListener(listener);
    return completer.future;
  }
}
