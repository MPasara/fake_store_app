// ignore_for_file: always_use_package_imports
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_little_app/features/dashboard/presentation/pages/mladens_page.dart';

import '../../../../common/domain/providers/base_router_provider.dart';
import '../../../../common/domain/router/navigation_extensions.dart';
import '../../../../common/presentation/build_context_extensions.dart';
import '../../../../common/presentation/spacing.dart';
import '../../../../common/utils/q_logger.dart';
import '../../../../example/presentation/pages/example_page.dart';
import '../../../../main/app_environment.dart';
import '../../../auth/domain/notifiers/auth_notifier.dart';
import '../../../users/presentation/user_details_page.dart';
import '../../../users/presentation/users_page.dart';

class HomePage extends ConsumerWidget {
  static const routeName = '/home';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [
        Text(
          'Home page',
          style: context.appTextStyles.boldLarge,
          textAlign: TextAlign.center,
        ),
        spacing16,
        TextButton(
          onPressed: ref.read(authNotifierProvider.notifier).logout,
          child: Text(
            'Logout',
            style: context.appTextStyles.regular,
          ),
        ),
        spacing16,
        TextButton(
          onPressed: () => ref.pushNamed(
            ref.getRouteNameFromCurrentLocation(ExamplePage.routeName),
          ),
          child: Text(
            'Go to example page',
            style: context.appTextStyles.bold,
          ),
        ),
        spacing16,
        TextButton(
          onPressed: () => ref.pushNamed(
            ref.getRouteNameFromCurrentLocation(
              UserDetailsPage.getRouteNameWithParams(1),
            ),
          ),
          child: Text(
            'Dashboard -> User details 1',
            style: context.appTextStyles.bold,
          ),
        ),
        spacing16,
        TextButton(
          onPressed: () => ref.pushNamed(
            '${UsersPage.routeName}${UserDetailsPage.getRouteNameWithParams(1)}',
          ),
          child: Text(
            'Users -> User details 1',
            style: context.appTextStyles.bold,
          ),
        ),
        if (!EnvInfo.isProduction) ...[
          spacing16,
          TextButton(
            onPressed: () => QLogger.showLogger(
              ref.read(baseRouterProvider).navigatorContext!,
            ),
            child: Text('Show log report', style: context.appTextStyles.bold),
          ),
        ],
        spacing16,
        TextButton(
          onPressed: () {
            ref.pushNamed(
              ref.getRouteNameFromCurrentLocation(MladensPage.routeName),
            );
          },
          child: const Text('Mladens page'),
        ),
      ],
    );
  }
}
