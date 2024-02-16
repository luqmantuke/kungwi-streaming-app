import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferenceInstanceProvider =
    FutureProvider<SharedPreferences>((ref) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  return sharedPreferences;
});

final isLoggedInProvider = FutureProvider.autoDispose<bool>((ref) async {
  final sharedPreferences =
      await ref.watch(sharedPreferenceInstanceProvider.future);
  final isLoggedIn = sharedPreferences.getBool('logged') ?? false;
  // print(isLoggedIn);
  return isLoggedIn;
});

final userNameProvider = FutureProvider.autoDispose<String>((ref) async {
  final sharedPreferences =
      await ref.watch(sharedPreferenceInstanceProvider.future);
  final userName = sharedPreferences.getString('user_name') ?? '';
  return userName;
});

final userIdProvider = FutureProvider.autoDispose<String>((ref) async {
  final sharedPreferences =
      await ref.watch(sharedPreferenceInstanceProvider.future);
  final userId = sharedPreferences.getString('user_id') ?? '';
  return userId;
});

final tokenProvider = FutureProvider.autoDispose<String>((ref) async {
  final sharedPreferences =
      await ref.watch(sharedPreferenceInstanceProvider.future);
  final token = sharedPreferences.getString('token') ?? '';
  return token;
});
