import 'package:flutter/material.dart';

Widget hSpacher({mHeight = 11.0}) {
  return SizedBox(
    height: mHeight,
  );
}

Widget wSpacher({mWidht = 11.0}) {
  return SizedBox(
    width: mWidht,
  );
}

// Widget TextFildDecoration(){
//  return DecoratedBox(decoration: InputDecoration())
// }

Widget SocilMedia(VoidCallback ontap, String image) {
  return InkWell(
    onTap: ontap,
    child: Container(
      height: 50,
      width: 80,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.black)),
      child: Center(
        child: Image.asset(image,  height: 30, width: 50,),
      ),
    ),
  );
}

Widget CustomContainer(String text, Color colors, VoidCallback ontap) {
  return InkWell(
    onTap: ontap,
    child: Container(
      height: 50,
      width: double.infinity,
      decoration:
          BoxDecoration(color: colors, borderRadius: BorderRadius.circular(10)),
      child: Center(
          child: Text(
        text,
        style: TextStyle(fontSize: 20, color: Colors.white),
      )),
    ),
  );
}

Widget CustomTextFild(
  mController,
  monTapOutside,
  monChanged,
  mvalidator,
  String text
) {
  return TextFormField(
    controller: mController,
   
    onTapOutside: monTapOutside,
    onChanged: monChanged,
    validator: mvalidator,
    decoration: InputDecoration(
        hintText: text,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
  );
}
