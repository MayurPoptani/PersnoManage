
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:persno_manage/AppThemeBloc/bloc.dart';
import 'package:persno_manage/Database/Database.dart';
import 'package:persno_manage/global/PersnoManageGlobal.dart';
import 'package:persno_manage/widgets/myScaffold.dart';

class AddNewTodoTask extends StatefulWidget {
  static final String routeName = "AddNewTodoTask";
  @override
  _AddNewTodoTaskState createState() => _AddNewTodoTaskState();
}

class _AddNewTodoTaskState extends State<AddNewTodoTask> {

  List<bool> enabled = [false, false, false, false, false,];
  int count = 0;
  DateTime scheduledForDateTime, completedByDateTime;
  var addNewSubTaskController = TextEditingController();
  var tagsController = TextEditingController();
  var descriptionController = TextEditingController();
  var titleController = TextEditingController();
  List<TodoSubTask> todoSubTaskList = List();

  @override
  void initState() {
    var tempDT = DateTime.now().toLocal();
    scheduledForDateTime = DateTime(tempDT.year, tempDT.month, tempDT.day, tempDT.hour, tempDT.minute, tempDT.second);
    completedByDateTime = scheduledForDateTime.add(Duration(hours: 1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    count = 0;
    for(int i = 0 ; i < 5 ; i ++) if(enabled[i]) count++;
    return MyScaffold(
      resizeToAvoidBottomPadding: false,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.done, color: Theme.of(context).accentColor),
        onPressed: saveTodoTask,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(height: 5),
            //! Heading
            Container(
              margin: const EdgeInsets.only(left: 5),
              child: Text("Add Your New Task", style: Theme.of(context).textTheme.headline.copyWith(fontWeight: FontWeight.w500)),
            ),
            //! Title
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    child: Text("Title?", style: Theme.of(context).textTheme.subhead.copyWith(fontWeight: FontWeight.normal),),
                    padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                  ),
                  Expanded(
                    child: TextField(
                      controller: titleController,
                      minLines: 1, maxLines: 3,
                      style: Theme.of(context).textTheme.headline.copyWith(fontWeight: FontWeight.w500),
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        hasFloatingPlaceholder: true,
                        hintText: "Add Title",
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        hintStyle: Theme.of(context).textTheme.headline.copyWith(color: Theme.of(context).textTheme.subtitle.color.withOpacity(0.4))
                      ),
                    ),
                  ),
                ],
              )
            ),
            //! Scheduled For
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text("Scheduled For?", style: Theme.of(context).textTheme.subhead.copyWith(fontWeight: FontWeight.normal),),
                  Expanded(child: Container(),),
                  InkWell(
                    borderRadius: BorderRadius.circular(30),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Visibility(
                            visible: true,
                            child: Container(
                              margin: const EdgeInsets.only(right: 8),
                              child: Text(scheduledForDateTime!=null?getDateText(scheduledForDateTime):"Select"),
                            ),
                          ),
                          Container(                          
                            child: Icon(Icons.av_timer, size: 30),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      showDateTimePicker(scheduledFor: true, completedBy: false);
                    },
                  ),
                ],
              ),
            ),
            //! Completed By
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text("Completed By?", style: Theme.of(context).textTheme.subhead.copyWith(fontWeight: FontWeight.normal),),
                  Expanded(child: Container(),),                  
                  InkWell(
                    borderRadius: BorderRadius.circular(30),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Visibility(
                            visible: true,
                            child: Container(
                              margin: const EdgeInsets.only(right: 8),
                              child: Text(completedByDateTime!=null?getDateText(completedByDateTime):"Select"),
                            ),
                          ),
                          Container(                          
                            child: Icon(Icons.av_timer, size: 30),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      showDateTimePicker(scheduledFor: false, completedBy: true);
                    },
                  ),
                ],
              ),
            ),
            //! Tags Widget(UnFinished)
            Container(
              padding: const EdgeInsets.only(left: 5, ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.assistant_photo, color: Theme.of(context).iconTheme.color, size: 30),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: TextField(
                            controller: tagsController,
                            minLines: 1,
                            maxLines: 3,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                              border: OutlineInputBorder(borderSide: BorderSide.none),
                              hintText: "Add Tags(useful when searching for the task)",
                              hintStyle: Theme.of(context).textTheme.subhead.copyWith(color: Theme.of(context).iconTheme.color.withOpacity(0.4)),
                            )
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                ],
              )
            ),
            //! Description Widget
            Container(
              padding: const EdgeInsets.only(left: 5, ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.assistant_photo, color: Theme.of(context).iconTheme.color, size: 30),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: TextField(
                            controller: descriptionController,
                            minLines: 1,
                            maxLines: 6,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                              border: OutlineInputBorder(borderSide: BorderSide.none),
                              hintText: "Add Description(something about this task)",
                              hintStyle: Theme.of(context).textTheme.subhead.copyWith(color: Theme.of(context).iconTheme.color.withOpacity(0.4)),
                            )
                          ),
                        ),
                      ),        
                    ],
                  ),
                  
                ],
              )
            ),
            //! Add New Sub-Task Widget
            Container(
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Container(
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
                          controller: addNewSubTaskController,
                          textCapitalization: TextCapitalization.words,
                          onChanged: (text) {
                            setState(() {});
                          },
                          decoration: InputDecoration(
                            hintText: "Add New Task",
                            hintStyle: TextStyle(color: AppThemeBloc().darkModeOn?Colors.white.withOpacity(0.5):Colors.black.withOpacity(0.5)),
                            border: OutlineInputBorder(borderSide: BorderSide.none),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                          ),
                          textInputAction: TextInputAction.next,
                          onSubmitted: (todoSubTaskText) {
                            setState(() {
                              if(todoSubTaskText.trim().length>0) todoSubTaskList.insert(0, TodoSubTask(
                                subTaskText: todoSubTaskText.trim(),
                                addedOn: null,
                                completedOn: null,
                                id: null,
                                completed: false,
                                parentId: null,
                                subTaskDescription: "No Description(This Column Is Dummy)")
                              );
                              addNewSubTaskController.text = "";
                            });
                          },
                        )
                      ),
                      Visibility(
                        visible: addNewSubTaskController.text.trim().length>0,
                        maintainSize: true,
                        maintainAnimation: true,
                        maintainState: true,                    
                        child: IconButton(
                          icon: Icon(Icons.arrow_forward_ios,),
                          padding: const EdgeInsets.all(0),
                          alignment: Alignment.center,
                          onPressed: () {
                            setState(() {
                              if(addNewSubTaskController.text.trim().length>0) todoSubTaskList.insert(0, TodoSubTask(
                                addedOn: DateTime.now().toLocal(),
                                subTaskText: addNewSubTaskController.text.trim(),
                                completedOn: null,
                                id: null,
                                completed: false,
                                parentId: null,
                                subTaskDescription: "No Description(This Column Is Dummy)")
                              );
                              addNewSubTaskController.text = "";
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            //! Sub-Task Item's List
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: todoSubTaskList.length+1,
                itemBuilder: (_,index) {
                  if(index == todoSubTaskList.length) return Container(height: 60,);
                  else return Container(
                    margin: const EdgeInsets.only(left: 10),                    
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        leading: AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          alignment: Alignment.center,
                          height: 35, width: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppThemeBloc().darkModeOn?Colors.greenAccent.shade700:Colors.indigo,
                          ),
                          child: Text((index+1).toString(), style: TextStyle(color: Colors.white), textAlign: TextAlign.center, ),
                        ),
                        title: Text(todoSubTaskList[index].subTaskText),
                        trailing: IconButton(
                          icon: Icon(Icons.delete_sweep, color: Theme.of(context).iconTheme.color),
                          onPressed: () {
                            setState(() {
                              todoSubTaskList.removeAt(index);
                            });
                          }
                        ),
                      )
                    ),
                  );
                },
              ),
            ),
            //! Just A Container used as bottom padding
            Container(height: 10),
          ],
        ),
      ),
    );
  }

  void saveTodoTask() async {
    TodoTask todoTask = TodoTask(
      id: null,
      title: titleController.text.trim(),
      tags: tagsController.text.trim(),
      description: descriptionController.text.trim(),
      scheduledDateTime: scheduledForDateTime,
      completedDateTime: completedByDateTime,
      completed: 0.0
    );
    var allOk = await PersnoManageGlobal.database.addNewTodoTask(todoTask, todoSubTaskList);
    print(allOk?"All Done":"Some Error");
    Navigator.of(context).pop();
  }

  String getDateText(DateTime dateTime) {
    String returnString = "";
    DateTime currDateTime = DateTime.now().toLocal();
    DateTime tomDateTime = currDateTime.add(Duration(days: 1));
    if(dateTime.day == currDateTime.day && dateTime.month == currDateTime.month && dateTime.year == currDateTime.year) returnString += "Today";
    else if(dateTime.day == tomDateTime.day && dateTime.month == tomDateTime.month && dateTime.year == tomDateTime.year) returnString += "Tomorrow";
    else returnString = dateTime.day.toString()+"/"+dateTime.month.toString();    
    returnString+= " by "+(dateTime.hour%12).toString()+":"+(dateTime.minute).toString()+" "+((dateTime.hour>=0 && dateTime.hour <=11)?"AM":"PM");
    return returnString;
  }

  void showDateTimePicker({@required bool scheduledFor, @required bool completedBy}) {
    var selectedTime = Duration(
        hours: scheduledFor?scheduledForDateTime.hour:completedByDateTime.hour,
        minutes: scheduledFor?scheduledForDateTime.minute:completedByDateTime.minute);
    var selectedDate = scheduledFor?scheduledForDateTime:completedByDateTime;
//    selectedDate = selectedDate.add(selectedTime);
    bool enableTimeSelection = false;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return StatefulBuilder(
          builder: (builder, stateSetter) {
            return AlertDialog(
              title: Text("Set "+(scheduledFor?"Schedule":"Deadline"), style: Theme.of(context).textTheme.headline.copyWith(color: Colors.black),),
              content: Container(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Date?", style: Theme.of(context).textTheme.subhead.copyWith(color: Colors.black),),
                    DatePickerTimeline(
                      selectedDate,
                      onDateChange: (date) {
                        stateSetter(() {
                          var temp  = date;
                          selectedDate = temp.add(selectedTime);
                        });
                      },
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Checkbox(
                          activeColor: Colors.black,
                          checkColor: Colors.white,
                          value: enableTimeSelection,
                          onChanged: (changedVal) {
                            stateSetter(() => enableTimeSelection = changedVal);
                          },
                        ),
                        Text("Time?", style: Theme.of(context).textTheme.subhead.copyWith(color: Colors.black),),
                      ],
                    ),
                    Visibility(
                      visible: enableTimeSelection,
                      child: TimePickerSpinner(
                        time: selectedDate, is24HourMode: false,
                        normalTextStyle: TextStyle(fontSize: 18, color: Colors.black45, ),
                        highlightedTextStyle: TextStyle(fontSize: 22, color: Colors.black, ),
                        spacing: 35, itemHeight: 35,
                        isForce2Digits: true,
                        onTimeChange: (time) {
                          stateSetter(() {
                            selectedTime = Duration(hours: time.hour, minutes: time.minute);
                            selectedDate = DateTime(selectedDate.year, selectedDate.month, selectedDate.day).add(selectedTime);
                          });
                        },
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RaisedButton(
                          color: Colors.white,
                          child: Text("Cancel"),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        RaisedButton(
                          color: Colors.white,
                          child: Text("Set"),
                          onPressed: () {
                            setState(() {
                              DateTime finalDateTime = enableTimeSelection?selectedDate:DateTime(selectedDate.year, selectedDate.month, selectedDate.day, 23, 59, 59);
                              if(scheduledFor) {
                                scheduledForDateTime = finalDateTime;
                              } else {
                                completedByDateTime = finalDateTime;
                              }
                              Navigator.of(context).pop();
                            });
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          }
        );
      },
    );
  }

}

