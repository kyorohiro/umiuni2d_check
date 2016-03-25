// following code is checked in 2016/03/16

import 'package:flutter/rendering.dart';
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
  Map<int, TouchInfo> touchInfos = {};

  DemoObject() : super(additionalConstraints: const BoxConstraints.expand()) {
    ;
  }
  @override
  bool hitTestSelf(Point position) => true;

  @override
  void handleEvent(PointerEvent event, BoxHitTestEntry entry) {
    if (!attached) {
      return;
    }

    if (entry is BoxHitTestEntry) {
      if (event is PointerDownEvent) {
        touchInfos[event.pointer] = new TouchInfo();
        touchInfos[event.pointer].x = entry.localPosition.x;
        touchInfos[event.pointer].y = entry.localPosition.y;
        touchInfos[event.pointer].pressure = event.pressure / event.pressureMax;
        print("${event.pressure} / ${event.pressureMax}");
        touchInfos[event.pointer].isTouch = true;
      } else if (event is PointerMoveEvent) {
        touchInfos[event.pointer].x = event.position.x;
        touchInfos[event.pointer].y = event.position.y;
        touchInfos[event.pointer].pressure = event.pressure / event.pressureMax;
      } else if (event is PointerUpEvent) {
        touchInfos[event.pointer].x = event.position.x;
        touchInfos[event.pointer].y = event.position.y;
        touchInfos[event.pointer].isTouch = false;
      } else if (event is PointerCancelEvent) {
        print("pointer cancel");
      }
      markNeedsPaint();
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    Paint p = new Paint();
    for (TouchInfo t in touchInfos.values) {
      if (t.isTouch) {
        p.color = new Color.fromARGB(0xff, 0xff, 0xff, 0xff);
        double size = 100 * t.pressure;
        Rect r = new Rect.fromLTWH(t.x - size / 2, t.y - size / 2, size, size);
        context.canvas.drawRect(r, p);
      }
    }
  }
}

class TouchInfo {
  double x = 0.0;
  double y = 0.0;
  double pressure = 0.0;
  bool isTouch = false;
}
