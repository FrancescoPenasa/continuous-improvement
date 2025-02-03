import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/cupertino.dart';

import '../game_screen.dart';

class MyParallaxComponent extends ParallaxComponent<MyGame>
    with HasGameRef<MyGame> {
  MyParallaxComponent({required Vector2 position, required Vector2 size})
      : super(position: position, size: size);

  @override
  Future<void> onLoad() async {
    parallax = await gameRef.loadParallax([
      ParallaxImageData('forest_moon.png'),
      ParallaxImageData('forest_sky.png'),
      ParallaxImageData('forest_mountain.png'),
      ParallaxImageData('forest_back.png'),
      ParallaxImageData('forest_mid.png'),
      ParallaxImageData('forest_long.png'),
    ],
      baseVelocity: Vector2(20, 0),
      velocityMultiplierDelta: Vector2(1.8, 1.0)
    );

    // final bgLayer = await gameRef.loadParallaxLayer(
    //     ParallaxImageData('background.png'),
    //     filterQuality: FilterQuality.none,
    //     alignment: Alignment.center);
    // final groundLayer = await gameRef.loadParallaxLayer(
    //   ParallaxImageData('ground.png'),
    //   filterQuality: FilterQuality.none,
    //   alignment: Alignment.bottomLeft,
    //   fill: LayerFill.width,
    // );
    // parallax = Parallax(
    //   [bgLayer, groundLayer],
    //   baseVelocity: Vector2(20, 0),
    // );
  }
}
