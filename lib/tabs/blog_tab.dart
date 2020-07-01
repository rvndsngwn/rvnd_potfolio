
import 'package:flutter/material.dart';
import 'package:rvnd/config/constants.dart';
import 'package:rvnd/models/blog_model.dart';
import 'package:rvnd/providers/api_provider.dart';
import 'package:rvnd/widgets/blog_widget.dart';
import 'package:rvnd/widgets/responsive_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class BlogTab extends StatefulWidget {
  @override
  _BlogTabState createState() => _BlogTabState();
}

class _BlogTabState extends State<BlogTab> {
  ApiProvider _apiProvider = ApiProvider();
  List<Blog> _blogs = [];
  bool _loadingData = true;
  bool _showError = false;

  @override
  void initState() {
    super.initState();
    loadBlogs();
  }

  @override
  Widget build(BuildContext context) {
    if (_loadingData)
      return Center(
        child: CircularProgressIndicator(),
      );
    if(_showError){
      return Center(
        child:Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Something went wrong',style: Theme.of(context).textTheme.headline,),
            ),
            RaisedButton(
              child: Text('Retry',style: Theme.of(context).textTheme.button.copyWith(color: Colors.white),),
              elevation: 0.0,
              onPressed:loadBlogs,
            )
          ],
        )
      );
    }
    return ResponsiveWidget(
      largeScreen: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Expanded(
            flex: 2,
            child: blogList(),
          ),
          Expanded(
            flex: 1,
            child: Container(),
          )
        ],
      ),
      smallScreen: blogList(),
    );
  }

  Widget blogList() {

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListView.builder(
                itemCount: _blogs.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) =>
                    BlogWidget(_blogs[index], index, _blogs.length)),
            RaisedButton(
              child: Text('More',style: Theme.of(context).textTheme.button.copyWith(color: Colors.white),),
              elevation: 0.0,
              onPressed: () {
                launch(Constants.PROFILE_MEDIUM);
              },
            )
          ],
        ),
      ),
    );
  }

  void loadBlogs() async {
    setState(() {
      _loadingData = true;
      _showError = false;
    });
    final result = await _apiProvider.getBlogs();
    setState(() {
      if(result==null) {
        _showError = true;
        _loadingData = false;
      }else{
      _blogs = result;
      _showError = false;
      _loadingData = false;
      }
    });
  }
}
