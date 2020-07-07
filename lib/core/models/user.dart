import 'package:catatudo_app/core/models/address.dart';

class User {
  String sId;
  String name;
  String email;
  bool isCollector;
  bool isAdmin;
  String createdDate;
  String image;
  String phone;
  List<Address> addresses;

  User(
      {this.sId,
      this.name,
      this.email,
      this.isCollector,
      this.isAdmin,
      this.createdDate,
      this.image,
      this.phone,
      this.addresses});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    isCollector = json['isCollector'];
    isAdmin = json['isAdmin'];
    createdDate = json['createdDate'];
    image = json['image'];
    phone = json['phone'];
    if (json['addresses'] != null) {
      addresses = new List<Address>();
      json['addresses'].forEach((v) {
        addresses.add(new Address.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['isCollector'] = this.isCollector;
    data['isAdmin'] = this.isAdmin;
    data['createdDate'] = this.createdDate;
    data['image'] = this.image;
    data['phone'] = this.phone;
    if (this.addresses != null) {
      data['addresses'] = this.addresses.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
