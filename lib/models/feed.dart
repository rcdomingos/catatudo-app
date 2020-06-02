class Feed {
  String id;
  String title;
  String subtitle;
  String body;
  String image;

  Feed({this.id, this.title, this.subtitle, this.body, this.image});

  Feed.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subtitle = json['subtitle'];
    body = json['body'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['body'] = this.body;
    data['image'] = this.image;
    return data;
  }
}
