
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:logging/logging.dart';

final log = Logger('main.dart');

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(game: MyGame());
  }
}

class MyGame extends FlameGame with TapCallbacks {
  late Player myComponent;

  @override
  Color backgroundColor() => Colors.redAccent;

  @override
  Future<void> onLoad() async {
    super.onLoad();
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    log.info("size changed ${size.length}");
  }

  @override
  void onMount() {
    super.onMount();
    add(myComponent = Player());
  }

  @override
  void onTapDown(TapDownEvent event) {
    myComponent.jump();
    super.onTapDown(event);
  }

}


class Player extends PositionComponent  {
  final Vector2 _velocity = Vector2(0.0, 20.0);
  final _gravity = 60.0;
  final _jump = 220.0;


  // called only once
  @override
  void onLoad() {
    log.info("onload()");

    super.onLoad();
  }

  // called each time mounted
  @override
  void onMount() {
    log.info("onmount");
    position = Vector2(100,150);

    super.onMount();
  }

  // called each time removed
  @override
  void onRemove() {
    log.info("onremove");

    super.onRemove();
  }


  void jump() {
    _velocity.y += -_jump;
  }

  //  called every frame
  @override
  void update(double dt) {
    log.info("update");
    position += _velocity*dt;
    _velocity.y += _gravity*dt;

    super.update(dt);
  }

  // called every frame
  @override
  void render(Canvas canvas) {
    log.info("render");

    canvas.drawCircle(position.toOffset(), 15, Paint()..color = Colors.yellow);
    super.render(canvas);
  }
}