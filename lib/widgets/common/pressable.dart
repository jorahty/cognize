import 'package:flutter/material.dart';

class Pressable extends StatefulWidget {
  const Pressable({
    super.key,
    required this.onPressed,
    required this.child,
  });

  final VoidCallback onPressed;
  final Widget child;

  @override
  State<Pressable> createState() => _PressableState();
}

class _PressableState extends State<Pressable> {
  bool isPressed = false;

  onTapCancel() => setState(() => isPressed = false);
  onTapDown() => setState(() => isPressed = true);
  onTapUp() {
    setState(() {
      widget.onPressed();
      isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTapCancel: () => onTapCancel(),
        onTapDown: (_) => onTapDown(),
        onTapUp: (_) => onTapUp(),
        child: AnimatedScale(
          duration: const Duration(milliseconds: 200),
          curve: const Cubic(0.175, 0.885, 0.32, 2),
          scale: isPressed ? 0.95 : 1,
          child: widget.child,
        ),
      ),
    );
  }
}
