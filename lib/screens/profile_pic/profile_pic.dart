import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePicPage extends StatefulWidget {
  const ProfilePicPage({super.key});

  @override
  State<ProfilePicPage> createState() => _ProfilePicPageState();
}

class _ProfilePicPageState extends State<ProfilePicPage> {
  var storage = FirebaseStorage.instance.ref();
  late ListResult downloadRef;
  String imgUrl = "";
  List<String> arrImg = [];
  String imgPath = "";

  @override
  void initState() {
    super.initState();


    // getImgUrl();
  }

  // getImgUrl() async {
  //   // imgUrl = await downloadRef.getDownloadURL();
  //
  //   downloadRef =await storage.child("images/").listAll();
  //   for(Reference item in downloadRef.items){
  //     var imgUrl = await item.getDownloadURL();
  //     arrImg.add(imgUrl);
  //   }
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: (){

            showModalBottomSheet(
                context: context,
                builder: (context) {

                  return InkWell(
                   onTap: (){
                     Navigator.pop(context);
                   },
                    child: Container(
                      height: 200,
                     
                      decoration: BoxDecoration(
                         color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              /// image pic in camera
                             InkWell(
                                onTap: ()async{
                                  var imgXFile =await ImagePicker().pickImage(source: ImageSource.camera);
                                  if(imgXFile!=null){

                                     var croppedImgFile =await ImageCropper().cropImage(
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


                                     if(croppedImgFile!=null){
                                       imgPath = croppedImgFile.path;
                                       setState(() {

                                       });
                                     }

                                  }

                                },
                                  child: Icon(Icons.camera_alt,size: 62, color: Colors.red,)),
                             SizedBox(
                              width: 43,
                             ),
                             //// image pic in gallery 
                              InkWell(
                                onTap: ()async{
                                  var imgXFile =await ImagePicker().pickImage(source: ImageSource.gallery);
                                  if(imgXFile!=null){

                                     var croppedImgFile =await ImageCropper().cropImage(
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


                                     if(croppedImgFile!=null){
                                       imgPath = croppedImgFile.path;
                                       setState(() {

                                       });
                                     }

                                  }

                                },
                                  child: Icon(Icons.photo,size: 62, color: Colors.red,)),

                            ],
                          ),
                        SizedBox(
                          height: 10,
                        ),
                          ElevatedButton(
                              onPressed: (){
                                var timeMillis = DateTime.now().millisecondsSinceEpoch;
                                var uploadRef = storage.child("images/profile_pic/img_$timeMillis.jpg");


                                if(imgPath!=""){
                                  //upload
                                  uploadRef.putFile(File(imgPath)).then((p0) => print("File Uploaded"));
                                }
                              },
                              child: Text("Upload")),
                        ],
                      ),

                    ),
                  );
                },);

          },
          child:imgPath!="" ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(left: 11),
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: FileImage(File(imgPath)),fit: BoxFit.cover,
                  ),
                ),

              ),
              
            ],
          ):  Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              // color: Colors.red,
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage("http://www.hotavatars.com/wp-content/uploads/2019/01/I80W1Q0.png"),fit: BoxFit.cover,
              ),
            ),

          ),
        ),
      ),

    );
  }
}

