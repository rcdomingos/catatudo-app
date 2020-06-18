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
    codAddress = json['cod_address'];
    street = json['street'];
    number = json['number'];
    neighborhood = json['neighborhood'];
    complement = json['complement'];
    city = json['city'];
    state = json['state'];
    zipCode = json['zip_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cod_address'] = this.codAddress;
    data['street'] = this.street;
    data['number'] = this.number;
    data['neighborhood'] = this.neighborhood;
    data['complement'] = this.complement;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zip_code'] = this.zipCode;
    return data;
  }
}
