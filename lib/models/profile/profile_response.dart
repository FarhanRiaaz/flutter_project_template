class ProfileResponse {
  int? id;
  String? name;
  String? email;
  String? profileImg;
  String? gender;
  String? age;
  String? weight;
  String? height;

  ProfileResponse({
    this.id,
    this.name,
    this.email,
    this.profileImg,
    this.gender,
    this.age,
    this.weight,
    this.height,
  });

  ProfileResponse.fromJson(Map<String, dynamic> data) {
    id = data['id'];
    name = data['user']['name'];
    email = data['user']['email'];
    profileImg = data['profileImg'];
    gender = data['gender'];
    age = data['age'];
    weight = data['weight'];
    height = data['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user'] = {'name': this.name, 'email': this.email};
    data['profileImg'] = this.profileImg;
    data['gender'] = this.gender;
    data['age'] = this.age;
    data['weight'] = this.weight;
    data['height'] = this.height;
    return data;
  }

  factory ProfileResponse.fromMap(Map<String, dynamic> data) => ProfileResponse(
        id: data['id'],
        name: data['user']['name'],
        email: data['user']['email'],
        profileImg: data['profileImg'],
        gender: data['gender'],
        age: data['age'],
        weight: data['weight'],
        height: data['height'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'user': {'name': name, 'email': email},
        'profileImg': profileImg,
        'gender': gender,
        'age': age,
        'weight': weight,
        'height': height,
      };

  ProfileResponse copyWith({
    int? id,
    String? name,
    String? email,
    String? profileImg,
    String? gender,
    String? age,
    String? weight,
    String? height,
  }) =>
      ProfileResponse(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        profileImg: profileImg ?? this.profileImg,
        gender: gender ?? this.gender,
        age: age ?? this.age,
        weight: weight ?? this.weight,
        height: height ?? this.height,
      );
}
