import 'package:moor_flutter/moor_flutter.dart';

part 'Database.g.dart';

class TodoTasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  DateTimeColumn get scheduledDateTime => dateTime()();
  DateTimeColumn get completedDateTime => dateTime()();
  TextColumn get tags => text()();
  TextColumn get description => text()();
  RealColumn get completed => real().nullable()();
}

class TodoSubTasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get parentId => integer()();
  TextColumn get subTaskText => text()();
  TextColumn get subTaskDescription => text()();
  BoolColumn get completed => boolean()();
  DateTimeColumn get addedOn => dateTime()();
  DateTimeColumn get completedOn => dateTime().nullable()();
}

class Notes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  DateTimeColumn get saveDateTime => dateTime()();
  DateTimeColumn get updateDateTime => dateTime()();
  IntColumn get subItemCount => integer()();
  // IntColumn get textNoteCount => integer()();
  // IntColumn get audioNoteCount => integer()();
  // IntColumn get imageNoteCount => integer()();
}

class NoteSubItemType {
  //ignore: non_constant_identifier_names
  static final int Audio = 0, Text = 1, Image = 2;
}
class NoteSubItems extends Table {  
  IntColumn get id => integer().autoIncrement()();
  IntColumn get parentId => integer()();
  IntColumn get type => integer()();
  TextColumn get body => text()();
  DateTimeColumn get saveDateTime => dateTime()();
}

enum TodoTaskDateRangeType {PrevPending, Today, Tomorrow, Month, AllAhead}


@UseMoor(tables: [TodoTasks, TodoSubTasks, Notes, NoteSubItems,])
class Database extends _$Database {
  String databasePath;

  Database({@required databasePath}) : super(FlutterQueryExecutor.inDatabaseFolder(path: databasePath, logStatements: true,)) {
    print("initialized database at path = \"" + databasePath + "\"");
  }

  @override int get schemaVersion => 1;

  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //                                                                                                                                 //
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  /// get count of tasks for 30 days from today's date
  Stream<List<TodoTask>> getTodoTaskCount() {
    DateTime lowerDateRange, upperDateRange;
    upperDateRange = lowerDateRange = DateTime(DateTime.now().toUtc().year,DateTime.now().toUtc().month,DateTime.now().toUtc().day);
    upperDateRange = upperDateRange.add(Duration(days: 30,));
    return (select(todoTasks)..where((item) =>and(
      item.scheduledDateTime.isBiggerOrEqualValue(lowerDateRange),
      item.scheduledDateTime.isSmallerThanValue(upperDateRange),
    ))).watch();
  }

  /// delete a todoSubTask and all its sub tasks using its [id]
  Future<bool> deletedTodoTask(int todoTaskId) async {
    bool isAllOk = true;
    int deleteCount = await (delete(todoSubTasks)..where((item) => item.parentId.equals(todoTaskId))).go();
    if (deleteCount <= 0)
      isAllOk = true;
    else {
      int deleteCount = await(delete(todoTasks)..where((item) => item.id.equals(todoTaskId))).go();
      if (deleteCount <= 0) isAllOk = false;
    }
    return Future.value(isAllOk);
  }

  /// functions to update a [todoTask] using updated [todoTask] object
  Future<bool> updateTodoTask(TodoTask todoTask) async {
    print("\nCALLED updayeTodoTask\n");
    bool isAllOk = true;
    int updateId = await into(todoTasks).insert(todoTask, orReplace: true);
    if (updateId <= 0) isAllOk = false;
    return Future.value(isAllOk);
  }

