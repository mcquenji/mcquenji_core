import 'package:flutter/material.dart';

/// Base class for declarative padding.
class DeclarativeEdgeInsets extends EdgeInsets {
  /// Default padding value.
  static const double defaultPadding = 30.0;

  /// Base class for declarative padding.
  const DeclarativeEdgeInsets(
      {double? left, double? top, double? right, double? bottom})
      : super.only(
          left: left ?? defaultPadding,
          top: top ?? defaultPadding,
          right: right ?? defaultPadding,
          bottom: bottom ?? defaultPadding,
        );

  double _findMax() {
    var max = [left, top, right, bottom].reduce(
      (value, element) => value > element ? value : element,
    );

    return max > 0 ? max : defaultPadding;
  }

  /// Adds padding to the left of the child.
  ///
  /// If [padding] is not provided, it defaults to the value of the side with the largest padding. If all sides are 0, it defaults to [defaultPadding].
  // ignore: non_constant_identifier_names
  DeclarativeEdgeInsets Left([double? padding]) =>
      copyWith(left: padding ?? _findMax());

  /// Adds padding to the top of the child.
  ///
  /// If [padding] is not provided, it defaults to the value of the side with the largest padding. If all sides are 0, it defaults to [defaultPadding].
  // ignore: non_constant_identifier_names
  DeclarativeEdgeInsets Top([double? padding]) =>
      copyWith(top: padding ?? _findMax());

  /// Adds padding to the right of the child.
  ///
  /// If [padding] is not provided, it defaults to the value of the side with the largest padding. If all sides are 0, it defaults to [defaultPadding].
  // ignore: non_constant_identifier_names
  DeclarativeEdgeInsets Right([double? padding]) =>
      copyWith(right: padding ?? _findMax());

  /// Adds padding to the bottom of the child.
  ///
  /// If [padding] is not provided, it defaults to the value of the side with the largest padding. If all sides are 0, it defaults to [defaultPadding].
  // ignore: non_constant_identifier_names
  DeclarativeEdgeInsets Bottom([double? padding]) =>
      copyWith(bottom: padding ?? _findMax());

  /// Adds padding to all sides of the child.
  ///
  /// If [padding] is not provided, it defaults to the value of the side with the largest padding. If all sides are 0, it defaults to [defaultPadding].
  // ignore: non_constant_identifier_names
  DeclarativeEdgeInsets All([double? padding]) => copyWith(
        left: padding ?? _findMax(),
        top: padding ?? _findMax(),
        right: padding ?? _findMax(),
        bottom: padding ?? _findMax(),
      );

  /// Adds padding to the horizontal sides of the child.
  ///
  /// If [padding] is not provided, it defaults to the value of the side with the largest padding. If all sides are 0, it defaults to [defaultPadding].
  // ignore: non_constant_identifier_names
  DeclarativeEdgeInsets Horizontal([double? padding]) => copyWith(
        left: padding ?? _findMax(),
        right: padding ?? _findMax(),
      );

  /// Adds padding to the vertical sides of the child.
  ///
  /// If [padding] is not provided, it defaults to the value of the side with the largest padding. If all sides are 0, it defaults to [defaultPadding].
  // ignore: non_constant_identifier_names
  DeclarativeEdgeInsets Vertical([double? padding]) => copyWith(
        top: padding ?? _findMax(),
        bottom: padding ?? _findMax(),
      );

  @override
  DeclarativeEdgeInsets copyWith({
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) {
    return DeclarativeEdgeInsets(
      left: left ?? this.left,
      top: top ?? this.top,
      right: right ?? this.right,
      bottom: bottom ?? this.bottom,
    );
  }
}

/// Left padding for a child.
class PaddingLeft extends DeclarativeEdgeInsets {
  /// Adds padding to the left of the child.
  ///
  /// If [padding] is not provided, it defaults to [DeclarativeEdgeInsets.defaultPadding].
  const PaddingLeft([double? padding])
      : super(left: padding, top: 0, right: 0, bottom: 0);
}

/// Top padding for a child.
class PaddingTop extends DeclarativeEdgeInsets {
  /// Adds padding to the top of the child.
  ///
  /// If [padding] is not provided, it defaults to [DeclarativeEdgeInsets.defaultPadding].
  const PaddingTop([double? padding])
      : super(top: padding, left: 0, right: 0, bottom: 0);
}

/// Right padding for a child.
class PaddingRight extends DeclarativeEdgeInsets {
  /// Adds padding to the right of the child.
  ///
  /// If [padding] is not provided, it defaults to [DeclarativeEdgeInsets.defaultPadding].
  const PaddingRight([double? padding])
      : super(right: padding, top: 0, left: 0, bottom: 0);
}

/// Bottom padding for a child.
class PaddingBottom extends DeclarativeEdgeInsets {
  /// Adds padding to the bottom of the child.
  ///
  /// If [padding] is not provided, it defaults to [DeclarativeEdgeInsets.defaultPadding].
  const PaddingBottom([double? padding])
      : super(bottom: padding, left: 0, top: 0, right: 0);
}

/// Padding for all sides of a child.
class PaddingAll extends DeclarativeEdgeInsets {
  /// Adds padding to all sides of the child.
  ///
  /// If [padding] is not provided, it defaults to [DeclarativeEdgeInsets.defaultPadding].
  const PaddingAll([double? padding])
      : super(left: padding, top: padding, right: padding, bottom: padding);
}

/// Horizontal padding for a child.
class PaddingHorizontal extends DeclarativeEdgeInsets {
  /// Adds padding to the horizontal sides of the child.
  ///
  /// If [padding] is not provided, it defaults to [DeclarativeEdgeInsets.defaultPadding].
  const PaddingHorizontal([double? padding])
      : super(left: padding, right: padding, top: 0, bottom: 0);
}

/// Vertical padding for a child.
class PaddingVertical extends DeclarativeEdgeInsets {
  /// Adds padding to the vertical sides of the child.
  ///
  /// If [padding] is not provided, it defaults to [DeclarativeEdgeInsets.defaultPadding].
  const PaddingVertical([double? padding])
      : super(top: padding, bottom: padding, left: 0, right: 0);
}
