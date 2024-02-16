import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kungwi/common/modals/purchase/vifurushi/vifurushi_paywall.dart';

import 'package:kungwi/providers/purchases/credit/buy_story_credit_provider.dart';
import 'package:kungwi/providers/purchases/credit/fetch_credit_provider.dart';
import 'package:kungwi/providers/purchases/monetization/storyStatus/has_purchased_story_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void audioPaywall(BuildContext context, WidgetRef ref, String? storyName) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
    ),
    builder: (BuildContext context) {
      return Container(
        height: 35.h,
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.h),
                  child: const Center(
                    child: Text(
                      "Unahitaji kifurushi kuendelea",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: Text(
                    "Ukiwa na kifurushi unaweza kusoma vipande VYOTE vya ${storyName?.toUpperCase() ?? ''} bila KIKOMO muda WOWOTE.",
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
              child: FilledButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      minimumSize: MaterialStateProperty.all(Size(100.w, 7.h))),
                  onPressed: () {
                    vifurushiPayWallSheet(context, ref);
                  },
                  child: const Text("Angalia Vifurushi")),
            ),
            const SizedBox()
          ],
        ),
      );
    },
  );
}

void tumiaCreditWall(
    BuildContext context, WidgetRef ref, int credits, audioModalDataEpisodes) {
  bool isLoading = false;
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
    ),
    builder: (BuildContext context) {
      return StatefulBuilder(builder: (context, mySetState) {
        return Container(
          height: 35.h,
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 5,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h),
                child: const Center(
                  child: Text(
                    "Unahitaji kifurushi kuendelea",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: Text(
                  "Unazo TOKEN $credits ambazo unaweza kununua STORY hii bila MALIPO ya ziada YEYOTE. Utatumia TOKEN 200 kila STORY.",
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 16),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
                child: FilledButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        minimumSize:
                            MaterialStateProperty.all(Size(100.w, 7.h))),
                    onPressed: isLoading == true
                        ? null
                        : () async {
                            mySetState(() {
                              isLoading = true;
                            });
                            await ref
                                .read(buyStoryTokenProvider(BuyStoryCreditParms(
                                        audioModalDataEpisodes.storyId
                                            .toString(),
                                        'Audio',
                                        3000,
                                        200))
                                    .future)
                                .then((value) => ref
                                    .refresh(fetchCreditProvider.future)
                                    .then((value) => ref
                                            .refresh(purchasedStroryProvider(
                                                    PurchasedStoryParms(
                                                        audioModalDataEpisodes
                                                            .storyId
                                                            .toString(),
                                                        'Audio'))
                                                .future)
                                            .then((value) {
                                          context.pop();
                                        })));
                          },
                    child: const Text("Tumia Token")),
              )
            ],
          ),
        );
      });
    },
  );
}
