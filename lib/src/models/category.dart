import 'dart:convert';

Category categotyFromJson(String str) => Category.fromJson(json.decode(str));

String categotyToJson(Category data) => json.encode(data.toJson());

class Category {
  String id;
  String name;
  String description;
  List<Category> toList = [];
  
  Category({
    this.id,
    this.name,
    this.description,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"] is int ? json["id"].toString() : json['id'],
    name: json["name"],
    description: json["description"],
  );

  Category.fromJsonList(List<dynamic> jsonList) {
    for (var item in jsonList) {
      Category category = Category.fromJson(item);
      toList.add(category);
    }
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
  };
}