  // stream of TodoTask list depending on range: "today", "tomorrow", and "month"
  Stream<List<TodoTask>> getTodoTasksList({TodoTaskDateRangeType rangeType = TodoTaskDateRangeType.Today}) {
    DateTime lowerDateRange;
    DateTime upperDateRange;
    Stream<List<TodoTask>> stream;

    switch(rangeType) {
      case TodoTaskDateRangeType.PrevPending:
          lowerDateRange = DateTime.fromMillisecondsSinceEpoch(0).toUtc();
          upperDateRange = DateTime(DateTime.now().toUtc().year,DateTime.now().toUtc().month,DateTime.now().toUtc().day);
          stream = (select(todoTasks)..where((item) => and(and(
            item.scheduledDateTime.isBiggerOrEqualValue(lowerDateRange),
            item.scheduledDateTime.isSmallerThanValue(upperDateRange)),
            item.completed.isSmallerThanValue(100)),
          )).watch();
          print("This is for PrevPending");
        break;
      case TodoTaskDateRangeType.Today:
          upperDateRange = lowerDateRange = DateTime(DateTime.now().toUtc().year,DateTime.now().toUtc().month,DateTime.now().toUtc().day);
          upperDateRange = upperDateRange.add(Duration(days: 1,));
          stream = (select(todoTasks)..where((item) => and(
            item.scheduledDateTime.isBiggerOrEqualValue(lowerDateRange),
            item.scheduledDateTime.isSmallerThanValue(upperDateRange)),
          )).watch();
          print("This is for Today");
        break;
      case TodoTaskDateRangeType.Tomorrow:
          upperDateRange = lowerDateRange = DateTime(DateTime.now().toUtc().year,DateTime.now().toUtc().month,DateTime.now().toUtc().day).add(Duration(days: 1));
          upperDateRange = upperDateRange.add(Duration(days: 1,));
          stream = (select(todoTasks)..where((item) => and(
            item.scheduledDateTime.isBiggerOrEqualValue(lowerDateRange),
            item.scheduledDateTime.isSmallerThanValue(upperDateRange)),
          )).watch();
          print("This is for Tomorrow");
        break;
      case TodoTaskDateRangeType.Month:
          upperDateRange = lowerDateRange = DateTime(DateTime.now().toUtc().year,DateTime.now().toUtc().month,DateTime.now().toUtc().day);
          upperDateRange = upperDateRange.add(Duration(days: 30,));
          stream = (select(todoTasks)..where((item) => and(
            item.scheduledDateTime.isBiggerOrEqualValue(lowerDateRange),
            item.scheduledDateTime.isSmallerThanValue(upperDateRange)),
          )).watch();
          print("This is for Month");
        break;
      case TodoTaskDateRangeType.AllAhead:
          lowerDateRange = DateTime(DateTime.now().toUtc().year,DateTime.now().toUtc().month,DateTime.now().toUtc().day);          
          stream = (select(todoTasks)..where((item) => 
            item.scheduledDateTime.isBiggerOrEqualValue(lowerDateRange),
          )).watch();
          print("This is for AllAhead");
        break;
    }
    return stream;
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //                                                                                                                                 //
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


  /// function to add new to-do [task] with all its [subTaskList] to database
  Future<bool> addNewTodoTask(TodoTask task, List<TodoSubTask> subTaskList) async {
    bool isAllOk = true;
    int taskInsertId = await into(todoTasks).insert(task);
    if (taskInsertId <= 0)
      isAllOk = false;
    else {
      for (int i = 0; i < subTaskList.length; i++) {
        int subTaskInsertId = await into(todoSubTasks).insert(subTaskList[i].copyWith(parentId: taskInsertId, addedOn: DateTime.now().toLocal()));
        print(subTaskInsertId.toString());
      }
    }
    return Future.value(isAllOk);
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //                                                                                                                                 //
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


  /// function that returns a [stream] that watches all to-do Sub task of the given [todoSubId]
  Stream<List<TodoSubTask>> watchTodoSubTask(int todoTaskId) {
    return (select(todoSubTasks)..where((item) => item.parentId.equals(todoTaskId))..orderBy([
      (item) => OrderingTerm(expression: item.completed, mode: OrderingMode.asc)
    ])).watch();
  }

  /// functions to update a [todoSubTask] using [todoSubTaskId] and updated [todoSubTask]
  Future<bool> updateTodoSubTask(int todoSubTaskId, TodoSubTask todoSubTask) async {
    bool isAllOk = true;
    int updateId = await into(todoSubTasks).insert(
        todoSubTask, orReplace: true);
    if (updateId <= 0) isAllOk = false;
    return Future.value(isAllOk);
  }

  /// function to add a new [todoSubTask] into a todoTask using [todoSubTaskId]
  Future<bool> addNewTodoSubTask(int todoSubTaskId, TodoSubTask todoSubTask) async {
    bool isAllOk = true;
    int insertId = await into(todoSubTasks).insert(
        todoSubTask, orReplace: true);
    if (insertId <= 0) isAllOk = false;
    return Future.value(isAllOk);
  }

  /// function to delete a todoSubTask by object [todoSubTask]
  Future<bool> deleteTodoSubTaskByItem(TodoSubTask todoSubTask) async => await deleteTodoSubTaskById(todoSubTask.id);

  /// function to delete a todoSubTask by its [id]
  Future<bool> deleteTodoSubTaskById(int todoSubTaskId) async {
    bool isAllOk = true;
    int deleteCount = await (delete(todoSubTasks)
      ..where((item) => item.id.equals(todoSubTaskId))).go();
    if (deleteCount < 0) isAllOk = false;    
    return Future.value(isAllOk);
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //                                                                                                                                 //
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  /// function to watch(stream) all [Note]'s list
  Stream<List<Note>> watchAllNotes() {
    return select(notes).watch();
  }

  /// function to watch(stream) all [NoteSubItem] list of a [Note] using note's [id]
  Stream<List<NoteSubItem>> watchAllSubNoteItems(int noteId) {
    return (select(noteSubItems)..where((item) => item.parentId.equals(noteId))).watch();
  }

  /// function to future(get) all [NoteSubItem] list of a [Note] using note's [id]
  Future<List<NoteSubItem>> getAllSubNoteItems(int noteId) {
    return (select(noteSubItems)..where((item) => item.parentId.equals(noteId))).get();
  }

  /// function to add new [Note] (containing text, audio and images sub notes)
  Future<int> addOrUpdateNewNote(Note note) async {            
    return await into(notes).insert(note, orReplace: true);
  }

  Future<int> addOrUpdateNewNoteSubItem(int noteId, NoteSubItem subItem) async {
    int insertId = -1;
    try {
      insertId = await into(noteSubItems).insert(subItem, orReplace: true);
    } catch (e) {
      print("Exception occured in inserting subItem, for note id = "+noteId.toString());
      insertId = -1;
    }
    return insertId;
  }

  ///watch any changes [NoteSubItem] using provided noteSubItem [id]
  Stream<NoteSubItem> watchNoteSubItem(int id) {
    return (select(noteSubItems)..where((item) =>item.id.equals(id))).watchSingle();
  }

  /// function to delete [NoteSubItem] using note sub item [id]
  Future<int> deleteNoteSubItem(int noteSubId) async {
    return await  (delete(noteSubItems)..where((item) => item.id.equals(noteSubId))).go();
  }

  /// function to delete ALL [NoteSubItem]'s using parent note's [id]
  Future<int> deleteAllNoteSubItem(int parentNoteId) async {
    return await (delete(noteSubItems)..where((item) => item.parentId.equals(parentNoteId))).go();
  }

  /// function to delete [Note] and all its [NoteSubItem]s using Note's [id]
  Future<bool> deleteNoteAndNoteSubItems(int noteId) async {
    await deleteAllNoteSubItem(noteId);
    await (delete(notes)..where((item) => item.id.equals(noteId))).go();
    return Future.value(true);
  }

}


