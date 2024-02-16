import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:kungwi/common/dialog/messageDialog/message_dialog.dart';
import 'package:kungwi/common/formattedPrice/formatted_price.dart';
import 'package:kungwi/common/loading/loading_widget.dart';
import 'package:kungwi/common/phoneNumber/phone_number_filter.dart';
import 'package:kungwi/common/spacer/custom_spacer.dart';
import 'package:kungwi/models/purchases/vifurushi/vifurushi_modal.dart';
import 'package:kungwi/providers/purchases/credit/buy_credit_provider.dart';
import 'package:kungwi/providers/purchases/credit/fetch_credit_provider.dart';
import 'package:kungwi/providers/purchases/monetization/vifurushi/vifurushi_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../providers/shared_preference/shared_preference_provider.dart';

void showToastInDialog(BuildContext context, String title) {
  Fluttertoast.showToast(
    msg: title,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: Theme.of(context).colorScheme.errorContainer,
    // textColor: Colors.white,
    fontSize: 16.0,
  );
}

vifurushiPayWallSheet(BuildContext context, WidgetRef ref,
    {bool cannotPop = false}) {
  VifurushiModalData currentKifurushi = VifurushiModalData();
  ref.read(sharedPreferenceInstanceProvider);
  ref.read(isLoggedInProvider);
  return showDialog(
    barrierDismissible: false,
    context: context,
    useSafeArea: false,
    builder: (BuildContext context) {
      // final vifurushi = ref.watch(fetchVifurushiProvider);
      // final hasSubscribed = ref.watch(isSubscribedProvider).value;
      // ignore: deprecated_member_use
      return WillPopScope(onWillPop: () {
        return Future.value(true);
      }, child: Material(
        child: StatefulBuilder(builder: (context, mysetState) {
          return Container(
            padding: const EdgeInsets.all(16.0),
            width: double.infinity,
            height: double.infinity,
            child: ListView(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        if (cannotPop == false) {
                          context.pop();
                        } else {
                          context.pushNamed('home');
                        }
                      },
                      child: const Icon(
                        FontAwesomeIcons.angleLeft,
                      ),
                    ),
                    const Center(
                      child: Text(
                        "Vifurushi",
                        style: TextStyle(
                          fontFamily: 'DMSans',
                          fontSize: 24,
                          // color: black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(),
                  ],
                ),
                CustomSpacer(
                  height: 2.h,
                ),
                const Center(
                  child: Text(
                    "Chagua kifurushi ukipendacho.",
                    style: TextStyle(
                      fontFamily: 'DMSans',
                      fontSize: 23,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                CustomSpacer(
                  height: 2.h,
                ),
                Center(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: "",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.12,
                          ),
                        ),
                        TextSpan(
                          text: "OFA YA 30%",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.12,
                              color: Theme.of(context)
                                  .colorScheme
                                  .tertiaryContainer // Set the color to green for this portion
                              ),
                        ),
                        const TextSpan(
                          text:
                              " kwa siku ya LEO tu na endapo ukinunua kifurushi LEO utapata PUNGUZO. OFA hii itaisha MUDA SIO MREFU",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                CustomSpacer(
                  height: 3.h,
                ),
                Consumer(builder: (context, ref, child) {
                  final vifurushi = ref.watch(fetchVifurushiProvider);
                  return vifurushi.maybeWhen(
                    orElse: () => const SizedBox(),
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    data: (data) {
                      final vifurushiData = data.data;
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: vifurushiData?.length ?? 0,
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            mysetState(() {
                              currentKifurushi = vifurushiData![index]!;
                            });
                            debugPrint('currentIndex: $currentKifurushi');
                          },
                          child: subscriptionContainer(
                              context,
                              vifurushiData?[index]?.title ?? '',
                              double.parse(
                                  vifurushiData?[index]!.price.toString() ??
                                      '0.0'),
                              vifurushiData?[index]?.description ?? '',
                              currentKifurushi.title.toString()),
                        ),
                      );
                    },
                  );
                }),
                CustomSpacer(
                  height: 2.h,
                ),
                Consumer(
                  builder: (context, ref, child) {
                    final isLoggedIn = ref.watch(isLoggedInProvider);
                    return isLoggedIn.maybeWhen(
                      orElse: () => const SizedBox(),
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      data: (loggedIn) => Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 3.w, vertical: 2.h),
                        child: FilledButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                ),
                                minimumSize: MaterialStateProperty.all(
                                    Size(100.w, 7.h))),
                            onPressed: () {
                              if (currentKifurushi.title == null) {
                                showToastInDialog(
                                    context, 'Tafadhali chagua kifurushi.');
                              } else {
                                if (loggedIn == true) {
                                  phoneNumberPaymentSheet(
                                      context, ref, currentKifurushi);
                                } else {
                                  context.pushNamed('signUp');
                                }
                              }
                            },
                            child: const Text("Nunua Kifurushi")),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        }),
      ));
    },
  );
}

