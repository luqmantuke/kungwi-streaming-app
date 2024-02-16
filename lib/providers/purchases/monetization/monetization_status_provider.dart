import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kungwi/providers/purchases/purchases_service_provider.dart';

final monetizationStatusProvider = FutureProvider<bool>((ref) async {
  bool monetizationStatus =
      await ref.read(purchasesServiceProvider).getMonetizationStatus();

  return monetizationStatus;
});
