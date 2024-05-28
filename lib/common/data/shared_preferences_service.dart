import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPrefsProvider = Provider<SharedPreferencesService>(
  (ref) => SharedPreferencesServiceImpl(SharedPreferences.getInstance()),
);

abstract interface class SharedPreferencesService {
  Future<void> setThemeMode(bool isDark);
  Future<bool> isDarkMode();
}

class SharedPreferencesServiceImpl implements SharedPreferencesService {
  final Future<SharedPreferences> _sharedPreferencesFuture;
  SharedPreferences? _sharedPreferencesInstance;

  SharedPreferencesServiceImpl(
    this._sharedPreferencesFuture,
  );

  @override
  Future<bool> isDarkMode() {
    // TODO: implement isDarkMode
    throw UnimplementedError();
  }

  @override
  Future<void> setThemeMode(bool isDark) {
    // TODO: implement setThemeMode
    throw UnimplementedError();
  }

  Future<SharedPreferences> get _sharedPrefs async {
    return _sharedPreferencesInstance ??= await _sharedPreferencesFuture;
  }
}
