import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:rvnd/models/project_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectWidget extends StatelessWidget {
  final Project _project;
  final double _bottomPadding;

  ProjectWidget(this._project, this._bottomPadding);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Card(
      child: InkWell(
        onTap: onProjectClick,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                  flex: 20,
                  child: Image.asset(
                    _project.image,
                    width: width * .20,
                    height: width * .20,
                  )),
              Spacer(),
              Expanded(
                flex: 80,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(_project.name,
                        style: Theme.of(context).textTheme.headline6),
                    SizedBox(),
                    AutoSizeText(
                      _project.description,
                      textScaleFactor: 1.2,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onProjectClick() {
    if (_project.link != null) launch(_project.link);
  }
}
