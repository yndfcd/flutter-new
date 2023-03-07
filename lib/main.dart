import 'dart:io';

import 'package:flutter/material.dart';
import 'package:neos_post/app.dart';
import 'package:neos_post/config/base_url_config.dart';
import 'package:neos_post/config/flavor_config.dart';
import 'package:neos_post/core/network/network_info.dart';
import 'package:neos_post/injection_container.dart' as di;
import 'package:hive_flutter/hive_flutter.dart';

import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('settings');
  var language = Hive.box('settings').get('language');
  if(language == null){
    var locale = Platform.localeName;
    language = locale.split('_')[0];
  }
  await Hive.box('settings').put('language', language);
  FlavorConfig(
    flavor: Flavor.DEVELOPMENT,
    values: FlavorValues(baseUrl: BaseUrlConfig().baseUrlDevelopment),
  );
  await di.init();
  await sl<NetworkInfo>().check();
  runApp(App());
}