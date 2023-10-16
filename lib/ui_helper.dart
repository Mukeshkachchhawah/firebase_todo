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

Widget SocilMedia(Icon icons, VoidCallback ontap) {
  return InkWell(
    onTap: ontap,
    child: Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: icons,
    ),
  );
}
