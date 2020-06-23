import 'package:catatudo_app/core/models/address.dart';

class Collect {
  String collectType;
  String collectDate;
  String collectTime;
  String status;
  String createdDate;
  Address address;

  Collect(
      {this.collectType,
      this.collectDate,
      this.collectTime,
      this.status,
      this.createdDate,
      this.address});

  Collect.fromJson(Map<String, dynamic> json) {
    collectType = json['collectType'];
    collectDate = json['collectDate'];
    collectTime = json['collectTime'];
    status = json['status'];
    createdDate = json['created_date'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['collectType'] = this.collectType;
    data['collectDate'] = this.collectDate;
    data['collectTime'] = this.collectTime;
    data['status'] = this.status;
    data['created_date'] = this.createdDate;
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    return data;
  }
}
