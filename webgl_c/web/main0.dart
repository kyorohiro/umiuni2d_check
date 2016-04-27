// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html' as html;
import 'dart:web_gl' as gl;
import 'dart:typed_data' as data;

List<String> vertexShaderSrc = [
  "attribute vec3 vertexPosition;",
  "attribute vec4 color;",
  "varying vec4 vColor;",
  "void main() {",
  "  vColor = color;",
  "  gl_Position = vec4(vertexPosition, 1.0);"
  "}"
];

List<String> fragmentShaderSrc = [
  "precision mediump float;",
  "varying vec4 vColor",
  "void main() {",
  "gl_FragColor = vColor;",
  "}"
];
void main() {
  html.CanvasElement canvas = new html.CanvasElement(width:150,height:150);
  html.document.body.append(canvas);

  //
  gl.RenderingContext ctx = canvas.getContext3d();
  ctx.viewport(0, 0, canvas.width, canvas.height);
  ctx.colorMask(true, true, true, true);
  ctx.clearColor(1.0, 0.8, 0.8, 1.0);
  ctx.clear(gl.RenderingContext.COLOR_BUFFER_BIT);

  gl.Shader vs = ctx.createShader(gl.VERTEX_SHADER);
  ctx.shaderSource(vs, vertexShaderSrc.join("\n"));
  ctx.compileShader(vs);

  var isVSOK = ctx.getShaderParameter(vs, gl.COMPILE_STATUS);
  if(false == isVSOK) {
    throw new Exception("Failed to compile vs: ${ctx.getShaderInfoLog(vs)}");
  }
}
