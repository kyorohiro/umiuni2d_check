// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html' as html;
import 'tinyutil_webgl.dart' as ace;
import 'dart:js' as js;

void main() {
  html.CanvasElement newChild = new html.CanvasElement(width:150,height:150);
  html.document.body.append(newChild);


  html.CanvasRenderingContext2D context =
  ace.CanvasElementText.resetCanvasImage(
    fontsize: 25,
    fontStyle: "bold",
    fontFamily: "Aclonica",
    color: "rgb(2,169,159)",
    height: 300,
    width: 300,
    canvasElm: newChild);
  js.JsObject o = new js.JsObject.fromBrowserObject(newChild);
  js.JsObject c = o.callMethod("getContext",["2d"]);
  js.JsObject m = c.callMethod("measureText",["abc"]);
  print(">>>##>>> ${m} ${m['emHeightAscent']}");

//  newChild. JsObject.fromBrowserObject

  ace.TextLines a = new ace.TextLines.fromContext2D(context, "ABC", 399, 25);
  for(String t in a.texts) {
    context.fillText("ABC", a.height, a.height);
  }

///  context.arc(x, y, radius, startAngle, endAngle)
}
