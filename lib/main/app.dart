import 'package:flutter/material.dart';
import 'package:my_profile/core/routes/route_config.dart';
import 'package:my_profile/core/theme/app_theme.dart';

class App extends StatelessWidget with AppTheme {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: lightTheme(),
      darkTheme: darkTheme(),
      routerConfig: RouteConfig.router(context),
    );
  }
}
