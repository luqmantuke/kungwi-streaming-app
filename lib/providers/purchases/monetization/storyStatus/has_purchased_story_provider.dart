import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kungwi/models/api/default_api_modal.dart';
import 'package:kungwi/providers/purchases/purchases_service_provider.dart';
import 'package:kungwi/providers/shared_preference/shared_preference_provider.dart';

class PurchasedStoryParms extends Equatable {
  final String storyId;
  final String storyType;

  const PurchasedStoryParms(
    this.storyId,
    this.storyType,
  );

  @override
  List<Object?> get props => [
        storyId,
        storyType,
      ];
}

final purchasedStroryProvider = FutureProvider.family
    .autoDispose<DefaultApiModal, PurchasedStoryParms>(
        (ref, purchasedStoryParms) async {
  String userID = await ref.read(userIdProvider.future);
  final buyCreditResponse = await ref
      .read(purchasesServiceProvider)
      .userPurchasedStory(
          userID, purchasedStoryParms.storyId, purchasedStoryParms.storyType);
  return buyCreditResponse;
});
