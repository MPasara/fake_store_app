import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_little_app/common/data/shared_preferences_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeRepositoryProvider = Provider<ThemeRepository>(
  (ref) {
    return ThemeRepositoryImpl();
  },
);

abstract class ThemeRepository {
  Future<void> setTheme();
  Future<SharedPreferences> getSharedPreferences();
}

class ThemeRepositoryImpl implements ThemeRepository {
  @override
  Future<SharedPreferences> getSharedPreferences() =>
      SharedPreferencesService().getSharedPreferences();

  @override
  Future<void> setTheme() {
    // TODO: implement setTheme
    throw UnimplementedError();
  }
}
