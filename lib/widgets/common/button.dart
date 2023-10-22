import 'package:flutter/material.dart';

import 'pressable.dart';

class Button extends StatefulWidget {
  Button({
    Key? key,
    this.color = Colors.blue,
    required this.onPressed,
    this.leading,
    required this.label,
  }) : super(key: key) {
    final hsl = HSLColor.fromColor(color);
    highlightColor =
        hsl.withLightness((hsl.lightness + 0.07).clamp(0, 1)).toColor();
  }

  final Color color;
  final VoidCallback onPressed;
  final Widget? leading;
  final Widget label;
  late final Color highlightColor;

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  var _hovering = false;

  onEnter(_) => setState(() => _hovering = true);
  onExit(_) => setState(() => _hovering = false);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: onEnter,
      onExit: onExit,
      child: Pressable(
        onPressed: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: _hovering ? widget.highlightColor : widget.color,
          ),
          padding: const EdgeInsets.all(15),
          child: Builder(builder: (context) {
            if (widget.leading == null) return widget.label;

            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                widget.leading!,
                const SizedBox(width: 10),
                widget.label,
              ],
            );
          }),
        ),
      ),
    );
  }
}
