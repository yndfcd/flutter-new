import 'package:flutter/material.dart';
import 'package:neos_post/app.dart';
import 'package:neos_post/config/base_url_config.dart';
import 'package:neos_post/config/flavor_config.dart';
import 'package:neos_post/injection_container.dart' as di;
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('settings');
  FlavorConfig(
    flavor: Flavor.PRODUCTION,
    values: FlavorValues(baseUrl: BaseUrlConfig().baseUrlProduction),
  );
  await di.init();
  runApp(App());
}