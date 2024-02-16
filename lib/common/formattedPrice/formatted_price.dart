import 'package:intl/intl.dart';

String formattedPrice(double price) {
  final formatter = NumberFormat();
  final productPrice = formatter.format(price);
  return 'Tsh $productPrice';
}
