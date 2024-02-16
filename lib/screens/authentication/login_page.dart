// ignore_for_file: unused_result

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:kungwi/common/dialog/messageDialog/message_dialog.dart';
import 'package:kungwi/common/modals/purchase/vifurushi/vifurushi_paywall.dart';
import 'package:kungwi/common/phoneNumber/phone_number_filter.dart';
import 'package:kungwi/common/spacer/custom_spacer.dart';
import 'package:kungwi/common/textfield/textfield_widget.dart';

import 'package:kungwi/providers/authentication/authentication_service.dart';
import 'package:kungwi/providers/shared_preference/shared_preference_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool obscureText = true;
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
                      const Text("Karibu Tena!",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      CustomSpacer(
                        height: 8.h,
                      ),
                      TextFieldWidget(
                        texttFieldController: phoneController,
                        hintText: "Phone Number",
                        textInputType: TextInputType.phone,
                      ),
                      CustomSpacer(
                        height: 3.h,
                      ),
                      TextFieldWidget(
                        texttFieldController: passwordController,
                        hintText: "Password",
                        obscureText: obscureText,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                          icon: Icon(obscureText == false
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.eyeSlash),
                        ),
                      ),
                      CustomSpacer(
                        height: 3.h,
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
                        height: 3.h,
                      ),
                      Row(
                        children: [
                          const Text(
                            "Forgot Password?",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: InkWell(
                              onTap: () {
                                context.goNamed('resetPassword');
                              },
                              child: const Text(
                                "Reset",
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
                        height: 3.h,
                      ),
                      FilledButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                            minimumSize:
                                MaterialStateProperty.all(Size(100.w, 7.h))),
                        onPressed: () {
                          final formattedNumber =
                              phoneNumberFilter(phoneController.text);

                          if (phoneController.text == '') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.only(
                                    right: 10, left: 10, bottom: 10),
                                content: Text("Phone Number is required"),
                              ),
                            );
                          } else if (passwordController.text == '') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.only(
                                    right: 10, left: 10, bottom: 10),
                                content: Text('Password is required'),
                              ),
                            );
                          } else {
                            setState(() {
                              isLoading = true;
                            });
                            ref
                                .read(authServiceProvider)
                                .login(
                                    phoneNumber: formattedNumber,
                                    password: passwordController.text)
                                .then((value) {
                              if (value['status'] == 'success') {
                                saveUserDetails() async {
                                  SharedPreferences preferences =
                                      await SharedPreferences.getInstance();
                                  preferences.setBool("logged", true);
                                  preferences.setString(
                                      "user_id", value['user_id']);
                                  preferences.setString(
                                      "token", value['token']);
                                  preferences.setString(
                                      "user_name", value['username']);
                                }

                                saveUserDetails().then((value) => ref
                                        .refresh(
                                            sharedPreferenceInstanceProvider
                                                .future)
                                        .then(
                                          (value) => ref
                                              .refresh(
                                                  isLoggedInProvider.future)
                                              .then(
                                                (value) => ref
                                                    .refresh(isLoggedInProvider
                                                        .future)
                                                    .then(
                                                      (value) => ref.refresh(
                                                          tokenProvider),
                                                    ),
                                              ),
                                        )
                                        .then((value) {
                                      // context.pop();
                                      vifurushiPayWallSheet(context, ref,
                                          cannotPop: true);
                                    }));
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
                            "Login",
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
