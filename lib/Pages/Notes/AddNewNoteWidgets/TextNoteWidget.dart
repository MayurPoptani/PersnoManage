import 'package:flutter/material.dart';
import 'package:persno_manage/Database/Database.dart';
import 'package:persno_manage/global/PersnoManageGlobal.dart';

// ignore: must_be_immutable
class TextNoteWidget extends StatefulWidget {

  NoteSubItem noteSubItem;

  TextEditingController controller;
  final FocusNode focusNode = FocusNode();

  TextNoteWidget.fromNoteSubItem(this.noteSubItem) {
    controller = TextEditingController(text: noteSubItem.body);
    print("TextNote Id = "+noteSubItem.id.toString());
  }

  TextNoteWidget({Key key, String initialText, int subNoteId, @required int parentNoteId, DateTime saveDateTime}) : super(key: key) {    
    controller = TextEditingController(text: initialText);
    noteSubItem = NoteSubItem(
      type: NoteSubItemType.Text,
      id: subNoteId,
      parentId: parentNoteId,
      body: initialText??"",
      saveDateTime: saveDateTime??DateTime.now().toUtc(),
    );
  }

  @override
  _TextNoteWidgetState createState() => _TextNoteWidgetState();
}

class _TextNoteWidgetState extends State<TextNoteWidget> with AutomaticKeepAliveClientMixin{

  NoteSubItem item;

  @override bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {    
    super.build(context);
    return Container(
      child: mainWidget(),
    );
  }

  Widget mainWidget() {
    return TextField(
      controller: widget.controller,
      minLines: 1, maxLines: null,
      focusNode: widget.focusNode,
      decoration: InputDecoration(
        hintText: "Add Text Here",
        hintStyle: TextStyle(color: Theme.of(context).iconTheme.color.withOpacity(0.5)),
        border: OutlineInputBorder(borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8)
      ),
      onChanged: (text) async {
        print("NewText = "+text);
        int insertId = await PersnoManageGlobal.database.addOrUpdateNewNoteSubItem(widget.noteSubItem.parentId, widget.noteSubItem.copyWith(body: text));
        widget.noteSubItem = widget.noteSubItem.copyWith(id: insertId);
      },
    );
  }
}
