import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kungwi/common/dialog/messageDialog/message_dialog.dart';
import 'package:kungwi/common/phoneNumber/phone_number_filter.dart';
import 'package:kungwi/common/spacer/custom_spacer.dart';
import 'package:kungwi/common/textfield/textfield_widget.dart';

import 'package:kungwi/providers/authentication/authentication_service.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ResetPasswordPage extends ConsumerStatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ResetPasswordPageState();
}

class _ResetPasswordPageState extends ConsumerState<ResetPasswordPage> {
  final TextEditingController phoneNumberController = TextEditingController();
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
                      const Text("Reset Password!",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      CustomSpacer(
                        height: 2.h,
                      ),
                      TextFieldWidget(
                        texttFieldController: phoneNumberController,
                        hintText: "Phone Number",
                        textInputType: TextInputType.phone,
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
                          final formattedNumber =
                              phoneNumberFilter(phoneNumberController.text);

                          if (phoneNumberController.text == '') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.only(
                                    right: 10, left: 10, bottom: 10),
                                content: Text("Phone Number is required"),
                              ),
                            );
                          } else if (formattedNumber == 'invalid format') {
                            messageDialog(context, 'Phone Number',
                                'Invalid phone number. Phone number should start with 255... or 0..');
                          } else {
                            setState(() {
                              isLoading = true;
                            });
                            ref
                                .read(authServiceProvider)
                                .resetPasswordSendOTP(
                                    phoneNumber: formattedNumber)
                                .then((value) {
                              if (value['status'] == 'success') {
                                messageDialog(
                                    context, value['status'], value['message']);
                                final formattedNumber = phoneNumberFilter(
                                    phoneNumberController.text);
                                ref.read(authServiceProvider).verifyUserSendOtp(
                                    phoneNumber: formattedNumber);
                                context.goNamed('signUpVerify',
                                    queryParameters: {
                                      'number': phoneNumberController.text
                                    });
                              } else {
                                setState(() {
                                  isLoading = false;
                                });
                                messageDialog(
                                    context, value['status'], value['message']);
                              }
                            });
                          }
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
