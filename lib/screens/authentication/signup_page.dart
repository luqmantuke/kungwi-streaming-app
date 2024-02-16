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

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController comfirmPasswordController =
      TextEditingController();
  bool obscureText = true;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    debugPrint("sign up  page");

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
                      const Text("Tengeneza Akaunti",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      CustomSpacer(
                        height: 8.h,
                      ),
                      TextFieldWidget(
                        texttFieldController: usernameController,
                        hintText: "Username",
                      ),
                      CustomSpacer(
                        height: 3.h,
                      ),
                      TextFieldWidget(
                        texttFieldController: phoneController,
                        hintText: "Namba Ya Simu",
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
                      TextFieldWidget(
                        texttFieldController: comfirmPasswordController,
                        hintText: "Comfirm Password",
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
                            "Tayari unayo Akaunti?",
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
                          if (usernameController.text == '') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.only(
                                    right: 10, left: 10, bottom: 10),
                                content: Text('Username is required'),
                              ),
                            );
                          } else if (phoneController.text == '') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.only(
                                    right: 10, left: 10, bottom: 10),
                                content: Text('Phone Number is required'),
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
                          } else if (comfirmPasswordController.text == '') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.only(
                                    right: 10, left: 10, bottom: 10),
                                content: Text('Comfirm Password is required'),
                              ),
                            );
                          } else if (passwordController.text !=
                              comfirmPasswordController.text) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.only(
                                    right: 10, left: 10, bottom: 10),
                                content: Text('Password do not match'),
                              ),
                            );
                          } else {
                            final formattedNumber =
                                phoneNumberFilter(phoneController.text);

                            if (formattedNumber == 'invalid format') {
                              messageDialog(context, 'Phone Number',
                                  'Invalid phone number. Phone number should start with 255... or 0..');
                            } else {
                              FocusManager.instance.primaryFocus?.unfocus();
                              setState(() {
                                isLoading = true;
                              });
                              ref
                                  .read(authServiceProvider)
                                  .signUp(
                                      username: usernameController.text,
                                      password: passwordController.text,
                                      phoneNumber: formattedNumber)
                                  .then((value) {
                                debugPrint(value.toString());
                                if (value['status_code'] == 201) {
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
                                                      .refresh(
                                                          isLoggedInProvider
                                                              .future)
                                                      .then(
                                                        (value) => ref.refresh(
                                                            tokenProvider),
                                                      ),
                                                ),
                                          )
                                          .then((value) {
                                        if (context.canPop()) {
                                          context.pop();
                                        } else {
                                          vifurushiPayWallSheet(context, ref,
                                              cannotPop: true);
                                        }
                                        // context.pushNamed('home').then(
                                        //     (value) => vifurushiPayWallSheet(
                                        //         context, ref));
                                      }));
                                } else {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  messageDialog(context, value['status'],
                                      value['message']);
                                }
                              });
                            }
                          }
                        },
                        child: const Center(
                          child: Text(
                            "Tengeneza Akaunti",
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
