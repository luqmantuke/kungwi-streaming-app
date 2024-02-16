import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kungwi/models/purchases/vifurushi/vifurushi_modal.dart';
import 'package:kungwi/providers/purchases/purchases_service_provider.dart';

final fetchVifurushiProvider = FutureProvider<VifurushiModal>((ref) async {
  VifurushiModal vifurushi =
      await ref.read(purchasesServiceProvider).getVifurushi();
  return vifurushi;
});
