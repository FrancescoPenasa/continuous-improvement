import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/sprite.dart';
import 'package:flappy_bird_flutter/assets_repository.dart';
import 'package:flutter/material.dart';

import '../game_screen.dart';

class Player extends SpriteAnimationComponent
    with HasGameRef<MyGame>, TapCallbacks {
  // Define animation states
  static const String IDLE = 'idle';
  static const String WALKING = 'walking';

  // Store our animations
  late Map<String, SpriteAnimation> animations;
  String currentAnimation = IDLE;

  // Movement properties
  Vector2 velocity = Vector2.zero();
  double moveSpeed = 200.0;
  bool isFacingLeft = false;


  Player({required Vector2 position, required Vector2 size})
      : super(position: position, size: size,);

  @override
  FutureOr<void> onLoad() async {
    // Load the sprite sheet image
    final spriteSheet =
        await gameRef.images.load(AssetsRepository.playerSprite);

    // Create sprite sheet
    final spriteSheetData = SpriteSheet(
      image: spriteSheet,
      srcSize: Vector2(32.0, 32.0),
    );

    // Create animations from sprite sheet
    animations = {
      IDLE: spriteSheetData.createAnimation(
        row: 0, // First row in sprite sheet
        stepTime: 0.2, // Time between frames
        to: 2, // Number of frames
      ),
      WALKING: spriteSheetData.createAnimation(
        row: 0, // Second row in sprite sheet
        stepTime: 0.1,
        to: 2,
      ),
    };

    // Set initial animation
    animation = animations[currentAnimation];

    // Set anchor to center for better rotation handling
    anchor = Anchor.center;
    super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    jump();
    super.onTapDown(event);
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Reset velocity
    velocity.x = 0;

    // Apply simple gravity
    velocity.y += 980 * dt; // Gravity constant

    // Update position based on velocity
    position += velocity * dt;

    // Simple ground collision
    if (position.y >= gameRef.size.y - size.y / 2) {
      position.y = gameRef.size.y - size.y / 2;
      velocity.y = 0;
    }

    // Keep character within screen bounds
    // position.x = position.x.clamp(
    //   size.x / 2,
    //   gameRef.size.x - size.x / 2,
    // );
  }

  @override
  void render(Canvas canvas) {
    // Apply debug rendering if needed
    if (gameRef.debugMode) {
      // Draw collision box
      canvas.drawRect(
        size.toRect(),
        Paint()
          ..color = const Color(0xFF00FF00)
          ..style = PaintingStyle.stroke,
      );

      // Draw direction indicator
      canvas.drawLine(
        Offset.zero,
        Offset(isFacingLeft ? -20 : 20, 0),
        Paint()
          ..color = const Color(0xFFFF0000)
          ..strokeWidth = 2,
      );
    }

    super.render(canvas);
  }

  void jump() {
    velocity.y = -400;
  }
}
