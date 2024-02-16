import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kungwi/services/purchases/purchase_service.dart';

final purchasesServiceProvider = Provider<PurchasesService>((ref) {
  return PurchasesService();
});
