import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:persno_manage/AppThemeBloc/bloc.dart';
import 'package:persno_manage/Database/Database.dart';
import 'package:persno_manage/global/PersnoManageGlobal.dart';

// ignore: must_be_immutable
class AudioNoteWidget extends StatefulWidget {
  // ignore: avoid_init_to_null
  String filename = null;
  int durationInMilliSeconds = 0;
  String recorderTime = "00:00:000";
  bool isPlaying = false,  recordingCompleted = false, recordingStarted = false; 
  FlutterSound player = FlutterSound();

  NoteSubItem noteSubItem;

  AudioNoteWidget.fromNoteSubItem(this.noteSubItem) {
    recordingCompleted = true;
    recordingStarted = true;
    filename = noteSubItem.body.trim();
    print("AudioNote Id = "+noteSubItem.id.toString());
  }
  
  // ignore: avoid_init_to_null
  AudioNoteWidget({Key key, int parentNoteId}) : super(key: key);

  @override
  _AudioNoteWidgetState createState() => _AudioNoteWidgetState();
}

class _AudioNoteWidgetState extends State<AudioNoteWidget> with AutomaticKeepAliveClientMixin{

  @override bool get wantKeepAlive => true;  
  DateTime startTime;


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget> [
          
          if(widget.recordingCompleted) Container(
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(15),
              color: (AppThemeBloc().darkModeOn)?Colors.greenAccent.shade700:Colors.indigo,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(width: 8),
                Container(
                  child: Text(widget.recorderTime, style: Theme.of(context).textTheme.subhead.copyWith(color: Colors.white),),
                ),
                Container(width: 8),
                InkWell(
                  child: Icon(widget.isPlaying?Icons.pause:Icons.play_arrow, size: 30, color: Colors.white,),
                  onTap: () async {
                    if(!widget.player.isPlaying) {
                      await widget.player.startPlayer(PersnoManageGlobal.storagePath+"/"+widget.filename);
                      widget.player.onPlayerStateChanged.listen((status) {
                        if(status!=null) {
                          setState(() {
                            var tempTime = DateTime.fromMillisecondsSinceEpoch(status.currentPosition.toInt(), isUtc: true);
                            widget.recorderTime = formatDate(tempTime, [nn,":",ss,":",SSS]);
                            
                          });
                        }
                      });
                      widget.isPlaying = widget.player.isPlaying;
                    } else {
                      if(widget.player.isPlaying) {
                        if(widget.isPlaying) {
                          await widget.player.pausePlayer();
                          widget.isPlaying = false;
                        } else {
                          await widget.player.resumePlayer();
                          widget.isPlaying = true;
                        }
                        setState(() {});
                      }
                    }
                  }
                ),
                Container(width: 8),
                InkWell(
                  child: Icon(Icons.stop, size: 30, color: Colors.white,),
                  onTap: () async {
                    if(widget.player.isPlaying) {
                      print("Is Playing");
                      await widget.player.pausePlayer();
                      await widget.player.stopPlayer();
                    }
                    setState(() {
                      widget.recorderTime = "00:00:000";
                    });
                  }
                ),
                Container(width: 8),
              ],
            )
          )
        ],
      )
    );
  }

  @override void dispose() async {
    if(widget.player.isRecording) await widget.player.stopRecorder();
    if(widget.player.isPlaying) {
      widget.player.pausePlayer();
      widget.player.stopPlayer();
    }
    super.dispose();
  }
}



  // @override
  // void initState() {
    // super.initState();
    // // if(!widget.recordingCompleted) startRecording();
  // }



  // startRecording() async {
  //   startTime = DateTime.now().toLocal();
  //   widget.filename = startTime.toString();
  //   widget.filename = widget.filename.split('.')[0].replaceAll(':', '-').replaceAll(' ', '_');
  //   widget.filename += ".m4a";
  //   print("FileName = "+widget.filename.toString());
  //   await Future.sync(() async {
  //     print(await widget.recorder.startRecorder("persnoManage/"+widget.filename, androidEncoder: AndroidEncoder.HE_AAC, sampleRate: 96000,));
  //   });
  //     widget.recorder.onRecorderStateChanged.listen((RecordStatus date) {
  //     if(date!=null) {
  //       setState(() {
  //         widget.durationInMilliSeconds = date.currentPosition.toInt();
  //         DateTime tempTime = DateTime.fromMillisecondsSinceEpoch(widget.durationInMilliSeconds.toInt(), isUtc: true);
  //         widget.recorderTime = formatDate(tempTime, [nn,":",ss,":",SSS]);
  //       });
  //     }
  //   });
  //   widget.recordingStarted = true;
  // }




          // if(!widget.recordingCompleted) InkWell(
          //   splashColor: !(AppThemeBloc().darkModeOn)?Colors.greenAccent.shade700:Colors.indigo,
          //   borderRadius: BorderRadius.circular(100),
          //   child: Container(
          //     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(15),
          //       border: Border.all(color: Theme.of(context).primaryColor),
          //       color: (AppThemeBloc().darkModeOn)?Colors.greenAccent.shade700:Colors.indigo,
          //     ),
          //     alignment: Alignment.center,
          //     child: Row(
          //       mainAxisSize: MainAxisSize.min,
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: <Widget>[
          //        Container(
          //           margin: const EdgeInsets.symmetric(horizontal: 10),
          //           child: Text(widget.recorderTime, style: Theme.of(context).textTheme.subhead.copyWith(color: Colors.white),),
          //        ),
          //         Container(child: Icon(!widget.recordingStarted?Icons.mic:Icons.stop, size: 30, color: Colors.white,),),
          //       ],
          //     ),
          //   ),
          //   onTap: () async {
          //     await widget.recorder.stopRecorder();
          //     int insertId = await PersnoManageGlobal.database.addOrUpdateNewNoteSubItem(widget.noteSubItem.parentId, widget.noteSubItem.copyWith(body: widget.filename));
          //     widget.noteSubItem = widget.noteSubItem.copyWith(id: insertId, body: widget.filename);
          //     widget.recorder = null;
          //     widget.recorder = FlutterSound();
          //     setState(() {
          //       widget.recordingCompleted = true;
          //       widget.recorderTime = "00:00:000";
          //     });
          //     AddNewNote.of(context).updateList();
          //   }
          // ),