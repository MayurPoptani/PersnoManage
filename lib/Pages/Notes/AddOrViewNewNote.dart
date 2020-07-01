import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_sound/android_encoder.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:persno_manage/AppThemeBloc/bloc.dart';
import 'package:persno_manage/Database/Database.dart';
import 'package:persno_manage/global/PersnoManageGlobal.dart';
import 'package:persno_manage/widgets/myScaffold.dart';
import '../../global/Permissions.dart';
import 'AddNewNoteWidgets/AudioNoteWidget.dart';
import 'AddNewNoteWidgets/ImageNoteWidget.dart';
import 'AddNewNoteWidgets/TextNoteWidget.dart';

enum AddNewNoteState {Audio, Text}

class AddOrViewNewNote extends StatefulWidget {  
  final AddNewNoteState initialState;
  final int noteId;    

  AddOrViewNewNote({Key key, this.noteId = -1, this.initialState = AddNewNoteState.Text}) : super(key: key);

  static _AddOrViewNewNoteState of(BuildContext context) => context.ancestorStateOfType(TypeMatcher<_AddOrViewNewNoteState>());

  @override _AddOrViewNewNoteState createState() => _AddOrViewNewNoteState();
}

class _AddOrViewNewNoteState extends State<AddOrViewNewNote> {

  List<Widget> notesWidgetsList = List();
  FlutterSound flutterSound = FlutterSound();
  bool isRecorderOpen = false;
  ScrollController _controller = ScrollController();
  bool showOptions = false;
  String recorderFileName;
  String recorderTime = "00:00:000";

  @override void initState() {    
    if(widget.initialState!=null) { print("INIT STATE NOT NULL");
      if(widget.initialState==AddNewNoteState.Text) {
        notesWidgetsList.add(TextNoteWidget(parentNoteId: widget.noteId,));
      } else if(widget.initialState==AddNewNoteState.Audio) {
        showRecorder();
      }
    } else { print("INIT STATE NULL, calling() UpdateList");
      updateList();
    }
    super.initState();
  }

  Future<bool> onWillPop() async {
    bool retVal = true;
    print("Called onWillPop() of WillPopScope");
    // if(isRecorderOpen) {
    //   await stopRecorder();
    //   return Future.value(false);
    // }
    // else 
    if(notesWidgetsList.length==1) {
      print("Length is 1");
      if(notesWidgetsList[0] is TextNoteWidget) {
        print("Note is TextNoteWidget");
        if((notesWidgetsList[0] as TextNoteWidget).controller.text.trim().length==0) {
          print("String is empty");
          await PersnoManageGlobal.database.deleteNoteAndNoteSubItems(widget.noteId);
        }
      }
      retVal = true;
    }
    return Future.value(retVal);
  }

  @override void dispose() async {
    await onWillPop();
    super.dispose();
  }

