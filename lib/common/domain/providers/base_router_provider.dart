// ignore_for_file: always_use_package_imports

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../features/auth/domain/notifiers/auth_notifier.dart';
import '../../../features/home/presentation/home_page.dart';
import '../router/base_router.dart';
import '../router/go_router_router.dart';
import '../router/routes.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final baseRouterProvider = Provider<BaseRouter>((ref) {
  final authNotifier = ref.read(authNotifierProvider.notifier);
  final goRouter = GoRouter(
    debugLogDiagnostics: kDebugMode,
    navigatorKey: _rootNavigatorKey,
    initialLocation: HomePage.routeName,
    routes: getRoutes(rootNavigatorKey: _rootNavigatorKey, stateful: true),
    refreshListenable: authNotifier,
    redirect: (context, state) => authNotifier.redirect(
      goRouterState: state,
      showErrorIfNonExistentRoute: true,
    ),
  );
  return GoRouterRouter(
    routerDelegate: goRouter.routerDelegate,
    routeInformationParser: goRouter.routeInformationParser,
    routeInformationProvider: goRouter.routeInformationProvider,
    router: goRouter,
  );
});
