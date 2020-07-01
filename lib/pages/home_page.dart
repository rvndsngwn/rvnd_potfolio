import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rvnd/config/assets.dart';
import 'package:rvnd/tabs/about_tab.dart';
import 'package:rvnd/tabs/blog_tab.dart';
import 'package:rvnd/tabs/projects_tab.dart';
import 'package:rvnd/widgets/theme_inherited_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static List<Widget> tabWidgets = <Widget>[
    AboutTab(),
    BlogTab(),
    ProjectsTab(),
  ];

  bool _extended = false;

  void setExtended(bool isExtended) => setState(() => _extended = isExtended);

  var list = [
    AboutTab(),
    BlogTab(),
    ProjectsTab(),
  ];


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 1200) {
            return Scaffold(
              body: Row(
                children: <Widget>[
                  MouseRegion(
                    onEnter: (_) => setExtended(true),
                    onExit: (_) => setExtended(false),
                    child: NavigationRail(
                      extended: _extended,
                      leading: ExtendableFab(),
                      selectedIndex: _selectedIndex,
                      onDestinationSelected: (int index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      labelType: NavigationRailLabelType.none,
                      destinations: [
                        NavigationRailDestination(
                          icon: Icon(Icons.person),
                          selectedIcon: Icon(Icons.account_circle),
                          label: Text('About'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.picture_in_picture),
                          selectedIcon: Icon(Icons.chrome_reader_mode),
                          label: Text('Blog'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.smartphone),
                          selectedIcon: Icon(Icons.mobile_screen_share),
                          label: Text('Projects'),
                        ),
                      ],
                    ),
                  ),
                  VerticalDivider(thickness: 2, width: 1),
                  // This is the main content.
                  Expanded(
                    child: Center(
                      child: list[_selectedIndex],
                    ),
                  )
                ],
              ),
            );
          } else if (constraints.maxWidth > 800 && constraints.maxWidth < 1200) {
            return Scaffold(
              body: Row(
                children: <Widget>[
                  MouseRegion(
                    onEnter: (_) => setExtended(true),
                    onExit: (_) => setExtended(false),
                    child: NavigationRail(
                      extended: _extended,
                      leading: ExtendableFab(),
                      selectedIndex: _selectedIndex,
                      onDestinationSelected: (int index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      labelType: NavigationRailLabelType.none,
                      destinations: [
                        NavigationRailDestination(
                          icon: Icon(Icons.person),
                          selectedIcon: Icon(Icons.account_circle),
                          label: Text('About'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.picture_in_picture),
                          selectedIcon: Icon(Icons.chrome_reader_mode),
                          label: Text('Blog'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.smartphone),
                          selectedIcon: Icon(Icons.mobile_screen_share),
                          label: Text('Projects'),
                        ),
                      ],
                    ),
                  ),
                  VerticalDivider(thickness: 2, width: 1),
                  // This is the main content.
                  Expanded(
                    child: Center(
                      child: list[_selectedIndex],
                    ),
                  )
                ],
              ),
            );
          } else {
            return Scaffold(
                appBar: AppBar(
                  actions: <Widget>[
                    IconButton(
                      icon: ThemeSwitcher.of(context).isDarkModeOn?Icon(Icons.wb_sunny):Image.asset(Assets.moon,height: 20,width: 20,),
                      onPressed: ()=> ThemeSwitcher.of(context).switchDarkMode(),
                    )
                  ],
                ),
                body: Center(
                  child: tabWidgets.elementAt(_selectedIndex),
                ),
                bottomNavigationBar: BottomNavigationBar(
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      activeIcon: Icon(Icons.account_circle),
                      title: Text('About'),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.picture_in_picture),
                      activeIcon: Icon(Icons.chrome_reader_mode),
                      title: Text('Blog'),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.smartphone),
                      activeIcon: Icon(Icons.mobile_screen_share),
                      title: Text('Projects'),
                    )
                  ],
                  currentIndex: _selectedIndex,
                  onTap: (index)=> setState(() => _selectedIndex = index),
                  selectedItemColor: Theme.of(context).accentColor,
                ),
              );
          }
        },
      ),
    );
  }
}


class ExtendableFab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Animation<double> animation =
        NavigationRail.extendedAnimation(context);
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget child) {
        // The extended fab has a shorter height than the regular fab.
        return Container(
          height: 56,
          padding: EdgeInsets.symmetric(
            vertical: lerpDouble(0, 6, animation.value),
          ),
          child: animation.value == 0
              ? IconButton(
                  icon: ThemeSwitcher.of(context).isDarkModeOn
                      ? Icon(Icons.wb_sunny)
                      : Image.asset(
                          Assets.moon,
                          height: 20,
                          width: 20,
                        ),
                  onPressed: () => ThemeSwitcher.of(context).switchDarkMode(),
                )
              : Align(
                  alignment: AlignmentDirectional.centerStart,
                  widthFactor: animation.value,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(start: 8),
                    child: FloatingActionButton.extended(
                      icon: IconButton(
                        icon: ThemeSwitcher.of(context).isDarkModeOn
                            ? Icon(Icons.wb_sunny)
                            : Image.asset(
                                Assets.moon,
                                height: 20,
                                width: 20,
                              ),
                        onPressed: () =>
                            ThemeSwitcher.of(context).switchDarkMode(),
                      ),
                      label: ThemeSwitcher.of(context).isDarkModeOn
                          ? Text("Light")
                          : Text("Dark"),
                      onPressed: () =>
                          ThemeSwitcher.of(context).switchDarkMode(),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
