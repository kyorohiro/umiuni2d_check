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
    Color textColor = const Color.fromARGB(0xaa, 0xff, 0xaa, 0xaa);
    //TextStyle textStyle = new TextStyle(fontSize: 50.0, color: textColor);
    TextStyle textStyle = new TextStyle(
      fontFamily: "Aclonica",
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
      color: textColor
    );
    TextSpan testStyledSpan = new TextSpan(
      text:"Hello Text!! こんにちは!!\naa",
      style:textStyle);
    TextPainter textPainter = new TextPainter(text:
      testStyledSpan);

    textPainter.layout(minWidth: 200.0, maxWidth: 200.0);

    print("(w, t) : (${textPainter.width}, ${textPainter.height})");

    textPainter.paint(context.canvas, new sky.Offset(100.0, 100.0));
  }
}
