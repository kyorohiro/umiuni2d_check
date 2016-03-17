// check 2016 3/16
import 'package:flutter/widgets.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:test/test.dart' as test;
import 'dart:ui';

main() async {
  runApp(new DemoWidget());
  //await new Future.delayed(new Duration(seconds: 1));
  try {
    test.group("group", () {
      test.test("test 001", () {
        test.expect("A", "AI");
      });
    });
  } catch (e, t) {
    print("${e} ${t}");
  }
}

class DemoWidget extends SingleChildRenderObjectWidget {
  double angle = 0.0;
  DemoRectObject o = new DemoRectObject();

  @override
  RenderObject createRenderObject(BuildContext context) {
    return o;
  }
}

class DemoRectObject extends RenderConstrainedBox {
  double x = 50.0;
  double y = 50.0;
  DemoRectObject() : super(additionalConstraints: const BoxConstraints.expand()) {
    ;
  }

  @override
  bool hitTestSelf(Point position) => true;

  @override
  void handleEvent(PointerEvent event, BoxHitTestEntry entry) {}

  @override
  void paint(PaintingContext context, Offset offset) {}
}
