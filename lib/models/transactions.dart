class Transaction {
  final String type;
  final String item;
  final int amount;
  final int price;
  final String date;
  final String account;


  Transaction({
    required this.type,
    required this.item,
    required this.amount,
    required this.price,
    required this.date,
    required this.account
  });
}