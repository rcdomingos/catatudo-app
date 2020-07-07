class Address {
  int codAddress;
  String street;
  String number;
  String neighborhood;
  String complement;
  String city;
  String state;
  String zipCode;

  Address(
      {this.codAddress,
      this.street,
      this.number,
      this.neighborhood,
      this.complement,
      this.city,
      this.state,
      this.zipCode});

  Address.fromJson(Map<String, dynamic> json) {
    codAddress = json['codAddress'];
    street = json['street'];
    number = json['number'];
    neighborhood = json['neighborhood'];
    complement = json['complement'];
    city = json['city'];
    state = json['state'];
    zipCode = json['zipCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['codAddress'] = this.codAddress;
    data['street'] = this.street;
    data['number'] = this.number;
    data['neighborhood'] = this.neighborhood;
    data['complement'] = this.complement;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zipCode'] = this.zipCode;
    return data;
  }
}