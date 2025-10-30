import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../flavors/build_config.dart';
import '../flavors/env_config.dart';
import 'features/users/presentation/pages/fetch_users/fetch_users_screen.dart';

Future<void> runMyApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
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

        home: FetchUsersScreen()
    );
  }
}