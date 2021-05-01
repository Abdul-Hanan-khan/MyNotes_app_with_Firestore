import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class EditNote extends StatefulWidget {
  DocumentSnapshot docToEdit;

  EditNote(this.docToEdit); // EditNote({this.docToEdit});
  @override
  _EditNoteState createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  @override
  void initState() {
    title=TextEditingController(text: widget.docToEdit.get('title'));
    content=TextEditingController(text: widget.docToEdit.get('content'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        actions: <Widget>[
          FlatButton(
            child: Text("Update"),
            onPressed: () {
              
              widget.docToEdit.reference.update({
                'title': title.text,
                'content': content.text,
              }).whenComplete(() => Navigator.pop(context));
            },
          ),

          FlatButton(
            child: Text("Delete"),
            onPressed: () {

              widget.docToEdit.reference.delete().whenComplete(() => Navigator.pop(context));
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(7),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(),
                borderRadius: BorderRadius.circular(7)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: title,
                decoration: InputDecoration(hintText: "Title"),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(7),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: content,
                  maxLines: null,
                  expands: true,
                  decoration: InputDecoration(hintText: "Content"),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
