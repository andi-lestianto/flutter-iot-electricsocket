import 'package:flutter/cupertino.dart';

class FontTheme {
  static const TextStyle base = TextStyle(fontFamily: 'Poppins');

  static TextStyle thin = base.copyWith(fontWeight: FontWeight.w100);
  static TextStyle thinItalic =
      base.copyWith(fontWeight: FontWeight.w100, fontStyle: FontStyle.italic);

  static TextStyle extraLight = base.copyWith(fontWeight: FontWeight.w200);
  static TextStyle extraLightItalic =
      base.copyWith(fontWeight: FontWeight.w200, fontStyle: FontStyle.italic);

  static TextStyle light = base.copyWith(fontWeight: FontWeight.w300);
  static TextStyle lightItalic =
      base.copyWith(fontWeight: FontWeight.w300, fontStyle: FontStyle.italic);

  static TextStyle regular = base.copyWith(fontWeight: FontWeight.w400);
  static TextStyle italic =
      base.copyWith(fontWeight: FontWeight.w400, fontStyle: FontStyle.italic);

  static TextStyle medium = base.copyWith(fontWeight: FontWeight.w500);
  static TextStyle mediumItalic =
      base.copyWith(fontWeight: FontWeight.w500, fontStyle: FontStyle.italic);

  static TextStyle semibold = base.copyWith(fontWeight: FontWeight.w600);
  static TextStyle semiboldItalic =
      base.copyWith(fontWeight: FontWeight.w600, fontStyle: FontStyle.italic);

  static TextStyle bold = base.copyWith(fontWeight: FontWeight.w700);
  static TextStyle boldItalic =
      base.copyWith(fontWeight: FontWeight.w700, fontStyle: FontStyle.italic);

  static TextStyle extrabold = base.copyWith(fontWeight: FontWeight.w800);
  static TextStyle extraboldItalic =
      base.copyWith(fontWeight: FontWeight.w800, fontStyle: FontStyle.italic);

  static TextStyle black = base.copyWith(fontWeight: FontWeight.w900);
  static TextStyle blackItalic =
      base.copyWith(fontWeight: FontWeight.w900, fontStyle: FontStyle.italic);
}
