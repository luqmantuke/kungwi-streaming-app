import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kungwi/providers/api/api_service_provider.dart';
import 'package:kungwi/providers/shared_preference/shared_preference_provider.dart';

final fetchCreditProvider = FutureProvider.autoDispose<int>((
  ref,
) async {
  String userID = await ref.read(userIdProvider.future);
  int userCredits = await ref.read(apiServiceProvider).fetchUserCredit(userID);
  return userCredits;
});

final userHasCreditsProvider = FutureProvider<bool>((ref) {
  return ref.read(fetchCreditProvider.future).then((userCredits) {
    if (userCredits > 0) {
      return true;
    } else {
      return false;
    }
  });
});
