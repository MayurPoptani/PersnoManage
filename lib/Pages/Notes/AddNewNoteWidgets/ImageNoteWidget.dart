import 'dart:io';
import 'package:flutter/material.dart';
import 'package:persno_manage/Database/Database.dart';
import 'package:persno_manage/global/PersnoManageGlobal.dart';

// ignore: must_be_immutable
class ImageNoteWidget extends StatefulWidget  {
    
  List<String> imageFilesPaths;

  NoteSubItem noteSubItem;

  ImageNoteWidget.fromNoteSubItem(this.noteSubItem) {    
    imageFilesPaths = noteSubItem.body.substring(1,noteSubItem.body.length-1).split(',');
    print("ImageNote Id = "+noteSubItem.id.toString());
  }

  // ignore: avoid_init_to_null
  ImageNoteWidget({Key key, int subNoteId = null, @required int parentNoteId, this.imageFilesPaths, DateTime saveDateTime}) : super(key: key) {
    print("Got imageAssets with count = "+imageFilesPaths.length.toString());
    noteSubItem = NoteSubItem(
      id: subNoteId,
      body: imageFilesPaths.toString(),
      parentId: parentNoteId,
      saveDateTime: saveDateTime,
      type: NoteSubItemType.Image,
    );
  }

  @override
  _ImageNoteWidgetState createState() => _ImageNoteWidgetState();
}

class _ImageNoteWidgetState extends State<ImageNoteWidget> with AutomaticKeepAliveClientMixin{ 

  @override
  void initState() { 
    super.initState();
    initialize();
  }

  void initialize() async {
    if(widget.noteSubItem.id==null) {
      int insertId = await PersnoManageGlobal.database.addOrUpdateNewNoteSubItem(widget.noteSubItem.parentId, widget.noteSubItem);
      widget.noteSubItem = widget.noteSubItem.copyWith(id: insertId);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    print("Count = "+widget.imageFilesPaths.length.toString()??"NULL");
    super.build(context);
    return Container(
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        addAutomaticKeepAlives: true,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,),
        itemCount: widget.imageFilesPaths.length,
        itemBuilder: (_,index) {
          return Card(
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            margin: const EdgeInsets.all(2),
            child: Container(              
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.file(File(widget.imageFilesPaths[index].trim()), fit: BoxFit.cover, filterQuality: FilterQuality.none,),
              ),
            ),
          );
        },
      ),
    );
  }

  @override bool get wantKeepAlive => true;

}

/*
              // FutureBuilder(
              //   future: widget.imageAssets[index].filePath,
              //   builder: (_, AsyncSnapshot<String> snapshot) {
              //     if(snapshot.hasData) {
              //       print("Snapshot of Item["+(index+1).toString()+"] HAD DATA");
              //       return ClipRRect(
              //         borderRadius: BorderRadius.circular(15),
              //         child: Image.memory(File(snapshot.data).readAsBytesSync(), fit: BoxFit.cover, filterQuality: FilterQuality.none,),
              //       );
              //     } else {
              //       print("Snapshot of Item["+(index+1).toString()+"] NO DATA YET");
              //       return Container(
              //         alignment: Alignment.center,
              //         child: CircularProgressIndicator(),
              //       );
              //     }
              //   },
              // )
*/