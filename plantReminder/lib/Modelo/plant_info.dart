import 'dart:convert';

Plant plantFromJson(String str) => Plant.fromJson(json.decode(str));

String plantToJson(Plant data) => json.encode(data.toJson());

class Plant {
  String name;
  String specie;
  String day;
  String image;
  int hour;
  int minute;

  int id;

  Plant(
      {this.id,
      this.name = "",
      this.specie = "",
      this.day = "",
      this.image = "",
      this.hour = 00,
      this.minute = 00});

  factory Plant.fromJson(Map<String, dynamic> json) => Plant(
      id: json["id"],
      name: json["name"],
      specie: json["specie"],
      day: json["day"],
      image: json["image"],
      hour: json["hour"],
      minute: json["minute"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "specie": specie,
        "day": day,
        "image": image,
        "hour": hour,
        "minute": minute
      };
}
