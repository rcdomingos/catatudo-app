import 'package:catatudo_app/core/models/address.dart';

class User {
  String sId;
  String name;
  String email;
  bool isCollector;
  bool isAdmin;
  String image;
  String createdDate;
  List<Address> addresses;

  User(
      {this.sId,
      this.name,
      this.email,
      this.isCollector,
      this.isAdmin,
      this.image,
      this.createdDate,
      this.addresses});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    isCollector = json['is_collector'];
    isAdmin = json['is_admin'];
    image = json['image'];
    createdDate = json['created_date'];
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
    data['is_collector'] = this.isCollector;
    data['is_admin'] = this.isAdmin;
    data['image'] = this.image;
    data['created_date'] = this.createdDate;
    if (this.addresses != null) {
      data['addresses'] = this.addresses.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
