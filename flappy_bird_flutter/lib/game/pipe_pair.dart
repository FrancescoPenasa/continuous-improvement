import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flappy_bird_flutter/game/pipe.dart';

import '../game_screen.dart';

/**
 * Contiene un paio di Pipe, per crearle mi servono larghezza altezza, spazio per l'uccello
 * position è relativa al centro, size ovviamente size e gap è lo spazio tra i due pipe
 */
class PipePair extends Component with HasGameRef<MyGame> {
  late final Pipe topPipe;
  late final Pipe bottomPipe;
  late final Vector2 position;
  late final double gap;
  late  bool isScored;
  final Vector2 size = Vector2(64, 320);


  PipePair({required this.position, Vector2? size, this.gap = 100});
      // : super(position: this.position, size: this.size,);

  @override
  FutureOr<void> onLoad() {
    isScored = false;
    topPipe = Pipe(
        position: Vector2(position.x, position.y - gap/2 ),
        size: size,
        rotated: true);

    bottomPipe = Pipe(
        position: Vector2(position.x, position.y + gap/2),
        size: size,
        rotated: false);

    add(topPipe);
    add(bottomPipe);

    return super.onLoad();
  }


  @override
  Future<void> update(double dt) async {
    topPipe.position = Vector2(topPipe.position.x - 200 *dt, topPipe.position.y);
    bottomPipe.position = Vector2(bottomPipe.position.x - 200 *dt, bottomPipe.position.y);

    super.update(dt);
  }
}