phoneNumberPaymentSheet(
    BuildContext context, WidgetRef ref, VifurushiModalData currentKifurushi) {
  TextEditingController phoneNumberController = TextEditingController();
  bool isPaying = false;
  bool buttonLoading = false;
  return showDialog(
    barrierDismissible: false,
    context: context,
    useSafeArea: false,
    builder: (BuildContext context) {
      // final packages = ref.watch(availablePakcagesProvider);

      // ignore: deprecated_member_use
      return WillPopScope(onWillPop: () {
        return Future.value(true);
      }, child: Material(
        child: StatefulBuilder(builder: (context, mysetState) {
          return SafeArea(
            child: isPaying == true
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 2.h),
                        child: InkWell(
                          onTap: () {
                            context.pop();
                          },
                          child: const Icon(
                            FontAwesomeIcons.x,
                          ),
                        ),
                      ),
                      const LottieLoadingWidget(),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 3.w, vertical: 3.h),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2.w, vertical: 3.h),
                              child: const Text(
                                  "Kama umefanikwia kufanya malipo tafadhali THIBITISHA MALIPO"),
                            ),
                            FilledButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                    ),
                                    minimumSize: MaterialStateProperty.all(
                                        Size(100.w, 7.h))),
                                onPressed: () {
                                  ref
                                      .refresh(fetchCreditProvider.future)
                                      .then((value) {
                                    debugPrint(value.toString());
                                    if (value <= 0) {
                                      messageDialog(context, "Error",
                                          "Hujafanikiwa kununua kifurushi bado. Kama ulishanunua kifurushi na umeshindwa kuthibitisha tafadhali wasiliana nasi Whatsapp");
                                    } else {
                                      messageDialog(context, "Umefanikiwa",
                                              "Hongera umefanikiwa kununua kifurushi. Unaweza kutumia Token hizo kununua Story yeyote.")
                                          .then((value) =>
                                              context.pushNamed('home'));
                                    }
                                  });
                                },
                                child: const Text("Thibitisha Malipo")),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2.w, vertical: 3.h),
                              child: const Text(
                                  "Kama umepata CHANGAMOTO wakati wa  MALIPO. Tafadhali wasiliana nasi WHATSAPP"),
                            ),
                            FilledButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Theme.of(context)
                                                .colorScheme
                                                .errorContainer),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                    ),
                                    minimumSize: MaterialStateProperty.all(
                                        Size(100.w, 7.h))),
                                onPressed: () {
                                  var url = 'https://wa.me/+255755817871';

                                  void launchURL() async {
                                    if (!await launchUrl(Uri.parse(url),
                                        mode: LaunchMode.externalApplication)) {
                                      throw 'Could not launch $url';
                                    }
                                  }

                                  launchURL();
                                },
                                child: const Text("Whatsapp")),
                          ],
                        ),
                      )
                    ],
                  )
                : Container(
                    padding: const EdgeInsets.all(16.0),
                    width: double.infinity,
                    height: double.infinity,
                    child: ListView(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                context.pop();
                              },
                              child: const Icon(
                                FontAwesomeIcons.angleLeft,
                              ),
                            ),
                            const Center(
                              child: Text(
                                "Malipo",
                                style: TextStyle(
                                  fontFamily: 'DMSans',
                                  fontSize: 24,
                                  // color: black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            CustomSpacer(),
                          ],
                        ),
                        CustomSpacer(
                          height: 3.h,
                        ),
                        const Center(
                          child: Text(
                            "Ingiza Namba ya simu",
                            style: TextStyle(
                              fontFamily: 'DMSans',
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        CustomSpacer(
                          height: 1.h,
                        ),
                        Center(
                          child: Text(
                            "Ingiza namba ya simu kukamilisha malipo ya ${currentKifurushi.title} kwa ${formattedPrice(double.parse(currentKifurushi.price.toString()))} utakayoweza kupata STORY yeyote upendayo. ",
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.12,
                            ),
                          ),
                        ),
                        CustomSpacer(
                          height: 7.h,
                        ),
                        TextField(
                          controller: phoneNumberController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              FontAwesomeIcons.magnifyingGlass,
                              size: 13,
                            ),
                            filled: true,
                            hintText: "Namba Ya Simu Ya Malipo",
                            hintStyle: const TextStyle(
                              fontSize: 12.96,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.12,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 14, horizontal: 29),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                        CustomSpacer(
                          height: 1.h,
                        ),
                        const Center(
                          child: Text(
                            "Utapokea menu kutoka kwenye MTANDAO wako kuweza kukamilisha malipo.",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'DMSans',
                            ),
                          ),
                        ),
                        CustomSpacer(
                          height: 12.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 3.w,
                          ),
                          child: FilledButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                  minimumSize: MaterialStateProperty.all(
                                      Size(100.w, 7.h))),
                              onPressed: () {
                                if (buttonLoading == true) {
                                } else {
                                  if (phoneNumberController.text == '') {
                                    showToastInDialog(context,
                                        "Tafadhali weka namba ya simu ya malipo.");
                                  } else {
                                    mysetState(() {
                                      buttonLoading = true;
                                    });
                                    final formattedNumber = phoneNumberFilter(
                                        phoneNumberController.text);
                                    ref
                                        .read(buyCreditProviderProvider(
                                                BuyCreditParms(
                                                    double.parse(
                                                        currentKifurushi.price
                                                            .toString()),
                                                    int.parse(currentKifurushi
                                                        .tokenAmount
                                                        .toString()),
                                                    formattedNumber))
                                            .future)
                                        .then((value) {
                                      if (value.statusCode == 200) {
                                        mysetState(() {
                                          isPaying = true;
                                          // buttonLoading = false;
                                        });
                                      } else {
                                        showToastInDialog(
                                            context, "Tatizo la Ufundi.");
                                        mysetState(() {
                                          buttonLoading = false;
                                        });
                                      }
                                    });
                                  }
                                }
                              },
                              child: buttonLoading == true
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : const Text("Nunua Kifurushi")),
                        ),
                      ],
                    ),
                  ),
          );
        }),
      ));
    },
  );
}

Container subscriptionContainer(BuildContext context, String title,
    double price, String description, String currentIndex) {
  // Calculate the increased price
  double increasedPrice = price * 1.30;

  return Container(
    margin: const EdgeInsets.symmetric(
      vertical: 10,
    ),
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
          color: title == currentIndex
              ? Theme.of(context).colorScheme.primary
              : Colors.transparent),
    ),
    child: Stack(
      children: [
        Row(children: [
          Icon(
            title == currentIndex
                ? FontAwesomeIcons.solidCircle
                : FontAwesomeIcons.circle,
            color: title == currentIndex
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.secondary,
            size: 15,
          ),
          CustomSpacer(
            width: 3.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontFamily: 'DMSans',
                    fontSize: 18,
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'DMSans',
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            formattedPrice(price), // Display the increased price
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontFamily: 'DMSans',
              fontSize: 18,
            ),
          ),
        ]),
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: const BoxDecoration(
              // color:
              //     Colors.green, // Change this to your desired background color
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
            child: Text(
              formattedPrice(increasedPrice), // Display the "30% OFF" label
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                color: Theme.of(context).colorScheme.errorContainer,
                fontWeight: FontWeight.bold,
                fontFamily: 'DMSans',
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
