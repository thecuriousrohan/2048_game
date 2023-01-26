import 'package:game_2048/enums/movingDirection.dart';
import 'package:game_2048/game.dart';
import 'package:game_2048/shared/gameColors.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/input.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/painting.dart';

class GameButton extends PositionComponent with Tappable, HasGameRef<Game2048> {
  final Paint paint = Paint()..color = bgColor;
  MovingDirection mergingDirection;
  String assetLocation;
  Vector2 spriteSize;
  late Sprite sprite;
  late SpriteComponent buttonSpriteComponent;
  GameButton(
      {required Vector2 position,
      required Vector2 size,
      required this.spriteSize,
      required this.mergingDirection,
      required this.assetLocation})
      : super(position: position, size: size, anchor: Anchor.center);

  @override
  void render(Canvas canvas) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
            center: Offset(width * .5, height * .5),
            width: width,
            height: height),
        Radius.circular(10),
      ),
      paint,
    );
    return super.render(canvas);
  }

  @override
  bool onTapDown(TapDownInfo info) {
    gameRef.gameModel.merge(mergingDirection: this.mergingDirection);
    return super.onTapDown(info);
  }

  @override
  Future<void>? onLoad() async {
    sprite = await Sprite.load(assetLocation);
    buttonSpriteComponent = SpriteComponent(sprite: sprite, size: spriteSize);
    buttonSpriteComponent.anchor = Anchor.center;
    buttonSpriteComponent.position = this.size / 2;
    add(buttonSpriteComponent);
    return super.onLoad();
  }
}
