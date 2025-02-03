import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../game_screen.dart';

class Ground extends SpriteComponent with HasGameRef<MyGame> {
  // static const String keyName = 'single_ground_key';

  Ground({required Vector2 position, required Vector2 size})
      : super(position: position, size: size,);
            // key: ComponentKey.named(keyName)

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load('ground.png');
    return super.onLoad();
  }



  @override
  void update(double dt) {
    super.update(dt);

    var a = 5;

  }

}
