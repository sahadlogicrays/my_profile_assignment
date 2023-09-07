import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_profile/features/profile/presentation/screen/edit_profile_screen.dart';
import 'package:my_profile/features/profile/presentation/screen/user_profile_screen.dart';
import 'package:my_profile/main/defer_init.dart';

import 'route_path.dart';

abstract final class RouteConfig {
  static GoRouter router(BuildContext context) => GoRouter(
        routes: [
          GoRoute(
            path: RoutePath.intialRoute,
            builder: (context, state) => const DeferScreen(),
          ),
          GoRoute(
            path: RoutePath.profile,
            builder: UserProfileScreen.routeBuilder,
          ),
          GoRoute(
            path: RoutePath.editProfile,
            builder: EditProfileScreen.routeBuilder,
          ),
        ],
        errorBuilder: (context, state) => const Scaffold(
          body: Text('Error'),
        ),
      );
}
