import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kungwi/models/api/default_api_modal.dart';
import 'package:kungwi/providers/purchases/purchases_service_provider.dart';
import 'package:kungwi/providers/shared_preference/shared_preference_provider.dart';

class BuyCreditParms extends Equatable {
  final double price;
  final int creditAmount;
  final String phoneNumber;

  const BuyCreditParms(this.price, this.creditAmount, this.phoneNumber);

  @override
  List<Object?> get props => [price, creditAmount, phoneNumber];
}

final buyCreditProviderProvider = FutureProvider.family
    .autoDispose<DefaultApiModal, BuyCreditParms>((ref, buyCreditParms) async {
  String userID = await ref.read(userIdProvider.future);
  final buyCreditResponse = await ref.read(purchasesServiceProvider).buyCredit(
      userID,
      buyCreditParms.price,
      buyCreditParms.creditAmount,
      buyCreditParms.phoneNumber);
  return buyCreditResponse;
});
