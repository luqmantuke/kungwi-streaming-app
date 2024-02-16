import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kungwi/models/api/default_api_modal.dart';
import 'package:kungwi/providers/purchases/purchases_service_provider.dart';
import 'package:kungwi/providers/shared_preference/shared_preference_provider.dart';

class BuyStoryCreditParms extends Equatable {
  final String storyId;
  final String storyType;
  final double price;
  final int creditAmount;

  const BuyStoryCreditParms(
    this.storyId,
    this.storyType,
    this.price,
    this.creditAmount,
  );

  @override
  List<Object?> get props => [
        storyId,
        storyType,
        price,
        creditAmount,
      ];
}

final buyStoryTokenProvider = FutureProvider.family
    .autoDispose<DefaultApiModal, BuyStoryCreditParms>(
        (ref, buyCreditTokenParms) async {
  String userID = await ref.read(userIdProvider.future);
  final buyCreditResponse =
      await ref.read(purchasesServiceProvider).buyStoryUsingToken(
            userID,
            buyCreditTokenParms.storyId,
            buyCreditTokenParms.storyType,
            buyCreditTokenParms.price,
            buyCreditTokenParms.creditAmount,
          );
  return buyCreditResponse;
});
