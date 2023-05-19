class SubProfileResponse {
  int? id;
  String? profileImg;
  String? name;
  String? color;
  String? gender;
  String? age;
  String? weight;
  String? height;
  int? user;

  SubProfileResponse({
    this.id,
    this.profileImg,
    this.name,
    this.color,
    this.gender,
    this.age,
    this.weight,
    this.height,
    this.user,
  });

  SubProfileResponse.fromJson(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    user = data['user'];
    profileImg = data['profileImg'];
    gender = data['gender'];
    color = data['color'];
    age = data['age'];
    weight = data['weight'];
    height = data['height'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user'] = this.user;
    data['name'] = this.name;
    data['profileImg'] = this.profileImg;
    data['gender'] = this.gender;
    data['age'] = this.age;
    data['weight'] = this.weight;
    data['color'] = this.color;
    data['height'] = this.height;
    return data;
  }

  factory SubProfileResponse.fromMap(Map<String, dynamic> data) =>
      SubProfileResponse(
        id: data['id'],
        name: data['name'],
        user: data['user'],
        profileImg: data['profileImg'],
        gender: data['gender'],
        age: data['age'],
        color: data['color'],
        weight: data['weight'],
        height: data['height'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'user': user,
        'name': name,
        'color': color,
        'profileImg': profileImg,
        'gender': gender,
        'age': age,
        'weight': weight,
        'height': height,
      };

  SubProfileResponse copyWith({
    int? id,
    dynamic profileImg,
    String? name,
    String? color,
    String? gender,
    String? age,
    String? weight,
    String? height,
    int? user,
  }) =>
      SubProfileResponse(
        id: id ?? this.id,
        profileImg: profileImg ?? this.profileImg,
        name: name ?? this.name,
        color: color ?? this.color,
        gender: gender ?? this.gender,
        age: age ?? this.age,
        weight: weight ?? this.weight,
        height: height ?? this.height,
        user: user ?? this.user,
      );
}
