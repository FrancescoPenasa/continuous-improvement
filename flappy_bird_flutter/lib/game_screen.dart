import 'dart:async' hide Timer;
import 'dart:collection';
import 'dart:math';

import 'package:flame/timer.dart' as FlameTimer;

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
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
        body: GameWidget(game: MyGame(onExit: () { Navigator.pop(context);} ,)));
  }
}

enum GameState { pause, play }

class MyGame extends FlameGame with TapCallbacks, HasCollisionDetection {
  final VoidCallback onExit;

  late GameState gameState;
  late Player player;
  late Ground ground;
  late MyParallaxComponent background;
  late Queue<PipePair> pipe_pairs;
  late TextComponent scoreComponent;
  late FlameTimer.Timer timer; // flame timer
  int score = 0;

  MyGame({required this.onExit})
      : super(
    camera: CameraComponent.withFixedResolution(
      width: 640,
      height: 480,
    ),
  );


  @override
  FutureOr<void> onLoad() async {
    gameState = GameState.play;
    debugMode = true;

    // init game objects
    // ground = Ground(position: Vector2(-size.x/2, size.y/2-20), size: Vector2(size.x, 20.0));
    player =
        Player(position: Vector2(-size.x / 2 + 100, 0), size: Vector2(64, 64));
    // pipe_pairs.add(PipePair(position: Vector2(size.x/2, Random().nextInt(240) - 120.0 ))); // between 120 and -120
    background = MyParallaxComponent(position: -size / 2, size: size);

    // Adds the component to world
    // world.add(RectangleComponent(position: -size/2, anchor: Anchor.topLeft, size: size));

    world.add(background);
    // world.add(ground);
    world.add(player);

    pipe_pairs = Queue();
    world.addAll(pipe_pairs);

    // camera.viewport.position = Vector2(600, 0);
    timer = FlameTimer.Timer(1.2, onTick: () {
      // player.jump();
      PipePair pp = PipePair(
          position: Vector2(size.x / 2, Random().nextInt(240) - 120.0));

      world.add(pp);
      pipe_pairs.add(pp);

      // performance enhancement
      if (pipe_pairs.length > 3) {
        world.remove(pipe_pairs.removeFirst());
      }

      // world.addAll(pipe_pairs);
    }, repeat: true);


    // SCORE
    scoreComponent = TextComponent(
      text: 'Score $score',
      position: Vector2(-size.x / 2 + 10.0, -size.y / 2 + 10.0),
    );
    world.add(scoreComponent);

    return super.onLoad();
  }


  @override
  void update(double dt) {
    if (gameState == GameState.play) {
      timer.update(dt);


      if (pipe_pairs.isNotEmpty && !pipe_pairs.first.isScored &&
          pipe_pairs.first.topPipe.position.x <= player.position.x) {
        pipe_pairs.first.isScored = true;
        score += 1;
        scoreComponent.text = 'Score $score';
        world.add(scoreComponent);
      }

      final cameraY = camera.viewfinder.position.y;

      // final playerY = myPlayer.position.y;
    } else if (gameState == GameState.pause) {
      timer.pause();
    }

    super.update(dt);
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (gameState == GameState.play) {
      player.jump();
    } else if (gameState == GameState.pause) {
      gameState = GameState.play;
      onExit();
    }

    super.onTapDown(event);
  }

  void resetGame() {
    score = 0;
    scoreComponent.text = 'Score $score';
    pipe_pairs.forEach(world.remove);
    pipe_pairs.clear();
    player.position = Vector2(-size.x / 2 + 100, 0);
    // player.reset();
    gameState = GameState.play;
  }
}