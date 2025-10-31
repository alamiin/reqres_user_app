import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../flavors/build_config.dart';
import '../flavors/env_config.dart';
import 'config/route/app_route.dart';
import 'features/users/presentation/pages/fetch_users/fetch_users_screen.dart';
import 'package:reqres_user_app/app/di_container.dart' as di;
import 'features/users/presentation/provider/user_provider.dart';


Future<void> runMyApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => di.sl<UserProvider>()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final EnvConfig _envConfig = BuildConfig.instance.config;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: _envConfig.appName,
        debugShowCheckedModeBanner: false,
        theme: _envConfig.theme,
        onGenerateRoute: AppRoute.onGenerateRoutes,
        home: FetchUsersScreen()
    );
  }
}