// following code is checked in 2016/03/16

import 'dart:async';
import 'package:mojo/core.dart';
import 'package:sky_services/media/media.mojom.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

main() async {
  runApp(new Center(child: new Text("Sound Test")));
  MojoDataPipeConsumer data =
      await ResouceLoader.load("assets/bgm_maoudamashii_acoustic09.mp3");
  SoundTest test = new SoundTest(data);
  await test.init();
  await test.play();
  await new Future.delayed(new Duration(seconds:5));
  await test.pause();
  await new Future.delayed(new Duration(seconds:5));
  await test.play();
}

class SoundTest {
  MojoDataPipeConsumer data;
  SoundTest(this.data) {;}

  MediaServiceProxy service = new MediaServiceProxy.unbound();
  MediaPlayerProxy player = new MediaPlayerProxy.unbound();

  init() async {
    service = shell.connectToApplicationService(
      'mojo:media_service', MediaService.connectToService
    );
    service.createPlayer(player);
    Completer c = new Completer();
    player.prepare(data,(bool ignored) {
      //
      c.complete("");
    });
    await c.future;
  }

  play() async {
    print("start play");
    player.seekTo(0);
    player.start();
    print("/start play");
  }

  pause() async {
    player.pause();
  }
}


class ResouceLoader {
  static AssetBundle getAssetBundle() => (rootBundle != null) ? rootBundle : new NetworkAssetBundle(new Uri.directory(Uri.base.origin));

  static Future<MojoDataPipeConsumer> load(String url) async {
    AssetBundle bundle = getAssetBundle();
    return await bundle.load(url);
  }
}
