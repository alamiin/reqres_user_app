

import '/flavors/build_config.dart';
import '/flavors/env_config.dart';
import '/flavors/environment.dart';

import 'app/config/theme/light_theme.dart';
import 'app/my_app.dart';


Future<void> main() async {

  EnvConfig devConfig = EnvConfig(
    appName: "DEV Reqres User App",
    baseUrl: "https://reqres.in/",
    theme: lightTheme,
    shouldCollectCrashLog: true,
  );

  BuildConfig.instantiate(
    envType: Environment.DEVELOPMENT,
    envConfig: devConfig,
  );

  runMyApp();

}
