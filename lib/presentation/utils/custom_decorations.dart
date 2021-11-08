import 'package:flutter/material.dart';

class CustomDecorations {
  static BoxDecoration elevatedButtonBoxDecoration({Color? backgroundColor}) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: backgroundColor,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 10,
          offset: const Offset(3, 3),
        ),
      ],
    );
  }

  static BoxDecoration cardGradientDecoration({Color? backgroundColor}) {
    return BoxDecoration(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      color: backgroundColor,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 10,
          offset: const Offset(3, 3),
        ),
      ],
    );
  }

  static BoxDecoration modalCardGradientDecoration({Color? backgroundColor}) {
    return BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      color: backgroundColor,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 10,
          offset: const Offset(3, 3),
        ),
      ],
    );
  }
}
