import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Size get size => mediaQuery.size;
  double get width => size.width;
  double get height => size.height;
}

extension CepFormatter on String {
  String toCepFormat() {
    String sanitized = this.replaceAll(RegExp(r'[^0-9]'), '');
    if (sanitized.length == 8) {
      return '${sanitized.substring(0, 5)}-${sanitized.substring(5)}';
    }
    return this;
  }
}
