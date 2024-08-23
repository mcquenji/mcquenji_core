/// String utilities.
extension StringX on String {
  /// Case insensitive [contains].
  bool containsIgnoreCase(String other) =>
      toLowerCase().contains(other.toLowerCase());
}
