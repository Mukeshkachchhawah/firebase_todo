import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageProfile extends StatefulWidget {
  const ImageProfile({super.key});

  @override
  State<ImageProfile> createState() => _ImageProfileState();
}

class _ImageProfileState extends State<ImageProfile> {
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
    // /// downloadRef = storage.child("assets/images/lion-king.jpg");

    // downloadRef = storage.child("assets/images/lion-king.jpg");

    // getImageUrl();
  }

  /*  getImageUrl() async {
    // imageUrl = await downloadRef.getDownloadURL();

    downloadRef = await storage.child("images").listAll();
    for (Reference itme in downloadRef.items) {
      var imgUrl = await itme.getDownloadURL();
      arrImg.add(imgUrl);
    }
    setState(() {});
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      //   body: imageUrl != "" ? Image.network(imageUrl) : Container(),

      body: 
      
      Column(
        children: [
          Center(
            child: InkWell(
              onTap: () async {
                var imgXFile =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                if (imgXFile != null) {
                  var croppedImgFile = await ImageCropper().cropImage(
                    sourcePath: imgXFile.path,
                    aspectRatioPresets: [
                      CropAspectRatioPreset.square,
                      CropAspectRatioPreset.ratio3x2,
                      CropAspectRatioPreset.original,
                      CropAspectRatioPreset.ratio4x3,
                      CropAspectRatioPreset.ratio16x9
                    ],
                    uiSettings: [
                      AndroidUiSettings(
                          toolbarTitle: 'Cropper',
                          toolbarColor: Colors.deepOrange,
                          toolbarWidgetColor: Colors.white,
                          initAspectRatio: CropAspectRatioPreset.original,
                          lockAspectRatio: false),
                      IOSUiSettings(
                        title: 'Cropper',
                      ),
                      WebUiSettings(
                        context: context,
                      ),
                    ],
                  );

                  if (croppedImgFile != null) {
                    imgPath = croppedImgFile.path;
                    setState(() {});
                  }
                  setState(() {});
                }
              },
              child: imgPath != " "
                  ? Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: FileImage(File(imgPath)),
                              fit: BoxFit.cover)),
                    )
                  : Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzBpnouxDuF063trW5gZOyXtyuQaExCQVMYA&usqp=CAU"))),
                    ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                var timeMilisecond = DateTime.now().microsecondsSinceEpoch;
                var uploadRef =
                    storage.child("images/profile_pic/img_$timeMilisecond.jpg");

                if (imgPath != "") {
                  /// upload
                  uploadRef
                      .putFile(File(imgPath))
                      .then((p0) => print("File Uploaded"));
                }
              },
              child: Text("Upload"))
        ],
      ),
    
    
    );
  }
}
