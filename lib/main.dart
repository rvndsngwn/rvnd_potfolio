import 'package:flutter/material.dart';
import 'package:rvnd/pages/home_page.dart';
import 'package:rvnd/widgets/theme_inherited_widget.dart';

import 'config/themes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThemeSwitcherWidget(
      initialDarkModeOn: false,
      child: RvndSngwn(),
    );
  }
}
class RvndSngwn extends StatelessWidget {
  const RvndSngwn({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Portfolio',
      theme:ThemeSwitcher.of(context).isDarkModeOn?darkTheme(context):lightTheme(context),
      home: HomePage(),
    );
  }
}
