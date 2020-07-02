import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rvnd/config/assets.dart';
import 'package:rvnd/config/constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/theme_inherited_widget.dart';

class AboutTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 100,
                backgroundImage: Image.asset(Assets.avatar).image,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Arvind Sangwan',textAlign: TextAlign.center,
                textScaleFactor: 4,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Android. Flutter. iOS. Web.\nLikes Music and eGaming.',
                style: Theme.of(context).textTheme.caption,
                textScaleFactor: 2,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FlatButton.icon(
                    icon: SizedBox(
                        width: 20,
                        height: 20,
                        child: Image.asset(Assets.github)),
                    label: Text('Github'),
                    onPressed: () {
                      launch(Constants.PROFILE_GITHUB);
                    },
                  ),
                  FlatButton.icon(
                    icon: SizedBox(
                        width: 20,
                        height: 20,
                        child: Image.asset(Assets.twitter)),
                    label: Text('Twitter'),
                    onPressed: (){
                      launch(Constants.PROFILE_TWITTER);
                    },
                  ),
                  FlatButton.icon(
                    icon: SizedBox(
                        width: 20,
                        height: 20,
                        child: Image.asset(
                            ThemeSwitcher.of(context).isDarkModeOn
                                ? Assets.medium
                                : Assets.medium_light)),
                    label: Text('Medium'),
                    onPressed: (){
                      launch(Constants.PROFILE_MEDIUM);
                    },
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FlatButton.icon(
                    icon: SizedBox(
                        width: 20,
                        height: 20,
                        child: Image.asset(Assets.instagram)),
                    label: Text('Instagram'),
                    onPressed: () {
                      launch(Constants.PROFILE_INSTAGRAM);
                    },
                  ),
                  FlatButton.icon(
                    icon: SizedBox(
                        width: 20,
                        height: 20,
                        child: Image.asset(Assets.facebook)),
                    label: Text('Facebook'),
                    onPressed: () {
                      launch(Constants.PROFILE_FACEBOOK);
                    },
                  ),
                  FlatButton.icon(
                    icon: SizedBox(
                        width: 20,
                        height: 20,
                        child: Image.asset(Assets.linkedin)),
                    label: Text('Linkedin'),
                    onPressed: (){
                      launch(Constants.PROFILE_LINKEDIN);
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
