// check 2016 3/16
import 'package:flutter/widgets.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

void main() {
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
    Paint paint = new Paint();
    ui.VertexMode vertexMode = ui.VertexMode.triangles;
    List<Point> vertices = [
      new Point(0.0, 0.0),
      new Point(10.0, 50.0),
      new Point(50.0, 60.0)
    ];
    List<Point> textureCoordinates = [];
    List<Color> colors = [
      const Color.fromARGB(0xaa, 0xff, 0x00, 0x00),
      const Color.fromARGB(0xaa, 0x00, 0xff, 0x00),
      const Color.fromARGB(0xaa, 0x00, 0x00, 0xff)
    ];
    ui.TransferMode transferMode = ui.TransferMode.color;
    List<int> indicies = [0, 1, 2];
    context.canvas.drawVertices(vertexMode, vertices, textureCoordinates,
        colors, transferMode, indicies, paint);
  }
}
