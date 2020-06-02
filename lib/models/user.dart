class User {
  String name;
  String email;
  String password;
  String phone;
  String photo;

  User({this.name, this.email, this.password, this.phone, this.photo});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phone'] = this.phone;
    data['photo'] = this.photo;
    return data;
  }
}
