import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LanguagePage extends StatefulWidget {
  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  final _languages = ['English', '简体中文', 'Bahasa Indonesia', 'Tiếng Việt', 'اَلْعَرَبِيَّةُ', 'हिंदी', 'แบบไทย', '日本語', '한국어' ];
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      appBar: WidgetAppBar(),
      body: Container(
          width: double.infinity,
          padding: EdgeInsets.all(48.w),
          child: ListView(
            children: _buildLanguageList(),
          )
      ),
    );
  }

  List<Widget> _buildLanguageList(){
    return _languages.map((e) =>
        Container(
            alignment: Alignment.center,
            child: Text(e)
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
          title: Text('Select language'),
        )
            : AppBar(
          title: Text('Select language'),
        );
      },
    );
  }

  @override
  Size get preferredSize {
    return Size.fromHeight(kToolbarHeight);
  }
}
