import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';


var ID;
var NAME;
var DESC;

class UpdateNotes extends StatefulWidget {
  var name;
  var desc;
  var id;
  UpdateNotes(
      {super.key, required var id, required var name, required var desc}) {
    ID = id;
    NAME = name;
    DESC = desc;
  }

  @override
  State<UpdateNotes> createState() => _UpdateNotesState();
}

class _UpdateNotesState extends State<UpdateNotes> {
  late FirebaseFirestore db;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    /// inistlition
    db = FirebaseFirestore.instance;

    //// data facthing dara
    // db.collection("notes").get();
  }

  @override
  Widget build(BuildContext context) {
    titleController.text = NAME;
    descController.text = DESC;

    return Scaffold(
      appBar: AppBar(
        title: Text("update taks"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              controller: titleController,
              decoration: InputDecoration(
                  hintText: "Title",
                  hintStyle:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: descController,
              maxLines: 10,
              decoration: InputDecoration(
                  hintText: "Desc",
                  // hintStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          db.collection('Notes').doc(ID).update(
              {"title": titleController.text, "desc": descController.text});
          Navigator.pop(context);
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
