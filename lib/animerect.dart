// check 2016 3/16
import 'package:flutter/widgets.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';
import 'dart:math' as math;
import 'dart:ui';

void main() {
  runApp(new DrawRectWidget()..anime());
}
class DrawRectWidget extends SingleChildRenderObjectWidget {
  double angle = 0.0;
  DrawRectObject o = new DrawRectObject();
  @override
  RenderObject createRenderObject(BuildContext context) {
    return o;
  }

  Future anime() async {
    while (true) {
      await new Future.delayed(new Duration(milliseconds: 20));
      o.x = 100 * math.cos(math.PI * angle / 180.0) + 100.0;
      o.y = 100 * math.sin(math.PI * angle / 180.0) + 100.0;
      angle++;
      o.markNeedsPaint();
    }
  }
}

class DrawRectObject extends RenderConstrainedBox {
  double x = 50.0;
  double y = 50.0;
  DrawRectObject() : super(additionalConstraints: const BoxConstraints.expand()) {
    ;
  }

  @override
  bool hitTestSelf(Point position) => true;

  @override
  void handleEvent(PointerEvent event, BoxHitTestEntry entry) {}
  @override
  void paint(PaintingContext context, Offset offset) {
    Paint p = new Paint();
    p.color = new Color.fromARGB(0xff, 0xff, 0xff, 0xff);
    Rect r = new Rect.fromLTWH(x, y, 25.0, 25.0);
    context.canvas.drawRect(r, p);
  }
}