  @override Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if(isRecorderOpen) {
          await stopRecorder();
          return Future.value(false);
        }
        else return await onWillPop();
      },
      child: GestureDetector(
        onTap: () {},
        onVerticalDragStart: (detail) {setState(() => showOptions = false);},
        onHorizontalDragStart: (detail) {setState(() => showOptions = false);},
        child: Stack(
          children: <Widget>[
            MyScaffold(
              body: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(height: 10),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text("Hey Mike", style: Theme.of(context).textTheme.display1),
                          Text("Add your new todo note", style: Theme.of(context).textTheme.subhead),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        controller: _controller,
                        padding: const EdgeInsets.symmetric(horizontal: 10 ),
                        itemCount: notesWidgetsList.length??0,
                        itemBuilder: (_,i) {
                          print("Length = "+notesWidgetsList.length.toString());
                          return Container(
                            color: Colors.transparent,
                            width: double.maxFinite,
                            child: Slidable(
                              actionPane: SlidableScrollActionPane(),
                              actionExtentRatio: 0.15,                              
                              secondaryActions: <Widget>[
                                IconSlideAction(
                                  foregroundColor: Colors.white,
                                  color: Colors.deepOrange,                                  
                                  icon: Icons.delete,
                                  caption: "Delete",
                                  onTap: () async {
                                    int id = -1;
                                    if(notesWidgetsList[i] is TextNoteWidget) {
                                      id = (notesWidgetsList[i] as TextNoteWidget).noteSubItem.id;
                                    } else if(notesWidgetsList[i] is AudioNoteWidget) {
                                      id = (notesWidgetsList[i] as AudioNoteWidget).noteSubItem.id;
                                    } else if(notesWidgetsList[i] is ImageNoteWidget) {
                                      id = (notesWidgetsList[i] as ImageNoteWidget).noteSubItem.id;
                                    }
                                    if(id!=-1) {
                                      await PersnoManageGlobal.database.deleteNoteSubItem(id);
                                      updateList();
                                    }
                                    
                                  },
                                ),
                              ],
                              child: notesWidgetsList[i],
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: addNewNoteRow(),
                    )
                  ],
                ),
              ),
            ),
            if(isRecorderOpen) topLevelAudioRecorderWidget(),
            if(showOptions) optionFloatingButtons(),
          ],
        ),
      ),
    );
  }

  int x = 10, y = 10;

  Widget optionFloatingButtons() {
    return Positioned(
      top: y.toDouble()-25,
      left: x.toDouble(),
      child: Container(
        height: 50,
        color: Colors.transparent,
        child: Card(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(Icons.arrow_back),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {},
              )
            ],
          )
        )
      ),
    );
  }

  Widget addNewNoteRow() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        // icon button to add a new photos item
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          child: InkWell(
            borderRadius: BorderRadius.circular(100),
            child: IconButton(icon: Icon(Icons.add_photo_alternate, color: Theme.of(context).primaryColor, size: 30),
              onPressed: addNewImageSubNote,
            ),
          ),
        ),        
        // icon button to add a new recording item
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          child: IconButton(
            icon: Icon(Icons.record_voice_over, color: Theme.of(context).primaryColor, size: 30),
            onPressed: addNewAudioSubNote,
          ),
        ),        
        // icon button to add a new text item
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          child: IconButton(
            icon: Icon(Icons.text_fields, color: Theme.of(context).primaryColor, size: 30),
            onPressed: addNewTextSubNote,
          ),
        ),
      ],
    );
  }

  Widget topLevelAudioRecorderWidget() {
    return StatefulBuilder(builder: (_,stateSetter) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget> [
          Expanded(child: Container(
            color: Colors.white.withOpacity(AppThemeBloc().darkModeOn?0.25:0.5),
          )),
          Container(
            color: Colors.white.withOpacity(AppThemeBloc().darkModeOn?0.25:0.5),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              color: AppThemeBloc().darkModeOn?Colors.white:Color.fromRGBO(55,50,77,1),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Text(recorderTime, style: Theme.of(context).textTheme.display1.copyWith(color: AppThemeBloc().darkModeOn?Colors.black:Colors.white)),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                          child: FlatButton(
                            child: Text("Save", style: Theme.of(context).textTheme.subtitle.copyWith(color: AppThemeBloc().darkModeOn?Colors.black:Colors.white)),
                            onPressed: stopRecorder,
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                          )
                        )
                      ],
                    )
                  ],
                )
              ),
            ),
          )
        ],
      );
    });
  }

  Future<void> stopRecorder() async {
    flutterSound.stopRecorder();
    if(notesWidgetsList.length>0) {
      if((notesWidgetsList.last as TextNoteWidget).controller.text.trim().isEmpty && (notesWidgetsList.last as TextNoteWidget).noteSubItem.id!=null) {
        await PersnoManageGlobal.database.deleteNoteSubItem((notesWidgetsList.last as TextNoteWidget).noteSubItem.id);
      }
    }
    PersnoManageGlobal.database.addOrUpdateNewNoteSubItem(widget.noteId, NoteSubItem(
      id: null,
      body: recorderFileName,
      parentId: widget.noteId,
      saveDateTime: DateTime.now().toUtc(),
      type: NoteSubItemType.Audio,
    ));                              
    isRecorderOpen = false;
    updateList(scrollToEnd: true);
  }

  void addNewTextSubNote() => setState(() {
    FocusScope.of(context).requestFocus((notesWidgetsList.last as TextNoteWidget).focusNode);
    _controller.jumpTo(_controller.position.maxScrollExtent);
  });

  void addNewImageSubNote() async {
    try{
      List<Asset> list = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true,
        materialOptions: MaterialOptions(
          selectionLimitReachedText: "Max 10 Images Can Be Selected",
          actionBarTitle: "Pick Images",          
        ),
      );
      
      List<String> imageFilesPaths = [];
      for(int i = 0 ; i < list.length ; i++) {
        String tempFilePath = await list[i].filePath;
        imageFilesPaths.add(tempFilePath);
      }
      int temp = await PersnoManageGlobal.database.addOrUpdateNewNoteSubItem(widget.noteId, NoteSubItem(
        id: null,
        parentId: widget.noteId,
        body: imageFilesPaths.toString(),
        saveDateTime: DateTime.now().toUtc(),
        type: NoteSubItemType.Image,
      ));
      print("Image Inset Id = "+temp.toString());      
    } on NoImagesSelectedException catch (e)  {
      print("\"NoImagesSelectedException\" Occured. Error Message = "+e.message);
      return;
    } on Exception catch(e) {
      print("Unknown Exception Occured. Error String = "+e.toString());
    } finally {      
      updateList(scrollToEnd: true);
      // _controller.jumpTo(_controller.position.maxScrollExtent);
    }
  }

  void addNewAudioSubNote() async {
    bool hasPermission = await checkMicrophonePermission(requestIfNoteGranted: true);
    setState(() {
      if(hasPermission) setState(() {
        showRecorder();
      });
    });
  }  

  void showRecorder() async {
    isRecorderOpen = true;
    var startTime = DateTime.now().toLocal();
    recorderFileName = startTime.toString();
    recorderFileName = recorderFileName.split('.')[0].replaceAll(':', '-').replaceAll(' ', '_');
    recorderFileName += ".m4a";
    print("FileName = " + recorderFileName.toString());
    await Future.sync(() async {
      print(await flutterSound.startRecorder("persnoManage/"+recorderFileName, androidEncoder: AndroidEncoder.HE_AAC, sampleRate: 96000,));
    });
      flutterSound.onRecorderStateChanged.listen((RecordStatus date) {
      if(date!=null) {
        setState(() {
          DateTime tempTime = DateTime.fromMillisecondsSinceEpoch(date.currentPosition.toInt(), isUtc: true);
          recorderTime = formatDate(tempTime, [nn,":",ss,":",SSS]);
        });
      }
    });

  }
  
  void updateList({bool scrollToEnd = false}) async {
    notesWidgetsList.clear();
    List<NoteSubItem> temp = await PersnoManageGlobal.database.getAllSubNoteItems(widget.noteId);
    temp.forEach((item) {
      if(item.type == NoteSubItemType.Audio) {
        notesWidgetsList.add(AudioNoteWidget.fromNoteSubItem(item));
      } else if(item.type == NoteSubItemType.Text) {
        notesWidgetsList.add(TextNoteWidget.fromNoteSubItem(item));
      } else if(item.type == NoteSubItemType.Image) {
        notesWidgetsList.add(ImageNoteWidget.fromNoteSubItem(item));
      }
    });
    if(temp.isNotEmpty) { print("TEMP NOT EMPTY");
      if(temp.last.type!=NoteSubItemType.Text) { print("LAST ITEM NOT TEXT");
        notesWidgetsList.add(TextNoteWidget(parentNoteId: widget.noteId, ));
      }
    } else { print("TEMP IS EMPTY");
      notesWidgetsList.add(TextNoteWidget(parentNoteId: widget.noteId, ));
    }
    setState(() {});
    if(scrollToEnd) _controller.jumpTo(_controller.position.maxScrollExtent);
  }

}


