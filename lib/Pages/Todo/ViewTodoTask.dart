import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:persno_manage/AppThemeBloc/bloc.dart';
import 'package:persno_manage/Database/Database.dart';
import 'package:persno_manage/global/PersnoManageGlobal.dart';
import 'package:persno_manage/widgets/myScaffold.dart';

class ViewTodoTask extends StatefulWidget {
  final TodoTask todoTask;

  const ViewTodoTask({Key key, @required this.todoTask}) : super(key: key);
  @override
  _ViewTodoTaskState createState() => _ViewTodoTaskState();
}

class _ViewTodoTaskState extends State<ViewTodoTask> {
  
  int completedCount = 0, totalCount = 0;
  var addNewSubTaskTextEditingController = TextEditingController();

  TextEditingController controller;
  FocusNode titleFocusNode;
  bool titleEditingEnabled = false;

  @override
  void initState() {
    controller = TextEditingController(text: widget.todoTask.title);
    titleFocusNode = FocusNode();
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
              margin: const EdgeInsets.only(left: 15, right: 10,),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      focusNode: titleFocusNode,
                      enabled: titleEditingEnabled,
                      controller: controller,
                      textCapitalization: TextCapitalization.words,
                      style: Theme.of(context).textTheme.title.copyWith(fontSize: 30),
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.only(left: 5, top: 3, bottom: 3,),
                        border: OutlineInputBorder(borderSide: BorderSide.none,),
                      ),
                    ),
                  ),
                  InkWell(
                    radius: 30,
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Icon(titleEditingEnabled?Icons.check:Icons.edit, size: 30, color: Theme.of(context).iconTheme.color),
                    ),
                    onTap: () async {
                      if(titleEditingEnabled) {
                        var temp = widget.todoTask.copyWith(title: controller.text.trim());
                        print("Temp id = "+temp.id.toString());
                        print("AWAIT PRINT = "+(await PersnoManageGlobal.database.updateTodoTask(temp)).toString());
                        titleFocusNode.unfocus();
                        titleEditingEnabled = false;
                      } else {
                        FocusScope.of(context).requestFocus(titleFocusNode);
                        titleEditingEnabled = true;
                      }
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(left: 20),
                          child: Text("Scheduled for "+getDateText(widget.todoTask.scheduledDateTime), style: Theme.of(context).textTheme.subhead),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 20),
                          child: Text("Get it done by "+getDateText(widget.todoTask.completedDateTime), style: Theme.of(context).textTheme.subhead),
                        ),
                      ],
                    )
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 5, right: 5),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        child: Icon(Icons.delete_sweep, size: 35, color: Theme.of(context).iconTheme.color),
                        padding: const EdgeInsets.all(10),
                      ),
                      onTap: showConfirmTodoTaskDeleteDialog,
                    ),
                  )
                ],
              ),
            ),
            Container(height: 20),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: StreamBuilder<List<TodoSubTask>>(
                  stream: PersnoManageGlobal.database.watchTodoSubTask(widget.todoTask.id),
                  initialData: [],
                  builder: (_,snapshot) {
                    completedCount = 0;
                    totalCount= snapshot.data.length;
                    for(int i = 0 ; i < snapshot.data.length ; i++) {
                      if(snapshot.data[i].completed) completedCount++;
                    }
                    int percent = 0;
                    if(totalCount>0) {
                      percent = ((completedCount/totalCount)*100).toInt();
                      PersnoManageGlobal.database.updateTodoTask(widget.todoTask.copyWith(title: controller.text.trim(), completed: percent.toDouble()));
                    }
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          child: Text(percent.toString()+"%  Completed! "+(percent==100?" GOOD!":""), style: Theme.of(context).textTheme.headline),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Expanded(
                                flex: totalCount<=0?0:completedCount,
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 250),
                                  height: 5,
                                  decoration: BoxDecoration(
                                    color: AppThemeBloc().darkModeOn?Colors.white:Colors.black.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: totalCount<=0?1:(totalCount-completedCount),
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 250),
                                  height: 5,
                                  decoration: BoxDecoration(
                                    color: AppThemeBloc().darkModeOn?Colors.black.withOpacity(0.3):Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.all(10),
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return AnimatedContainer(
                                duration: Duration(milliseconds: 250),
                                child: Card(
                                  elevation: AppThemeBloc().darkModeOn?5:2,
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 250),
                                    foregroundDecoration: BoxDecoration(
                                      color: snapshot.data[index].completed
                                        ?AppThemeBloc().darkModeOn
                                          ?Colors.black45
                                          :Colors.white.withOpacity(0.85)
                                        :Colors.transparent,
                                    ),
                                    child: ListTile(
                                      title: Text(snapshot.data[index].subTaskText, style: TextStyle(decoration: snapshot.data[index].completed?TextDecoration.lineThrough:null, decorationThickness: 2.5),),
                                      trailing: CircularCheckBox(
                                        activeColor: AppThemeBloc().darkModeOn?Colors.greenAccent.shade700:Colors.indigo,
                                        inactiveColor: Theme.of(context).iconTheme.color,
                                        onChanged: (changeVal) => setState(() {
                                          PersnoManageGlobal.database.updateTodoSubTask(
                                            snapshot.data[index].id,
                                            snapshot.data[index].copyWith(
                                              completed: !snapshot.data[index].completed,
                                              completedOn: !snapshot.data[index].completed?DateTime.now().toLocal():null,
                                            ),
                                          );
                                        }),
                                        value: snapshot.data[index].completed,
                                      ),
                                      onTap: () => setState(()  {
                                        PersnoManageGlobal.database.updateTodoSubTask(
                                          snapshot.data[index].id,
                                          snapshot.data[index].copyWith(
                                            completed: !snapshot.data[index].completed,
                                            completedOn: !snapshot.data[index].completed?DateTime.now().toLocal():null,
                                          ),
                                        );
                                      }),
                                      onLongPress: () => setState(() {
                                        PersnoManageGlobal.database.updateTodoSubTask(
                                          snapshot.data[index].id,
                                          snapshot.data[index].copyWith(
                                            completed: !snapshot.data[index].completed,
                                            completedOn: !snapshot.data[index].completed?DateTime.now().toLocal():null,
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 2, left: 6, bottom: 2,),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Container(
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppThemeBloc().darkModeOn?Colors.greenAccent.shade700:Colors.indigo,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: Icon(Icons.add, color: Colors.white),
                      ),
                    )
                  ),
                  Expanded(
                    child: TextField(
                      onSubmitted: (text) {
                        PersnoManageGlobal.database.addNewTodoSubTask(
                            widget.todoTask.id,
                            TodoSubTask(
                              id: null,
                              parentId: widget.todoTask.id,
                              subTaskText: addNewSubTaskTextEditingController.text.trim(),
                              subTaskDescription: "ADD NEW SUB TASK DUMMY DECRIPTION TEXT",
                              completed: false,
                              addedOn: DateTime.now().toLocal(),
                            )
                          );
                        addNewSubTaskTextEditingController.text = "";
                      },
                      controller: addNewSubTaskTextEditingController,
                      onChanged: (text) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        hintText: "Add New Task",
                        hintStyle: TextStyle(color: AppThemeBloc().darkModeOn?Colors.white.withOpacity(0.5):Colors.black.withOpacity(0.5)),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                      )
                    )
                  ),
                  Visibility(
                    visible: addNewSubTaskTextEditingController.text.trim().length>0,
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,                    
                    child: IconButton(
                      icon: Icon(Icons.arrow_forward_ios,),
                      padding: const EdgeInsets.all(0),
                      alignment: Alignment.center,
                      onPressed: () async {
                        await PersnoManageGlobal.database.addNewTodoSubTask(
                          widget.todoTask.id,
                          TodoSubTask(
                            id: null,
                            parentId: widget.todoTask.id,
                            subTaskText: addNewSubTaskTextEditingController.text.trim(),
                            subTaskDescription: "ADD NEW SUB TASK DUMMY DECRIPTION TEXT",
                            completed: false,
                            addedOn: DateTime.now().toLocal(),
                          )
                        );
                        addNewSubTaskTextEditingController.text = "";
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        )
      ),
    );
  }

  String getDateText(DateTime dateTime) {
    String returnString = "";
    DateTime currDateTime = DateTime.now().toLocal();
    DateTime tomDateTime = currDateTime.add(Duration(days: 1));
    if(dateTime.day == currDateTime.day && dateTime.month == currDateTime.month && dateTime.year == currDateTime.year) {
      returnString += "Today";
    } else if(dateTime.day == tomDateTime.day && dateTime.month == tomDateTime.month && dateTime.year == tomDateTime.year) {
      returnString += "Tomorrow";
    } else {
      returnString = dateTime.day.toString()+"/"+dateTime.month.toString();
    }
    returnString+= " by "+(dateTime.hour%12).toString()+":"+(dateTime.minute).toString()+" "+((dateTime.hour>1 && dateTime.hour <13)?"AM":"PM");
    return returnString;
  }

  void showConfirmTodoTaskDeleteDialog() {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("Confirm Delete", style: TextStyle(color: Colors.black)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Are you sure you want to delete this task?", style: TextStyle(color: Colors.black)),
              Text("Ps: This action is irreversible.", style: TextStyle(color: Colors.redAccent),),
              Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    FlatButton(
                      child: Text("Delete"),
                      color: Colors.white,
                      onPressed: () async {
                        await PersnoManageGlobal.database.deletedTodoTask(widget.todoTask.id);
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      }
                    ),
                    FlatButton(
                      child: Text("No"),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.of(context).pop();
                      }
                    ),
                  ],
                )
              )
            ],
          )
        );
      }
    );
  }

}
