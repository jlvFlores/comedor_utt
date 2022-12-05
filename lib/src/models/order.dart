import 'dart:convert';

import 'package:comedor_utt/src/models/product.dart';
import 'package:comedor_utt/src/models/user.dart';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {

  String id;
  String idClient;
  String status;
  int timestamp;
  List<Product> products = [];
  List<Order> toList = [];
  User client;

  Order({
    this.id,
    this.idClient,
    this.status,
    this.timestamp,
    this.products,
    this.client,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"] is int ? json["id"].toString() : json['id'],
    idClient: json["id_client"],
    status: json["status"],
    timestamp: json["timestamp"] is String ? int.parse(json["timestamp"]) : json["timestamp"],
    products: json["products"] != null ? List<Product>.from(json["products"].map((model) => model is Product ? model : Product.fromJson(model))) ?? [] : [],
    client: json['client'] is String ? userFromJson(json['client']) : json['client'] is User ? json['client'] : User.fromJson(json['client'] ?? {}),
  );

  Order.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      Order order = Order.fromJson(item);
      toList.add(order);
    }
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_client": idClient,
    "status": status,
    "timestamp": timestamp,
    "products": products,
    "client": client,
  };
}
