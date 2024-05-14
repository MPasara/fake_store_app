// ignore_for_file: always_use_package_imports

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_little_app/features/dashboard/presentation/pages/home_page.dart';
import 'package:my_little_app/features/dashboard/presentation/pages/mladens_page.dart';

import '../../../common/domain/utils/string_extension.dart';
import '../../../example/example_routes.dart';
import '../../../features/directories/presentation/directories_page.dart';
import '../../../features/home/presentation/main_page.dart';
import '../../../features/login/presentation/login_page.dart';
import '../../../features/notifications/presentation/all_notifications_page.dart';
import '../../../features/notifications/presentation/notification_details_page.dart';
import '../../../features/notifications/presentation/notifications_page.dart';
import '../../../features/register/presentation/register_page.dart';
import '../../../features/reset_password/presentation/reset_password_page.dart';
import '../../../features/users/presentation/user_details_page.dart';
import '../../../features/users/presentation/users_page.dart';
import 'go_router_state_extension.dart';

List<RouteBase> getRoutes({
  required GlobalKey<NavigatorState> rootNavigatorKey,
  bool stateful = true,
}) =>
    [
      GoRoute(
        path: MainPage.routeName,
        redirect: (context, state) => HomePage.routeName,
      ),
      _statefulShellRoute(rootNavigatorKey: rootNavigatorKey),
      /*  if (stateful)
        _statefulShellRoute(rootNavigatorKey: rootNavigatorKey)
      else
        _shellRoute(rootNavigatorKey: rootNavigatorKey), */
      GoRoute(
        path: LoginPage.routeName,
        builder: (context, state) => const LoginPage(),
        routes: [
          GoRoute(
            path: ResetPasswordPage.routeName.lastPart,
            builder: (context, state) => const ResetPasswordPage(),
          ),
          GoRoute(
            path: RegisterPage.routeName.lastPart,
            builder: (context, state) => const RegisterPage(),
          ),
        ],
      ),
    ];

