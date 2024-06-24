class Store {
  Store({
    required this.id,
    required this.name,
    required this.price,
    required this.sellPrice,
    required this.location,
    required this.createdAt,
    required this.updatedAt,
  });
  late final String id;
  late final String name;
  late final int price;
  late final int sellPrice;
  late final String location;
  late final String createdAt;
  late final String updatedAt;

  Store.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    price = json['price'];
    sellPrice = json['sellPrice'];
    location = json['location'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['price'] = price;
    _data['sellPrice'] = sellPrice;
    _data['location'] = location;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    return _data;
  }
}
