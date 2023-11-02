import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_todo_ui/ui_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';


import 'profile_pic/profile_pic.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late FirebaseFirestore db;

  late TextEditingController titleController = TextEditingController();
  late TextEditingController deseController = TextEditingController();

 
  ////// user profile
  var storage = FirebaseStorage.instance.ref();
  // late Reference downloadRef;
  late ListResult downloadRef;

  String imageUrl = "";

  List<String> arrImg = [];

  String imgPath = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    /// inistlition
    db = FirebaseFirestore.instance;

    //// data facthing dara
    db.collection("notes").get();
  }

  /// Add Todo List items

  Future AddTodo() {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 500,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              children: [
                Text(
                  "Add Taks",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                      hintText: "Title",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                //  CustomTextFild("titile"),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: deseController,
                  decoration: InputDecoration(
                      hintText: "Desc",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),

                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                      onPressed: () {
                        print("hello");

//// data get
                        db.collection('Notes').add({
                          "title": titleController.text,
                          "desc": deseController.text
                        }).then((value) {
                          print("Note Added ${value.id}");
                        });
                        Navigator.pop(context);
                        titleController.clear();
                        deseController.clear();
                      },
                      child: Text("Add")),
                )
              ],
            ),
          ),
        );
        ;
      },
    );
  }

  /// Update Notes
  Future UpdateTodo(String id, String mtitle, String mdesc) {
    titleController.text = mtitle;
    deseController.text = mdesc;

    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 500,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              children: [
                Text(
                  "Update Taks",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                      hintText: "Title",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                          
                ),
                //  CustomTextFild("titile"),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: deseController,
                  decoration: InputDecoration(
                      hintText: "Desc",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),

                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                      onPressed: () {
                        print("hello");

                        db.collection('Notes').doc(id).update({
                          "title": titleController.text,
                          "desc": deseController.text
                        });
                        Navigator.pop(context);
                        
                      },
                      child: Text("Update")),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  /// delet Notes
  Future<void> deletTodo(String itemId) async {
    await db.collection('Notes').doc(itemId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FireBase Todo"),
        actions: [
      
          Container(
             height: 50,
             width: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Color.fromARGB(255, 250, 0, 0)),
                
                 child: ProfilePicPage(),
              )
        ],
      ),
      body: StreamBuilder(
        /// data fatch
        stream: db.collection("Notes").snapshots(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error"),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                /// global varible
                var notesData = snapshot.data!.docs[index];
                return InkWell(
                  onTap: () {
                    // call update Function
                    UpdateTodo(
                        notesData.id, notesData['title'], notesData['desc']);
                  },
                  child: Card(
                    child: ListTile(
                      leading: Text("${index + 1}"),
                      title: Text("${notesData['title']}"),
                      subtitle: Text("${notesData['desc']}"),
                      trailing: InkWell(
                        onTap: () => deletTodo(notesData.id),
                        child: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),

      floatingActionButton: FloatingActionButton(onPressed:  AddTodo,
      child: Icon(Icons.add),),
    );
  }



 
}
