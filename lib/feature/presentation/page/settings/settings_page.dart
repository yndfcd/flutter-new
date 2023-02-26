import 'package:flutter/material.dart';
import 'package:flutter_news_app/feature/presentation/page/settings/language_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../generated/l10n.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    var code = Hive.box('settings').get('language');
    var language = LanguageDefine.getLanguageByCode(code);

    return Scaffold(
      appBar: WidgetAppBar(),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(48.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    S.of(context).selectLanguage,
                    style: TextStyle(
                      fontSize: 42.sp,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LanguagePage(),
                      ),
                    );
                  },
                  child: Text('$language...'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class WidgetAppBar extends PreferredSize {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box('settings').listenable(),
      builder: (context, box, widget) {
        var isDarkMode = box.get('darkMode') ?? false;
        return isDarkMode
            ? AppBar(
                title: Text(S.of(context).settings),
              )
            : AppBar(
                title: Text(S.of(context).settings),
              );
      },
    );
  }

  @override
  Size get preferredSize {
    return Size.fromHeight(kToolbarHeight);
  }
}
