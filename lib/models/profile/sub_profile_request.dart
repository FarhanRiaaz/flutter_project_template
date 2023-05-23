import 'dart:io';

class SubProfileRequest {
   String? name;
   File? profileImg;
   String? age;
   String? color;
   String? gender;
   String? weight;
   String? height;

  SubProfileRequest({
    this.name,
    this.profileImg,
    this.age,
    this.color,
    this.gender,
    this.weight,
    this.height,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();

    data['name'] = this.name;
    data['profileImg'] = this.profileImg;
    data['gender'] = this.gender;
    data['age'] = this.age;
    data['weight'] = this.weight;
    data['color'] = this.color;
    data['height'] = this.height;
    return data;
  }

  SubProfileRequest copyWith({
    String? name,
    File? profileImg,
    String? age,
    String? color,
    String? gender,
    String? weight,
    String? height,
  }) =>
      SubProfileRequest(
        name: name ?? this.name,
        profileImg: profileImg ?? this.profileImg,
        age: age ?? this.age,
        color: color ?? this.color,
        gender: gender ?? this.gender,
        weight: weight ?? this.weight,
        height: height ?? this.height,
      );
}
