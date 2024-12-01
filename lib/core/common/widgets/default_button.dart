import 'package:cep_finder/core/res/colours.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    required this.onPressed,
    required this.child,
    this.style,
    super.key,
  });

  final void Function()? onPressed;
  final Widget child;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

      onPressed: onPressed,
      style: style ?? ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(15),
        backgroundColor: Colours.tealBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: child,
    );
  }
}
