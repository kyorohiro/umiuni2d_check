// following code is checked in 2016/05/08
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as sky;
import 'dart:async';
import 'dart:typed_data';
import 'package:vector_math/vector_math_64.dart';
import 'package:flutter/scheduler.dart';
import 'dart:math' as math;

main() async {
  // "assets/icon.jpeg" is error 2015/12/13 's flutter, when draw image
  //img = await ImageLoader.load("assets/sample.jpeg");
  runApp(new DrawVertexsWidget());
}

class DrawVertexsWidget extends SingleChildRenderObjectWidget {
  double angle = 0.0;
  DrawVertexsObject o = new DrawVertexsObject();
  @override
  RenderObject createRenderObject(BuildContext context) {
    return o;
  }



}

class DrawVertexsObject extends RenderConstrainedBox {
  double x = 50.0;
  double y = 50.0;
  double angle = 1.0;
  DrawVertexsObject() : super(additionalConstraints: const BoxConstraints.expand()) {
    ;
  }
  bool loading = false;
  loadImage() async {
    if (loading == false) {
      loading =true;
      //image = await ImageLoader.load("assets/sample.jpeg");
      this.markNeedsPaint();
      anime();
    }
  }
  int prevTimeStamp = 0;
  void anime() {
    //
    // 2016/1/13 add following code
    //  Scheduller == null situation
    if(SchedulerBinding.instance == null) {
      new Future.delayed(new Duration(seconds: 1)).then((_){
        anime();
      });
      return;
    }

    //
    SchedulerBinding.instance.scheduleFrameCallback((Duration timeStamp) {
      print("${timeStamp.inMilliseconds-prevTimeStamp}");
      prevTimeStamp = timeStamp.inMilliseconds;
      angle+= 0.01;
      markNeedsPaint();
      anime();
    });
  }
  @override
  bool hitTestSelf(Point position) => true;

  @override
  void handleEvent(PointerEvent event, BoxHitTestEntry entry) {}

  @override
  void paint(PaintingContext context, Offset offset) {
    loadImage();
    //Paint paint = new Paint()..color = new Color.fromARGB(0xff, 0xff, 0xff, 0xff);
    //if (image == null) {
    //  Rect rect = new Rect.fromLTWH(x, y, 50.0, 50.0);
    //  context.canvas.drawRect(rect, paint);
    //} else {
      paintA(context, offset);
    //}
  }
  void paintA(PaintingContext context, Offset offset) {
    context.canvas.scale(4.0, 4.0);
    context.canvas.translate(80.0, 80.0);
    Matrix4 mat = new Matrix4.identity();
    mat.rotateY(math.PI / 2.0 + angle);
    mat.rotateX(angle);
    drawSurface(context, offset, mat);
    mat.rotateY(math.PI / 2.0);
    drawSurface(context, offset, mat);
    mat.rotateY(math.PI / 2.0);
    drawSurface(context, offset, mat);
    mat.rotateY(math.PI / 2.0);
    drawSurface(context, offset, mat);
    mat.rotateX(math.PI / 2.0);
    drawSurface(context, offset, mat);
    mat.rotateX(math.PI / 1.0);
    drawSurface(context, offset, mat);
  //    angle+= math.PI / 90.0;
  }

  void drawSurface(PaintingContext context, Offset offset, Matrix4 mat) {
    Paint paint = new Paint();
    sky.VertexMode vertexMode = sky.VertexMode.triangleFan;
    Vector3 vec1 = mat * new Vector3(-25.0, -25.0, -25.0);
    Vector3 vec2 = mat * new Vector3(-25.0, 25.0, -25.0);
    Vector3 vec3 = mat * new Vector3(25.0, 25.0, -25.0);
    Vector3 vec4 = mat * new Vector3(25.0, -25.0, -25.0);
    Vector3 normal = (vec1 - vec2).cross(vec1 - vec3);
    if (normal.z < 0) {
      return;
    }
    List<Point> vertices = [
      new Point(vec1.x, vec1.y),
      new Point(vec2.x, vec2.y),
      new Point(vec3.x, vec3.y),
      new Point(vec4.x, vec4.y)
    ];
    List<Point> textureCoordinates = [
      new Point(0.0, 0.0),
      new Point(0.0, 1.0),
      new Point(1.0, 1.0 ),
      new Point(1.0, 0.0)
    ];
    List<Color> colors = [
      const Color.fromARGB(0xaa, 0xff, 0xff, 0xff),
      const Color.fromARGB(0xaa, 0xff, 0xff, 0xff),
      const Color.fromARGB(0xaa, 0xff, 0xff, 0xff),
      const Color.fromARGB(0xaa, 0xff, 0xff, 0xff)
    ];
    sky.TransferMode transferMode = sky.TransferMode.color;
    //sky.TileMode tmx = sky.TileMode.clamp;
    //sky.TileMode tmy = sky.TileMode.clamp;
    //Float64List matrix4 = new Matrix4.identity().storage;
    //sky.ImageShader imgShader = new sky.ImageShader(image, tmx, tmy, matrix4);
    //paint.shader = imgShader;
    List<int> indicies = [0, 1, 2, 3];
    context.canvas.drawVertices(vertexMode, vertices, textureCoordinates,
        colors, transferMode, indicies, paint);
  }
}
/*
class ImageLoader {
  static AssetBundle getAssetBundle() => (rootBundle != null) ? rootBundle : new NetworkAssetBundle(new Uri.directory(Uri.base.origin));

  static Future<sky.Image> load(String url) async {
    AssetBundle bundle = getAssetBundle();
    ImageResource resource = bundle.loadImage(url);
    ImageInfo imgaeinfo = await resource.first;
    return imgaeinfo.image;
  }
}*/
