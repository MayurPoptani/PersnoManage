import 'package:flutter/material.dart';
import 'package:persno_manage/AppThemeBloc/bloc.dart';



class MyScaffold extends StatelessWidget {

  final String title;
  final Widget body;
  final bool showAppBar;
  final Widget floatingActionButton;
  final bool resizeToAvoidBottomPadding;

  const MyScaffold({Key key,
    this.title,
    this.body,
    this.showAppBar = true,
    this.floatingActionButton,
    this.resizeToAvoidBottomPadding = true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar?AppBar(
        automaticallyImplyLeading: ModalRoute.of(context).settings.name!="/",
        leading: ModalRoute.of(context).settings.name!="/"?IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
          onPressed: () => Navigator.of(context).pop(),
        ) : null,
        title: Text(title??""),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.lightbulb_outline, color: Theme.of(context).iconTheme.color),
            onPressed: () {
              AppThemeBloc().add(SwitchAppThemeEvent());
            },
          )
        ],
      ):null,
      floatingActionButton: floatingActionButton,
      resizeToAvoidBottomPadding: resizeToAvoidBottomPadding,
      body: body,
    );
  }
}