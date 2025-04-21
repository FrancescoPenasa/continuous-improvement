import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';

import '../game_screen.dart';

class Pipe extends SpriteComponent with HasGameRef<MyGame> {
  Pipe({required Vector2 position, required Vector2 size, required this.rotated})
      : super(position: position, size: size,);

  final bool rotated;

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load('pipe.png');

    if (rotated) {
      angle = angle + pi;
      scale.x = -scale.x;
    }
    super.onLoad();
  }
  //
  // @override
  // Future<void> update(double dt) async {
  //   super.update(dt);
  // }
}
