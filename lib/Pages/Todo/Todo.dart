import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:persno_manage/AppThemeBloc/bloc.dart';
import 'package:persno_manage/Database/Database.dart';
import 'package:persno_manage/widgets/myScaffold.dart';

import 'AddNewTodoTask.dart';
import 'ViewTodoTaskTabBarGridViewPage.dart';

class Todo extends StatefulWidget {
  static final String routeName = "/Todo";
  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> with SingleTickerProviderStateMixin{
  TabController tabController;

  @override
  void initState() {
    tabController = TabController(
      length: 5,
      initialIndex: 1,
      vsync: this
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(height: 10),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("Hey Mike", style: Theme.of(context).textTheme.display1),
                  Text("These are your todo lists", style: Theme.of(context).textTheme.subhead),
                ],
              ),
            ),
            Container(height: 20),
            Expanded(
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      child: TabBar(
                        isScrollable: true,
                        labelStyle: Theme.of(context).textTheme.subhead.copyWith(fontWeight: FontWeight.bold),
                        labelColor: Theme.of(context).textTheme.body1.color,
                        controller: tabController,
                        indicatorColor: Theme.of(context).primaryColor,
                        tabs: <Widget>[
                          Container( alignment: Alignment.center,  height: 35, child: Text("Prev Pending"), ),
                          Container( alignment: Alignment.center, height: 35, child: Text("Today"), ),
                          Container( alignment: Alignment.center, height: 35, child: Text("Tomorrow"), ),
                          Container( alignment: Alignment.center, height: 35, child: Text("Month"), ),
                          Container( alignment: Alignment.center, height: 35, child: Text("All Ahead"), ),
                        ],
                      )
                    ),
                    Expanded(
                      child: TabBarView(
                        dragStartBehavior: DragStartBehavior.down,
                        controller: tabController,
                        children: <Widget>[
                          ViewTodoTaskTabBarGridViewPage(key: PageStorageKey("PrevPending"), rangeType: TodoTaskDateRangeType.PrevPending,),
                          ViewTodoTaskTabBarGridViewPage(key: PageStorageKey("Today"), rangeType: TodoTaskDateRangeType.Today,),
                          ViewTodoTaskTabBarGridViewPage(key: PageStorageKey("Tomorrow"), rangeType: TodoTaskDateRangeType.Tomorrow,),
                          ViewTodoTaskTabBarGridViewPage(key: PageStorageKey("Month"), rangeType: TodoTaskDateRangeType.Month,),
                          ViewTodoTaskTabBarGridViewPage(key: PageStorageKey("AllAhead"), rangeType: TodoTaskDateRangeType.AllAhead,),
                        ],
                      ),
                    )
                  ],
                )
              ),
            ),
            addNewTaskButton(),
          ],
        ),
      ),
    );
  }

  Widget addNewTaskButton() => Container(
    child: Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          margin: const EdgeInsets.all(0),
          padding: const EdgeInsets.all(0),
          decoration: BoxDecoration(
            color: (AppThemeBloc().darkModeOn)?Colors.greenAccent.shade700:Colors.indigo,
            borderRadius: BorderRadius.circular(10),
          ),
          child: FlatButton(
            color: Colors.transparent,
            splashColor: !(AppThemeBloc().darkModeOn)?Colors.greenAccent.shade700:Colors.indigo,
            materialTapTargetSize: MaterialTapTargetSize.padded,
            shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10), ),
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 12),
            child: Icon(Icons.add, color: Colors.white),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => AddNewTodoTask())),
          ),
        )
    )
  );
}


