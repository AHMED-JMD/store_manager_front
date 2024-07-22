import 'package:money_formatter/money_formatter.dart';


String moneyFormatter(number) {
  double converted = number.toDouble();

  return MoneyFormatter(
      amount: converted
  ).output.withoutFractionDigits;
}