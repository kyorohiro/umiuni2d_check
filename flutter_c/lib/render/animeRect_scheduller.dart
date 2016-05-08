// following code is checked in 2016/03/16
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'dart:math' as math;
import 'dart:async';

void main() {
  runApp(new DemoWidget()..anime());
}

class DemoWidget extends SingleChildRenderObjectWidget {
  double angle = 0.0;
  DemoRectObject o = new DemoRectObject();
  @override
  RenderObject createRenderObject(BuildContext context) {
    return o;
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
      o.x = 100 * math.cos(math.PI * angle / 180.0) + 100.0;
      o.y = 100 * math.sin(math.PI * angle / 180.0) + 100.0;
      angle++;
      o.markNeedsPaint();
      anime();
    });
  }
}

class DemoRectObject extends RenderConstrainedBox {
  double x = 50.0;
  double y = 50.0;
  DemoRectObject() : super(additionalConstraints: const BoxConstraints.expand()) {;
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
