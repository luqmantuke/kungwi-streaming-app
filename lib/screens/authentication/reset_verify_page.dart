import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kungwi/common/dialog/messageDialog/message_dialog.dart';
import 'package:kungwi/common/spacer/custom_spacer.dart';

import 'package:kungwi/providers/authentication/authentication_service.dart';

import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ResetPasswordVerifyPage extends ConsumerStatefulWidget {
  final String email;
  const ResetPasswordVerifyPage({required this.email, Key? key})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ResetPasswordVerifyPageState();
}

class _ResetPasswordVerifyPageState
    extends ConsumerState<ResetPasswordVerifyPage> {
  OtpFieldController otpController = OtpFieldController();
  String otpPin = "";
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
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
                      Text(widget.email,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                      CustomSpacer(
                        height: 2.h,
                      ),
                      Center(
                        child: OTPTextField(
                            otpFieldStyle: OtpFieldStyle(),
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
                            "Didn't Get Email?",
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
                                ref
                                    .read(authServiceProvider)
                                    .resetPasswordSendOTP(
                                        phoneNumber: widget.email)
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
                            "Remember Password?",
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
                          setState(() {
                            isLoading = true;
                          });
                          ref
                              .read(authServiceProvider)
                              .verifyResetPasswordOtp(
                                  phoneNumber: widget.email, otp: otpPin)
                              .then((value) {
                            if (value['status'] == 'success') {
                              messageDialog(
                                  context, value['status'], value['message']);
                              context.goNamed('home');
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
                            "Reset Password",
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
