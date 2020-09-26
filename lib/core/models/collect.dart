import 'package:catatudo_app/core/models/address.dart';

class Collect {
  String sId;
  String generatorId;
  String collectDate;
  String collectTime;
  String createdDate;
  Address address;
  String collectType;
  int collectWeight;
  Status status;
  String aceptedDate;
  String collectorId;
  String collectedDate;

  Collect(
      {this.sId,
      this.generatorId,
      this.collectDate,
      this.collectTime,
      this.createdDate,
      this.address,
      this.collectType,
      this.collectWeight,
      this.status,
      this.aceptedDate,
      this.collectorId,
      this.collectedDate});

  Collect.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    generatorId = json['generatorId'];
    collectDate = json['collectDate'];
    collectTime = json['collectTime'];
    createdDate = json['createdDate'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    collectType = json['collectType'];
    collectWeight = json['collectWeight'];
    status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
    aceptedDate = json['aceptedDate'];
    collectorId = json['collectorId'];
    collectedDate = json['collectedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['generatorId'] = this.generatorId;
    data['collectDate'] = this.collectDate;
    data['collectTime'] = this.collectTime;
    data['createdDate'] = this.createdDate;
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    data['collectType'] = this.collectType;
    data['collectWeight'] = this.collectWeight;
    if (this.status != null) {
      data['status'] = this.status.toJson();
    }
    data['aceptedDate'] = this.aceptedDate;
    data['collectorId'] = this.collectorId;
    data['collectedDate'] = this.collectedDate;
    return data;
  }
}

class Status {
  int code;
  String description;

  Status({this.code, this.description});

  Status.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['description'] = this.description;
    return data;
  }
}
