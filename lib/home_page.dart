import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_crud/add_note.dart';
import 'package:firestore_crud/edit_note.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  CollectionReference ref = FirebaseFirestore.instance.collection("Notes");

  @override
  Widget build(BuildContext context) {
    Color white = Colors.white;
    Color grey = Colors.grey[300];
    // Color white=Colors.white;
    // Color white=Colors.white;

    return Scaffold(
      appBar: AppBar(
        title: Text("My Notes"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddNote()));
        },
      ),
      // body: Center(child: Text("hope for the best"),),
      body: StreamBuilder(
          stream: ref.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return GridView.builder(
              itemCount: snapshot.hasData ? snapshot.data.docs.length : 0,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (_, index) {
                return GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      color: grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    height: 100,
                    margin: EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          snapshot.data.docs[index].get('title'),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        Divider(
                          color: Colors.white,
                          thickness: 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5,right: 5),
                          child: Text(
                            snapshot.data.docs[index].get('content'),
                          ),
                        ),
                        // Text(snapshot.data.docChanges[index].doc('title')),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EditNote(snapshot.data.docs[index])));
                  },
                );
              },
            );
          }),
    );
  }
}
