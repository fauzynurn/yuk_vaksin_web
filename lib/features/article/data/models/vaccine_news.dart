class VaccineNews {
  final int id;
  final String title;
  final String shortDescription;
  final String content;
  final String imageUrl;
  final String createdDate;
  final String updatedDate;

  VaccineNews(
      {required this.id,
      required this.title,
      required this.shortDescription,
      required this.content,
      required this.imageUrl,
      required this.createdDate,
      required this.updatedDate});

  factory VaccineNews.fromJson(Map<String, dynamic> json) => VaccineNews(
      id: json['Id'],
      title: json['title'],
      shortDescription: json['short_description'],
      content: json['text'],
      imageUrl: json['image_url'],
      createdDate: json['created_at'],
      updatedDate: json['updated_at']);
}
