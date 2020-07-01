
import 'package:flutter/material.dart';
import 'package:persno_manage/AppThemeBloc/apptheme_bloc.dart';
import 'package:persno_manage/Database/Database.dart';
import 'package:persno_manage/global/PersnoManageGlobal.dart';
import 'package:persno_manage/widgets/TodoPageGridViewCustomCard.dart';

import 'ViewTodoTask.dart';

class ViewTodoTaskTabBarGridViewPage extends StatefulWidget {
  final TodoTaskDateRangeType rangeType;
  //ignore: avoid_init_to_null
  ViewTodoTaskTabBarGridViewPage({Key key, this.rangeType = TodoTaskDateRangeType.Today}) : super(key: key);

  @override
  _ViewTodoTaskTabBarGridViewPageState createState() => _ViewTodoTaskTabBarGridViewPageState();
}

class _ViewTodoTaskTabBarGridViewPageState extends State<ViewTodoTaskTabBarGridViewPage> with AutomaticKeepAliveClientMixin{

  Stream<List<TodoTask>> stream;

  @override
  void initState() {
    stream = PersnoManageGlobal.database.getTodoTasksList(rangeType: widget.rangeType);
    super.initState();
  }

  @override bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: StreamBuilder<List<TodoTask>>(
        stream: stream,
        initialData: [],
        builder: (BuildContext context, AsyncSnapshot<List<TodoTask>> snapshot) {
          if(mounted) {
            if(snapshot.data.length<=0)
              return Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text("Nothing here for now.\nClick on the + button below to add a new todo task", textAlign: TextAlign.center),
              );
            else return getTodoTaskListItem(snapshot.data);
          } else {
            print("Today Not Mounted");
            return Container();
          }
        }
      ),
    );
  }

  Widget getTodoTaskListItem(List<TodoTask> data) {
    for(int i = 0 ; i < data.length ; i++) {
      print("Topic = "+data[i].title);
      print("Scheduled Date = "+data[i].scheduledDateTime.toString());
      print("Completion Date = "+data[i].completedDateTime.toString());
    }
    return GridView.count(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
      crossAxisCount: 2,
      children: <Widget>[
        for(int i = 0; i < data.length; i++) Container(
          child: TodoPageGridViewCustomCard(
            color: AppThemeBloc().darkModeOn
                ? TodoPageGridViewCustomCard.darkThemeCardColors[i % TodoPageGridViewCustomCard.darkThemeCardColors.length]
                : TodoPageGridViewCustomCard.lightThemeCardColors[i % TodoPageGridViewCustomCard.lightThemeCardColors.length],
            icon: Icon(Icons.list, color: Colors.white, size: 30),
            title: (data[i].title),
            subTitle: "Some sub tasks",
            percent: data[i].completed,
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ViewTodoTask(todoTask: data[i],))),
          ),
        ),
      ],
    );
  }

}
