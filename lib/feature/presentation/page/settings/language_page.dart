import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../generated/l10n.dart';

class LanguageDefine{
  static final _languages = ['English', '简体中文', 'Bahasa Indonesia', 'Tiếng Việt', /*'اَلْعَرَبِيَّةُ',*/ 'हिंदी', 'แบบไทย', '日本語', '한국어' ];
  static final _languageCode = ['en_US', 'zh_CN', 'id_IN', 'vi_VN', /*'ar_SA',*/ 'hi_IN', 'th_TH', 'ja_JP', 'ko_KR'];

  static String getLanguageCode(String lan){
    return _languageCode[_languages.indexOf(lan)];
  }

  static String getLanguageByCode(String code){
    var index = _languageCode.indexWhere((e) => e.startsWith(code));
    if(index == -1) {
      index = 0;
    }
    return _languages[index];
  }

  static List<String> getLanguages(){
    return _languages;
  }

}

class LanguagePage extends StatefulWidget {
  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      appBar: WidgetAppBar(),
      body: Container(
          width: double.infinity,
          padding: EdgeInsets.all(48.w),
          child: ListView(
            children: ListTile.divideTiles(
                context: context,
                tiles:_buildLanguageList()
            ),
          )
      ),
    );
  }

  List<Widget> _buildLanguageList(){
    var language = Hive.box('settings').get('language');
    return LanguageDefine.getLanguages().map((e) =>
        ListTile(
          title: Container(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () async {
                  var code = LanguageDefine.getLanguageCode(e);
                  await Hive.box('settings').put('language', code);
                },
                child: Text(e,
                  style: TextStyle(
                    color: e == LanguageDefine.getLanguageByCode(language) ? Colors.blue : Colors.black
                  ),
                ),
              ),
          ),
        )
    ).toList();
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
          title: Text(S.of(context).selectLanguage),
        )
            : AppBar(
          title: Text(S.of(context).selectLanguage),
        );
      },
    );
  }

  @override
  Size get preferredSize {
    return Size.fromHeight(kToolbarHeight);
  }
}
