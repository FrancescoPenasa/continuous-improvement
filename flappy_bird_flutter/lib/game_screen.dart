import 'dart:async' hide Timer;
import 'dart:collection';
import 'dart:math';

import 'package:flame/timer.dart' as FlameTimer;

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappy_bird_flutter/game/pipe.dart';
import 'package:flappy_bird_flutter/game/pipe_pair.dart';
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
    return Scaffold(
       appBar: AppBar(title: Text('test'),),
        body: GameWidget(game: MyGame(), ));
  }
}

class MyGame extends FlameGame with TapCallbacks {
  late Player player;
  late Ground ground;
  late MyParallaxComponent background;
  late Queue<PipePair> pipe_pairs;
  late FlameTimer.Timer timer; // flame timer

  MyGame()
      : super(
    camera: CameraComponent.withFixedResolution(
      width: 640,
      height: 480,
    ),
  );


  @override
  FutureOr<void> onLoad() async {
    pipe_pairs = Queue();
    // debugMode = true;

    // init game objects
    // ground = Ground(position: Vector2(-size.x/2, size.y/2-20), size: Vector2(size.x, 20.0));
    player = Player(position: Vector2(-size.x/2+100, 0), size: Vector2(64, 64));
    pipe_pairs.add(PipePair(position: Vector2(size.x/2, Random().nextInt(240) - 120.0 ))); // between 120 and -120
    background = MyParallaxComponent(position: -size/2, size: size);

    // Adds the component to world
    world.add(RectangleComponent(position: -size/2, anchor: Anchor.topLeft, size: size));

    world.add(background);
    // world.add(ground);
    world.add(player);

    world.addAll(pipe_pairs);

    // camera.viewport.position = Vector2(600, 0);
    timer = FlameTimer.Timer(1.2, onTick: () {
      // player.jump();
      PipePair pp = PipePair(position: Vector2(size.x/2, Random().nextInt(240) - 120.0 ));

      world.add(pp);
      pipe_pairs.add(pp);

      // performance enhancement
      if (pipe_pairs.length > 4) {
        world.remove(pipe_pairs.removeFirst());

      }

      // check if first collide, else if player x > first.x -> score + 1
      // world.addAll(pipe_pairs);
    }, repeat: true);


    return super.onLoad();
  }


  @override
  void update(double dt) {
    timer.update(dt);
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
