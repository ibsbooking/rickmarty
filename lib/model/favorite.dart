import 'package:hive/hive.dart';
part 'favorite.g.dart';

@HiveType(typeId: 1)
class Favorite extends HiveObject{

  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String status;

  @HiveField(3)
  final String species;

  @HiveField(4)
  final String type;

  @HiveField(5)
  final String gender;

  @HiveField(6)
  final String image;

  @HiveField(7)
  final String originName;

  @HiveField(8)
  final String locationName;

  @HiveField(9)
  final List<String> episode;

  @HiveField(10)
  bool isFavorite;

  Favorite({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.image,
    required this.originName,
    required this.locationName,
    required this.episode,
    this.isFavorite = false,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      type: json['type'],
      gender: json['gender'],
      image: json['image'],
      originName: json['origin']['name'],
      locationName: json['location']['name'],
      episode: List<String>.from(json['episode']),
    );
  }
}