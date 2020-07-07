class Feed {
  String sId;
  String createdDate;
  String title;
  String subtitle;
  String body;
  String source;
  String image;
  String link;
  String updatedDate;

  Feed(
      {this.sId,
      this.createdDate,
      this.title,
      this.subtitle,
      this.body,
      this.source,
      this.image,
      this.link,
      this.updatedDate});

  Feed.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    createdDate = json['createdDate'];
    title = json['title'];
    subtitle = json['subtitle'];
    body = json['body'];
    source = json['source'];
    image = json['image'];
    link = json['link'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['createdDate'] = this.createdDate;
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['body'] = this.body;
    data['source'] = this.source;
    data['image'] = this.image;
    data['link'] = this.link;
    data['updatedDate'] = this.updatedDate;
    return data;
  }
}