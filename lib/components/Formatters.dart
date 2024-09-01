import 'package:money_formatter/money_formatter.dart';

String moneyFormatter(double number) {
  return MoneyFormatter(amount: number).output.withoutFractionDigits;
}
