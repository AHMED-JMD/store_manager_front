class Transaction {
  late final String id;
  late final String itemId;
  late final String empId;
  late final String itemName;
  late final String empName;
  late final String type;
  late final int amount;
  late final int price;
  late final String date;
  late final String? comment;
  late final String createdAt;
  late final String updatedAt;


  Transaction({
    required this.id,
    required this.itemId,
    required this.empId,
    required this.itemName,
    required this.empName,
    required this.type,
    required this.amount,
    required this.price,
    required this.date,
    this.comment,
    required this.createdAt,
    required this.updatedAt
  });

  Transaction.fromJson (Map<String, dynamic> json) {
    id = json['id'];
    itemId = json['itemId'];
    empId = json['empId'];
    itemName = json['itemName'];
    empName = json['empName'];
    type = json['type'];
    amount = json['amount'];
    price = json['price'];
    date = json['date'];
    comment = json['comment'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson () {
    Map<String, dynamic> _data = {};
    _data['id'] = id;
    _data['item_id'] = itemId;
    _data['emp_id'] = empId;
    _data['item_name'] = itemName;
    _data['emp_name'] = empName;
    _data['type'] = type;
    _data['amount'] = amount;
    _data['price'] = price;
    _data['date'] = date;
    _data['comment'] = comment;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;


    return _data;
  }
}

