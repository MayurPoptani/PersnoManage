
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persno_manage/Pages/Calendar/CalendarPage.dart';
import 'package:persno_manage/Pages/Notes/Notes.dart' as NotesPage;
import 'package:persno_manage/global/Permissions.dart';
import 'package:persno_manage/global/PersnoManageGlobal.dart';
import 'package:persno_manage/widgets/HomePageGridViewCustomCard.dart';
import 'AppThemeBloc/bloc.dart';
import 'Database/Database.dart';
import 'Pages/Todo/Todo.dart';
import 'widgets/myScaffold.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

void main() async {
  bool storagePermissionGranted = await checkExtStoragePermission(requestIfNoteGranted: true); 
  if(storagePermissionGranted) {
    Directory dir = await pathProvider.getExternalStorageDirectory();
    await PersnoManageGlobal.initializeStorage(dir.parent.parent.parent.parent.path+"/PersnoManage");
    print("PathStorage = "+PersnoManageGlobal.storagePath);
    print("DatabasePath = "+PersnoManageGlobal.databasePath);
    runApp(MyApp());
  } else {
    print("Exiting App");
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: AppThemeBloc(),
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: state.darkModeOn?ThemeMode.dark:ThemeMode.light,          
          theme: ThemeData(
            platform: TargetPlatform.android,
            primaryColor: state.darkModeOn?Colors.white:Colors.black,
            accentColor: !state.darkModeOn?Colors.white:Colors.black,
            buttonColor: Colors.black,
            textTheme: TextTheme(
              title: TextStyle(color: Colors.black.withOpacity(0.7)),
              subtitle: TextStyle(color: Colors.black.withOpacity(0.7)),              
              body1: TextStyle(color: Colors.black.withOpacity(0.7)),
              body2: TextStyle(color: Colors.black.withOpacity(0.7)),
              display1: TextStyle(color: Colors.black.withOpacity(0.7)),
              display2: TextStyle(color: Colors.black.withOpacity(0.7)),
              display3: TextStyle(color: Colors.black.withOpacity(0.7)),
              display4: TextStyle(color: Colors.black.withOpacity(0.7)),
              caption: TextStyle(color: Colors.black.withOpacity(0.7)),
              headline: TextStyle(color: Colors.black.withOpacity(0.7)),
              subhead: TextStyle(color: Colors.black.withOpacity(0.7)),
            ),
            iconTheme: IconThemeData(color: Colors.black.withOpacity(0.7), ),
            scaffoldBackgroundColor: Colors.white.withOpacity(0.95),
            cardColor: Colors.white,
            cardTheme: CardTheme(color: Colors.white, elevation: 5, ),
            appBarTheme: AppBarTheme(color: Colors.transparent, brightness: Brightness.light)
          ),  
          darkTheme: ThemeData(
            platform: TargetPlatform.android,
            primaryColor: state.darkModeOn?Colors.white:Colors.black,
            accentColor: !state.darkModeOn?Colors.white:Colors.black,
            buttonColor: Colors.white,
            textTheme: TextTheme(
              title: TextStyle(color: Colors.white),
              subtitle: TextStyle(color: Colors.white),
              body1: TextStyle(color: Colors.white),
              body2: TextStyle(color: Colors.white),
              display1: TextStyle(color: Colors.white),
              display2: TextStyle(color: Colors.white),
              display3: TextStyle(color: Colors.white),
              display4: TextStyle(color: Colors.white),
              caption: TextStyle(color: Colors.white),
              headline: TextStyle(color: Colors.white),
              subhead: TextStyle(color: Colors.white),
            ),
            iconTheme: IconThemeData(color: Colors.white, ),
            scaffoldBackgroundColor: Color.fromRGBO(36, 33, 50, 1),
            cardColor: Color.fromRGBO(55,50,77,1),
            cardTheme: CardTheme(color: Color.fromRGBO(55,50,77,1), elevation: 3, ),
            appBarTheme: AppBarTheme(color: Colors.transparent, brightness: Brightness.dark, ),
          ),
          routes: {
            Todo.routeName : (BuildContext context) => Todo(),
            NotesPage.Notes.routeName: (BuildContext context) => NotesPage.Notes(),
            CalendarPage.routeName: (BuildContext context) => CalendarPage(),
          },
          home: PersnoManage(),
        );
      },
    );
  }
}

class PersnoManage extends StatefulWidget {
  static final String routeName = "/";
  PersnoManage({Key key}) : super(key: key);
  _PersnoManageState createState() => _PersnoManageState();
}

class _PersnoManageState extends State<PersnoManage> {

  Stream<List<TodoTask>> todoTask30DaysListStream;
  int todoTask30DaysListCount = 0;

  @override
  void initState() {
    todoTask30DaysListStream = PersnoManageGlobal.database.getTodoTaskCount();
    todoTask30DaysListStream.listen((data) {
      setState(() {
        todoTask30DaysListCount = data.length;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 10, right: 20, left: 20, bottom: 0),        
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(5),
              child: Text("Hey Mike", style: Theme.of(context).textTheme.display1),
            ),
            Container(padding: const EdgeInsets.all(10)),
            Expanded(
              child: GridView.count(
                padding: const EdgeInsets.only(bottom: 10, left: 5, right: 5, ),
                crossAxisCount: 2,
                shrinkWrap: true,
                children: <Widget>[
                  HomePageGridViewCustomCard(
                    color: AppThemeBloc().darkModeOn?
                      HomePageGridViewCustomCard.darkThemeCardColors[0]
                      :HomePageGridViewCustomCard.lightThemeCardColors[0],
                    icon: Icon(Icons.list, size: 35, color: Colors.white),
                    title: "To Do",
                    subTitle: todoTask30DaysListCount.toString()+" lists for 30 days",
                    onPressed: () {
                      Navigator.of(context).pushNamed(Todo.routeName);
                    },
                  ),
                  HomePageGridViewCustomCard(
                    color: AppThemeBloc().darkModeOn? HomePageGridViewCustomCard.darkThemeCardColors[1]:HomePageGridViewCustomCard.lightThemeCardColors[1],
                    icon: Icon(Icons.featured_play_list, size: 30, color: Colors.white),
                    title: "Notes",
                    subTitle: "4 items",
                    onPressed: () {
                      Navigator.of(context).pushNamed(NotesPage.Notes.routeName);
                    },
                  ),
                  HomePageGridViewCustomCard(
                    color: AppThemeBloc().darkModeOn?
                      HomePageGridViewCustomCard.darkThemeCardColors[2]
                      :HomePageGridViewCustomCard.lightThemeCardColors[2],
                    icon: Icon(Icons.calendar_today, size: 30, color: Colors.white),
                    title: "Calendar",
                    subTitle: "11 events",
                    onPressed: () {
                      Navigator.of(context).pushNamed(CalendarPage.routeName);
                    },
                  ),
                  HomePageGridViewCustomCard(
                    color: AppThemeBloc().darkModeOn?
                      HomePageGridViewCustomCard.darkThemeCardColors[3]
                      :HomePageGridViewCustomCard.lightThemeCardColors[3],
                    icon: Icon(Icons.account_balance_wallet, size: 30, color: Colors.white),
                    title: "Subsciptions",
                    subTitle: "3 things",
                    onPressed: () {},
                  ),
                  Card(
                    child: Icon(Icons.add, )
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
