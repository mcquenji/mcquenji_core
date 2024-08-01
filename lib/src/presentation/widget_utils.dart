import 'package:flutter/widgets.dart';

/// Provides a set of utility methods to work with spacing in a more expressive way.
/// e.g. `10.5.spacing` instead of `SizedBox(width: 10.5, height: 10.5)`
extension SpacingDoubleExt on double {
  /// Returns a [SizedBox] with the width and height set to this value.
  SizedBox get spacing => SizedBox(width: this, height: this);

  /// Returns a [SizedBox] with the width set to this value.
  SizedBox get hSpacing => SizedBox(width: this);

  /// Returns a [SizedBox] with the height set to this value.
  SizedBox get vSpacing => SizedBox(height: this);
}

/// Provides a set of utility methods to work with spacing in a more expressive way.
/// e.g. `10.spacing` instead of `SizedBox(width: 10, height: 10)`
extension SpacingIntExt on int {
  /// Returns a [SizedBox] with the width and height set to this value.
  SizedBox get spacing => SizedBox(width: toDouble(), height: toDouble());

  /// Returns a [SizedBox] with the width set to this value.
  SizedBox get hSpacing => SizedBox(width: toDouble());

  /// Returns a [SizedBox] with the height set to this value.
  SizedBox get vSpacing => SizedBox(height: toDouble());
}

/// Provides a set of utility methods to work with text in a more expressive way.
extension StringTextExt on String {
  /// Returns a [Text] widget with this string as the text.
  Text get text => Text(this);
}

/// Provides a set of utility methods to work with text in a more expressive way.
extension TextExt on Text {
  /// Centers this [Text] horizontally.
  Text get centered => copyWith(textAlign: TextAlign.center);

  /// Aligns this [Text] to the left.
  Text get left => copyWith(textAlign: TextAlign.left);

  /// Aligns this [Text] to the right.
  Text get right => copyWith(textAlign: TextAlign.right);

  /// Copies this [Text] while overriding the provided properties.
  Text copyWith({
    Key? key,
    String? data,
    TextStyle? style,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    Color? selectionColor,
    StrutStyle? strutStyle,
    TextHeightBehavior? textHeightBehavior,
    TextScaler? textScaler,
  }) =>
      Text(
        key: key ?? this.key,
        data ?? this.data!,
        style: style ?? this.style,
        textAlign: textAlign ?? this.textAlign,
        textDirection: textDirection ?? this.textDirection,
        locale: locale ?? this.locale,
        softWrap: softWrap ?? this.softWrap,
        overflow: overflow ?? this.overflow,
        maxLines: maxLines ?? this.maxLines,
        semanticsLabel: semanticsLabel ?? this.semanticsLabel,
        textWidthBasis: textWidthBasis ?? this.textWidthBasis,
        selectionColor: selectionColor ?? this.selectionColor,
        strutStyle: strutStyle ?? this.strutStyle,
        textHeightBehavior: textHeightBehavior ?? this.textHeightBehavior,
        textScaler: textScaler ?? this.textScaler,
      );

  /// Applies the provided [style] to this [Text].
  ///
  /// If [merge] is set to `true`, the provided [style] will be merged with the existing style.
  Text styled(TextStyle style, {bool merge = false}) =>
      copyWith(style: merge ? style.merge(this.style) : style);

  /// Applies the provided [key] to this [Text].
  Text key(Key key) => copyWith(key: key);

  /// Applies the provided [data] to this [Text].
  Text color(Color color) => styled(TextStyle(color: color), merge: true);
}

/// Provides generic widget utilities.
extension WidgetExt on Widget {
  /// Stretches this widget to fill the available horizontal space.
  /// Optionally, you can provide [padding] to the stretched widget.
  ///
  /// This is equivalent to wrapping this widget with a [Container] with [double.infinity] as the width.
  Widget stretch([EdgeInsets? padding]) => Container(
        width: double.infinity,
        padding: padding,
        child: this,
      );

  /// Aligns this widget to the left.
  ///
  /// This is equivalent to wrapping this widget with an [Align] widget with [Alignment.centerLeft].
  Widget left() => Align(alignment: Alignment.centerLeft, child: this);

  /// Aligns this widget to the right.
  ///
  /// This is equivalent to wrapping this widget with an [Align] widget with [Alignment.centerRight].
  Widget right() => Align(alignment: Alignment.centerRight, child: this);

  /// Aligns this widget to the top.
  ///
  /// This is equivalent to wrapping this widget with an [Align] widget with [Alignment.topCenter].
  Widget center() => Align(child: this);

  /// Aligns this widget to the top.
  ///
  /// This is equivalent to wrapping this widget with an [Align] widget with [Alignment.topCenter].
  Widget top() => Align(alignment: Alignment.topCenter, child: this);

  /// Aligns this widget to the bottom.
  ///
  /// This is equivalent to wrapping this widget with an [Align] widget with [Alignment.bottomCenter].
  Widget bottom() => Align(alignment: Alignment.bottomCenter, child: this);
}
