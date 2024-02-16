// ignore_for_file: unused_result

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kungwi/common/dialog/messageDialog/message_dialog.dart';
import 'package:kungwi/common/phoneNumber/phone_number_filter.dart';
import 'package:kungwi/common/spacer/custom_spacer.dart';

import 'package:kungwi/providers/authentication/authentication_service.dart';
import 'package:kungwi/providers/shared_preference/shared_preference_provider.dart';
import 'package:kungwi/utilities/routing/routes.dart';

import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpVerifyPage extends ConsumerStatefulWidget {
  final String phoneNumber;
  const SignUpVerifyPage({required this.phoneNumber, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SignUpVerifyPageState();
}

class _SignUpVerifyPageState extends ConsumerState<SignUpVerifyPage> {
  OtpFieldController otpController = OtpFieldController();
  String otpPin = "";
  bool isLoading = false;
  @override
  void initState() {
    final formattedNumber = phoneNumberFilter(widget.phoneNumber);
    ref
        .read(authServiceProvider)
        .verifyUserSendOtp(phoneNumber: formattedNumber);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("sign up verify page");
    return Scaffold(
      body: isLoading == true
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 25, left: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Enter Code",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      CustomSpacer(
                        height: 2.h,
                      ),
                      const Text("We have sent verification code to",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                      Text(widget.phoneNumber,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                      CustomSpacer(
                        height: 2.h,
                      ),
                      Center(
                        child: OTPTextField(
                            otpFieldStyle: OtpFieldStyle(
                              // backgroundColor:
                              //     Theme.of(context).colorScheme.primary,
                              borderColor:
                                  Theme.of(context).colorScheme.primary,
                              enabledBorderColor:
                                  Theme.of(context).colorScheme.secondary,
                            ),
                            controller: otpController,
                            length: 4,
                            width: MediaQuery.of(context).size.width,
                            textFieldAlignment: MainAxisAlignment.spaceAround,
                            fieldWidth: 45,
                            fieldStyle: FieldStyle.box,
                            outlineBorderRadius: 10,
                            style: const TextStyle(
                              fontSize: 17,
                            ),
                            onChanged: (pin) {},
                            onCompleted: (pin) {
                              setState(() {
                                otpPin = pin;
                              });
                            }),
                      ),
                      CustomSpacer(
                        height: 2.h,
                      ),
                      Row(
                        children: [
                          const Text(
                            "Didn't Get phoneNumber?",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isLoading = true;
                                });
                                final formattedNumber =
                                    phoneNumberFilter(widget.phoneNumber);
                                ref
                                    .read(authServiceProvider)
                                    .verifyUserSendOtp(
                                        phoneNumber: formattedNumber)
                                    .then((value) {
                                  if (value['status'] == 'success') {
                                    messageDialog(context, value['status'],
                                        value['message']);
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                });
                              },
                              child: const Text(
                                "Resend",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      CustomSpacer(
                        height: 2.h,
                      ),
                      Row(
                        children: [
                          const Text(
                            "Doesn't Have An Account?",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: InkWell(
                              onTap: () {
                                context.goNamed('signUp');
                              },
                              child: const Text(
                                "SignUp",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      CustomSpacer(
                        height: 2.h,
                      ),
                      Row(
                        children: [
                          const Text(
                            "Already Have An Account?",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: InkWell(
                              onTap: () {
                                context.goNamed('signIn');
                              },
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      CustomSpacer(
                        height: 2.h,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          final formattedNumber =
                              phoneNumberFilter(widget.phoneNumber);
                          setState(() {
                            isLoading = true;
                          });
                          ref
                              .read(authServiceProvider)
                              .verifySignUpOtp(
                                  phoneNumber: formattedNumber, otp: otpPin)
                              .then((value) {
                            if (value['status'] == 'success') {
                              saveUserDetails() async {
                                SharedPreferences preferences =
                                    await SharedPreferences.getInstance();
                                preferences.setBool("logged", true);
                                preferences.setString(
                                    "user_id", value['user_id']);
                                preferences.setString("token", value['token']);
                                preferences.setString(
                                    "user_name", value['username']);
                                ref.refresh(sharedPreferenceInstanceProvider);
                                ref.refresh(isLoggedInProvider);
                                ref.refresh(userNameProvider);
                                ref.refresh(tokenProvider);
                              }

                              saveUserDetails();
                              messageDialog(
                                  context, value['status'], value['message']);
                              goRouter.goNamed('home');
                            } else {
                              setState(() {
                                isLoading = false;
                              });
                              messageDialog(
                                  context, value['status'], value['message']);
                            }
                          });
                        },
                        child: const Center(
                          child: Text(
                            "Verify",
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
