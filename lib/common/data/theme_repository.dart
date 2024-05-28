// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:either_dart/either.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_little_app/common/data/generic_error_resolver.dart';
import 'package:my_little_app/common/data/shared_preferences_service.dart';
import 'package:q_architecture/q_architecture.dart';

final themeRepositoryProvider = Provider<ThemeRepository>(
  (ref) {
    return ThemeRepositoryImpl(
      ref.watch(sharedPrefsProvider),
    );
  },
);

abstract class ThemeRepository {
  EitherFailureOr<void> setTheme(bool isDark);
  EitherFailureOr<bool> isDarkMode();
}

class ThemeRepositoryImpl with ErrorToFailureMixin implements ThemeRepository {
  final SharedPreferencesService _service;
  ThemeRepositoryImpl(
    this._service,
  );
  @override
  EitherFailureOr<void> setTheme(bool isDark) => execute(
        () async {
          await _service.setThemeMode(isDark);
          return const Right(null);
        },
        errorResolver: const GenericErrorResolver(),
      );

  @override
  EitherFailureOr<bool> isDarkMode() {
    return execute(
      () async {
        final isDarkMode = await _service.isDarkMode();
        return Right(isDarkMode);
      },
      errorResolver: const GenericErrorResolver(),
    );
  }
}
