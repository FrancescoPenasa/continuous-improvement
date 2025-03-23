import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

@riverpod
class IsLightTheme extends _$IsLightTheme {
  @override
  bool build() {
    return true;
  }

  void toggle() {
    state = !state;
  }
}
