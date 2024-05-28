import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final appThemeNotifierProvider = NotifierProvider<AppThemeNotifier, bool>(
  () => AppThemeNotifier(),
);

class AppThemeNotifier extends Notifier<bool> {
  late SharedPreferences sharedPreferences;

  @override
  bool build() {
    _init();
    return false;
  }

  void toggleDarkMode() {
    state = !state;
    sharedPreferences.setBool('darkMode', state);
  }

  Future _init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final darkMode = sharedPreferences.getBool('darkMode');
    state = darkMode ?? false;
  }
}
