// check 2016 3/16
//  :: is not properly encoded on ios about japanese
import 'package:flutter/widgets.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as sky;

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
    context.canvas.scale(2.5, 2.5);
    context.canvas.translate(10.0, 10.0);
    paintWithStroke(context);
    context.canvas.translate(50.0, 0.0);
    paintWithLinearGradient(context);

    //
    //
    // ng case
    {
      context.canvas.translate(0.0, 50.0);
      clip(context);
      paintWithLinearGradient(context);
    }
  }

  void paintWithStroke(PaintingContext context) {
    Paint p = new Paint();
    p.strokeWidth = 2.0;
    p.style = sky.PaintingStyle.stroke;
    Path path = new Path();
    path.moveTo(0.0, 0.0);
    path.lineTo(10.0, 50.0);
    path.lineTo(50.0, 60.0);
    path.lineTo(40.0, 10.0);
    path.close();
    p.color = new Color.fromARGB(0xaa, 0xaa, 0xff, 0xff);
    context.canvas.drawPath(path, p);
  }

  void paintWithLinearGradient(PaintingContext context) {
    Paint p = new Paint();
    p.style = sky.PaintingStyle.strokeAndFill;
    p.shader = new sky.Gradient.linear([new sky.Point(0.0, 0.0), new sky.Point(50.0, 60.0)], [const Color.fromARGB(0xaa, 0xff, 0x00, 0x00), const Color.fromARGB(0xaa, 0x00, 0x00, 0x00), const Color.fromARGB(0xaa, 0x00, 0x00, 0xff),], [0.0, 0.5, 1.0], sky.TileMode.clamp);

    Path path = new Path();
    path.moveTo(0.0, 0.0);
    path.lineTo(10.0, 50.0);
    path.lineTo(50.0, 60.0);
    path.lineTo(40.0, 10.0);

    path.moveTo(10.0, 10.0);
    path.lineTo(30.0, 20.0);
    path.lineTo(40.0, 50.0);
    path.lineTo(20.0, 40.0);
    path.close();
    context.canvas.drawPath(path, p);
  }

  void clip(PaintingContext context) {
    Path path = new Path();
    path.moveTo(0.0, 0.0);
    path.lineTo(0.0, 25.0);
    path.lineTo(25.0, 25.0);
    path.lineTo(25.0, 0.0);
    path.close();
    context.canvas.clipPath(path);
//    context.canvas.clipRect(new Rect.fromLTWH(10.0, 10.0, 10.0, 10.0));
  }
}
