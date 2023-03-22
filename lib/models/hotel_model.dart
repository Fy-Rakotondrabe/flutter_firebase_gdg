class Hotel {
  final String id;
  final String title;
  final String description;
  final String image;
  final bool favorite;
  final DateTime creationDate;

  Hotel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.favorite,
    required this.creationDate,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      id: json["id"],
      title: json["name"],
      description: json["description"],
      image: json["image"],
      favorite: json["favorite"],
      creationDate: DateTime.parse(
        json['creation_date'].toDate().toString(),
      ),
    );
  }
}
