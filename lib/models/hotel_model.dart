import 'package:cloud_firestore/cloud_firestore.dart';

class Hotel {
  final String? id;
  final String title;
  final String description;
  final String image;
  final bool favorite;
  final DateTime creationDate;

  Hotel({
    this.id,
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

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": title,
        "description": description,
        "image": image,
        "favorite": favorite,
        "creation_date": Timestamp.fromDate(creationDate),
      };
}
