class Account {
  late final String id;
  late final String name;
  late final String phoneNum;
  late final int account;
  late final String createdAt;
  late final String updatedAt;

  Account({
    required this.id,
    required this.name,
    required this .phoneNum,
    required this.account,
    required this.createdAt,
    required this.updatedAt,
  });

  Account.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phoneNum = json['phoneNum'];
    account = json['account'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map toJson () {
    Map<String, dynamic> _data = {};
    _data['id'] = id;
    _data['name'] = name;
    _data['phoneNum'] = phoneNum;
    _data['account'] = account;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;

    return _data;
  }


}