import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappy_bird_flutter/game/pipe.dart';
import 'package:flappy_bird_flutter/game/testing_parallax.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:logging/logging.dart';

import 'game/ground.dart';
import 'game/player.dart';

final log = Logger('main.dart');

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return GameWidget(game: MyGame(), );
  }
}

class MyGame extends FlameGame with TapCallbacks {
  late Player player;
  late Ground ground;
  late MyParallaxComponent background;
  late List<Pipe> pipes;

  MyGame()
      : super(
    camera: CameraComponent.withFixedResolution(
      width: 1280,
      height: 720,
    ),
  );


  @override
  FutureOr<void> onLoad() async {
    // debugMode = true;

    ground = Ground(position: Vector2(-size.x/2, size.y/2-20), size: Vector2(size.x, 20.0));
    player = Player(position: Vector2(-size.x/2+100, 0), size: Vector2(64, 64));
    pipes = [Pipe(position: Vector2(size.x/2, size.y/2 -320), size: Vector2(64, 320), rotated: false), Pipe(position: Vector2(size.x/2, -size.y/2 + 320), size: Vector2(64, 320), rotated: true)];
    background = MyParallaxComponent(position: -size/2, size: size);

    // Adds the component
    world.add(RectangleComponent(position: -size/2, anchor: Anchor.topLeft, size: size));

    world.add(background);
    world.add(ground);
    world.add(player);

    world.addAll(pipes);

    // camera.viewport.position = Vector2(600, 0);
    return super.onLoad();
  }


  @override
  void update(double dt) {
    final cameraY = camera.viewfinder.position.y;
    // final playerY = myPlayer.position.y;

    super.update(dt);
  }

  @override
  void onTapDown(TapDownEvent event) {
    player.jump();
    super.onTapDown(event);
  }
}
