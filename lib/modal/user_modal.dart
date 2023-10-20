class UserModal {
  String? uid;
  String? name;
  String? email;
  String? age;
  String? dob;
  String? mobNo;
  String? gender;
  String? address;
  String? password;
  String? confromPasswrod;

  // bool isDone;

  UserModal({
     this.uid,
     this.name,
     this.email,
     this.age,
     this.address,
     this.dob,
     this.gender,
     this.mobNo,

     this.password,
     this.confromPasswrod

  });

  factory UserModal.fromjson(Map<String, dynamic> json) {
    return UserModal(
        uid: json['uid'],
        name: json['name'],
        email: json['email'],
        age: json['age'],
        address: json['address'],
        dob: json['dob'],
        gender: json['gender'],
        mobNo: json['mobNo'],
        password: json['password'],
     confromPasswrod : json['confromPasswrod']

        );
        
  }

  Map<String, dynamic> tojson() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "age": age,
      "dob": dob,
      "mobNo": mobNo,
      "gender": gender,
      "address": address,
      "password" : password,
      "confromPasswrod" : confromPasswrod
    };
  }
}