RouteBase _statefulShellRoute({
  required GlobalKey<NavigatorState> rootNavigatorKey,
}) =>
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          MainPage(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: HomePage.routeName,
              builder: (context, state) => const HomePage(),
              routes: [
                GoRoute(
                  path: UserDetailsPage.routeName.removeLeadingSlash,
                  builder: (context, state) => UserDetailsPage(
                    userId: state.getPathParameterByName<int>(
                      name: UserDetailsPage.pathPattern.removeLeadingColon,
                    )!,
                  ),
                  redirect: (context, state) =>
                      state.redirectIfPathParameterValid<int>(
                    pathParameterName:
                        UserDetailsPage.pathPattern.removeLeadingColon,
                    redirectTo: MainPage.routeName,
                  ),
                ),
                GoRoute(
                  path: MladensPage.routeName.removeLeadingSlash,
                  parentNavigatorKey:
                      rootNavigatorKey, // used for making bottom navigation not persist
                  builder: (context, state) {
                    return const MladensPage();
                  },
                ),
                getExampleRoutes(rootNavigatorKey: rootNavigatorKey),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: UsersPage.routeName,
              builder: (context, state) => const UsersPage(),
              routes: [
                GoRoute(
                  path: UserDetailsPage.routeName.removeLeadingSlash,
                  builder: (context, state) => UserDetailsPage(
                    userId: state.getPathParameterByName<int>(
                      name: UserDetailsPage.pathPattern.removeLeadingColon,
                    )!,
                  ),
                  redirect: (context, state) =>
                      state.redirectIfPathParameterValid<int>(
                    pathParameterName:
                        UserDetailsPage.pathPattern.removeLeadingColon,
                    redirectTo: UsersPage.routeName,
                  ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: NotificationsPage.routeName,
              builder: (context, state) => const NotificationsPage(),
              routes: [
                GoRoute(
                  path: AllNotificationsPage.routeName.removeLeadingSlash,
                  builder: (context, state) => const AllNotificationsPage(),
                  routes: [
                    GoRoute(
                      path:
                          NotificationDetailsPage.routeName.removeLeadingSlash,
                      builder: (context, state) => NotificationDetailsPage(
                        notificationId: state.getPathParameterByName<int>(
                          name: NotificationDetailsPage
                              .pathPattern.removeLeadingColon,
                        )!,
                      ),
                      redirect: (context, state) =>
                          state.redirectIfPathParameterValid<int>(
                        pathParameterName: NotificationDetailsPage
                            .pathPattern.removeLeadingColon,
                        redirectTo:
                            '${NotificationsPage.routeName}${AllNotificationsPage.routeName}',
                      ),
                    ),
                  ],
                ),
                GoRoute(
                  path: NotificationDetailsPage.routeName.removeLeadingSlash,
                  builder: (context, state) => NotificationDetailsPage(
                    notificationId: state.getPathParameterByName<int>(
                      name: NotificationDetailsPage
                          .pathPattern.removeLeadingColon,
                    )!,
                  ),
                  redirect: (context, state) =>
                      state.redirectIfPathParameterValid<int>(
                    pathParameterName:
                        NotificationDetailsPage.pathPattern.removeLeadingColon,
                    redirectTo: NotificationsPage.routeName,
                  ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: DirectoriesPage.routeName,
              builder: (context, state) => const DirectoriesPage(),
              routes: [
                _buildRoutesRecursively(
                  depth: 10,
                  pathCallback: (depth) => DirectoriesPage.pathPattern(depth),
                  builderCallback: (context, state, depth) => DirectoriesPage(
                    directoryName: state.pathParameters[
                        DirectoriesPage.pathPattern(depth).removeLeadingColon],
                    canGoDeeper: depth > 1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );

/* RouteBase _shellRoute({required GlobalKey<NavigatorState> rootNavigatorKey}) =>
    ShellRoute(
      builder: (context, state, child) => MainPage(child: child),
      routes: [
        GoRoute(
          path: MainPage.routeName,
          builder: (context, state) => MainPage(),
          routes: [
            GoRoute(
              path: UserDetailsPage.routeName.removeLeadingSlash,
              builder: (context, state) => UserDetailsPage(
                userId: state.getPathParameterByName(
                  name: UserDetailsPage.pathPattern.removeLeadingColon,
                )!,
              ),
              redirect: (context, state) =>
                  state.redirectIfPathParameterValid<int>(
                pathParameterName:
                    UserDetailsPage.pathPattern.removeLeadingColon,
                redirectTo: MainPage.routeName,
              ),
            ),
          ],
        ),
        GoRoute(
          path: UsersPage.routeName,
          builder: (context, state) => const UsersPage(),
          routes: [
            GoRoute(
              path: UserDetailsPage.routeName.removeLeadingSlash,
              builder: (context, state) => UserDetailsPage(
                userId: state.getPathParameterByName(
                  name: UserDetailsPage.pathPattern.removeLeadingColon,
                )!,
              ),
              redirect: (context, state) =>
                  state.redirectIfPathParameterValid<int>(
                pathParameterName:
                    UserDetailsPage.pathPattern.removeLeadingColon,
                redirectTo: UsersPage.routeName,
              ),
            ),
          ],
        ),
        GoRoute(
          path: NotificationsPage.routeName,
          builder: (context, state) => const NotificationsPage(),
          routes: [
            GoRoute(
              path: AllNotificationsPage.routeName.removeLeadingSlash,
              builder: (context, state) => const AllNotificationsPage(),
              routes: [
                GoRoute(
                  path: NotificationDetailsPage.routeName.removeLeadingSlash,
                  builder: (context, state) => NotificationDetailsPage(
                    notificationId: state.getPathParameterByName<int>(
                      name: NotificationDetailsPage
                          .pathPattern.removeLeadingColon,
                    )!,
                  ),
                  redirect: (context, state) =>
                      state.redirectIfPathParameterValid<int>(
                    pathParameterName:
                        NotificationDetailsPage.pathPattern.removeLeadingColon,
                    redirectTo:
                        '${NotificationsPage.routeName}${AllNotificationsPage.routeName}',
                  ),
                ),
              ],
            ),
            GoRoute(
              path: NotificationDetailsPage.routeName.removeLeadingSlash,
              builder: (context, state) => NotificationDetailsPage(
                notificationId: state.getPathParameterByName<int>(
                  name: NotificationDetailsPage.pathPattern.removeLeadingColon,
                )!,
              ),
              redirect: (context, state) =>
                  state.redirectIfPathParameterValid<int>(
                pathParameterName:
                    NotificationDetailsPage.pathPattern.removeLeadingColon,
                redirectTo: NotificationsPage.routeName,
              ),
            ),
          ],
        ),
        GoRoute(
          path: DirectoriesPage.routeName,
          builder: (context, state) => const DirectoriesPage(),
          routes: [
            _buildRoutesRecursively(
              depth: 10,
              pathCallback: (depth) => DirectoriesPage.pathPattern(depth),
              builderCallback: (context, state, depth) => DirectoriesPage(
                directoryName: state.pathParameters[
                    DirectoriesPage.pathPattern(depth).removeLeadingColon],
                canGoDeeper: depth > 1,
              ),
            ),
          ],
        ),
      ],
    ); */

GoRoute _buildRoutesRecursively({
  required int depth,
  required Function(int depth) pathCallback,
  Page Function(BuildContext context, GoRouterState state, int depth)?
      pageBuilderCallback,
  Widget Function(BuildContext context, GoRouterState state, int depth)?
      builderCallback,
  GlobalKey<NavigatorState>? parentNavigatorKey,
}) {
  assert(pageBuilderCallback != null || builderCallback != null);
  return GoRoute(
    parentNavigatorKey: parentNavigatorKey,
    path: pathCallback(depth),
    pageBuilder: pageBuilderCallback != null
        ? (context, state) => pageBuilderCallback(context, state, depth)
        : null,
    builder: builderCallback != null
        ? (context, state) => builderCallback(context, state, depth)
        : null,
    routes: depth == 1
        ? <RouteBase>[]
        : [
            _buildRoutesRecursively(
              depth: depth - 1,
              pathCallback: pathCallback,
              pageBuilderCallback: pageBuilderCallback,
              builderCallback: builderCallback,
              parentNavigatorKey: parentNavigatorKey,
            ),
          ],
  );
}
