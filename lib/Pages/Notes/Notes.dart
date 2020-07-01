import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:persno_manage/AppThemeBloc/bloc.dart';
import 'package:persno_manage/Database/Database.dart';
import 'package:persno_manage/Pages/Notes/AddOrViewNewNote.dart';
import 'package:persno_manage/global/PersnoManageGlobal.dart';
import 'package:persno_manage/widgets/myScaffold.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


class Notes extends StatefulWidget {
  static _NotesState of(BuildContext context) {
    return context.ancestorStateOfType(TypeMatcher<_NotesState>());
  }
  static final String routeName = "/Notes";
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  bool addMenuOpen = false;
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(height: 00),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("Hey Mike", style: Theme.of(context).textTheme.display1),
                  Text("These are your notes", style: Theme.of(context).textTheme.subhead),
                ],
              ),
            ),
            Padding(padding: const EdgeInsets.all(5),),
            Expanded(
              child: StreamBuilder<List<Note>>(
                stream: PersnoManageGlobal.database.watchAllNotes(),
                initialData: [],
                builder: (_, snapshot) {
                  if(snapshot.hasData) {
                    return snapshot.data.length>0?StaggeredGridView.countBuilder(
                      crossAxisCount: 4,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      shrinkWrap: true,
                      addAutomaticKeepAlives: true,
                      padding: const EdgeInsets.all(5),
                      staggeredTileBuilder: (int index) => new StaggeredTile.count(2, (index != 0) ? index % (9) == 0 ? 1.50 : 1.75 : 2),
                      itemCount: snapshot.data.length,
                      itemBuilder: (_, index) {
                        return InkWell(
                          child: Card(
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(snapshot.data[index].saveDateTime.toString()),
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => AddOrViewNewNote(noteId: snapshot.data[index].id, initialState: null,)
                            ));
                          }
                        );
                      }
                    ) : Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: Theme.of(context).textTheme.title,
                          text: "No Notes Yet\n",
                          children: [
                            TextSpan(
                              style: Theme.of(context).textTheme.body1,
                              text: "Tap On"
                            ),
                            TextSpan(text: " + "),
                            TextSpan(
                              style: Theme.of(context).textTheme.body1,
                              text: "Button At Bottom-Right To Add A Note"
                            )
                          ]
                        ),
                      )
                    );
                  } else {
                    return Container();
                  }
                },
              )
            ),
          ],
        ),
      ),
      floatingActionButton: getMultiFabWidget(),
    );
  }

  Widget getMultiFabWidget() {
    return StatefulBuilder(builder: (_, stateSetter) {
      return SpeedDial(
        animatedIcon: null,
        child: Icon(addMenuOpen ? Icons.close : Icons.add, color: Colors.white),
        backgroundColor: (AppThemeBloc().darkModeOn) ? Colors.greenAccent.shade700 : Colors.indigo,
        onOpen: () => stateSetter(() => addMenuOpen = true),
        onClose: () => stateSetter(() => addMenuOpen = false),
        children: [
          SpeedDialChild(
            child: Icon(Icons.text_fields, color: Colors.white),
            backgroundColor: (AppThemeBloc().darkModeOn) ? Colors.greenAccent.shade700 : Colors.indigo,
            onTap: () async {
              int insertId = await PersnoManageGlobal.database.addOrUpdateNewNote(
                Note(id: null, title: "", subItemCount: 0, saveDateTime: DateTime.now().toUtc(), updateDateTime: DateTime.now().toUtc(),
              ));
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => AddOrViewNewNote(noteId: insertId, initialState: AddNewNoteState.Text,)));
            }
          ),
          SpeedDialChild(
            child: Icon(Icons.mic, color: Colors.white),
            backgroundColor: (AppThemeBloc().darkModeOn) ? Colors.greenAccent.shade700 : Colors.indigo,
            onTap: () async {
              int insertId = await PersnoManageGlobal.database.addOrUpdateNewNote(
                Note(id: null, title: "", subItemCount: 1, saveDateTime: DateTime.now().toUtc(), updateDateTime: DateTime.now().toUtc(),
              ));
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => AddOrViewNewNote(noteId: insertId, initialState: AddNewNoteState.Audio,)));
            }
          ),
        ],
      );
    });
  }

}