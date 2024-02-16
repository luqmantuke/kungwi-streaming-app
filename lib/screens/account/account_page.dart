import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AccountPage extends ConsumerStatefulWidget {
  const AccountPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AccountPageState();
}

class _AccountPageState extends ConsumerState<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 1.h,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              "General",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 11,
            ),
            decoration: BoxDecoration(
              color: const Color(0x3D223A5E),
              borderRadius: BorderRadius.circular(
                15,
              ),
            ),
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                InkWell(
                  onTap: () {
                    var url = 'https://t.me/manutdfx';

                    void launchURL() async {
                      if (!await launchUrl(Uri.parse(url),
                          mode: LaunchMode.externalApplication)) {
                        throw 'Could not launch $url';
                      }
                    }

                    launchURL();
                  },
                  child: _accountWidgets(
                      FontAwesomeIcons.telegram, "Customer Support Telegram"),
                ),
                const Divider(),
                SizedBox(
                  height: 2.h,
                ),
                InkWell(
                  onTap: () {
                    var url = 'https://wa.me/+255629598762';

                    void launchURL() async {
                      if (!await launchUrl(Uri.parse(url),
                          mode: LaunchMode.externalApplication)) {
                        throw 'Could not launch $url';
                      }
                    }

                    launchURL();
                  },
                  child: _accountWidgets(
                      FontAwesomeIcons.whatsapp, "Customer Support Whatsapp"),
                ),
                const Divider(),
                SizedBox(
                  height: 2.h,
                ),
                InkWell(
                  onTap: () async {
                    var url = Platform.isAndroid
                        ? 'https://play.google.com/store/apps/details?id=com.tukesolutions.fxlog'
                        : "https://apps.apple.com/us/app/kungwi/id6459458332";
                    Share.share(
                        'Burudika na STORY mbalimbali zenye kusisimua,visa n.k kupitia kungwi App. $url');
                  },
                  child: _accountWidgets(
                    FontAwesomeIcons.share,
                    "Share With Friends",
                  ),
                ),
                const Divider(),
                SizedBox(
                  height: 2.h,
                ),
                InkWell(
                  onTap: () {
                    var url = Platform.isAndroid
                        ? 'https://play.google.com/store/apps/details?id=com.tukesolutions.kungwi'
                        : "https://apps.apple.com/us/app/kungwi/id6459458332";

                    void launchURL() async {
                      if (!await launchUrl(Uri.parse(url),
                          mode: LaunchMode.externalApplication)) {
                        throw 'Could not launch $url';
                      }
                    }

                    launchURL();
                  },
                  child: Platform.isAndroid
                      ? _accountWidgets(
                          FontAwesomeIcons.googlePlay, "Rate Us On PlayStore")
                      : _accountWidgets(
                          FontAwesomeIcons.appStore, "Rate Us On AppStore"),
                ),
                const Divider(),
                SizedBox(
                  height: 2.h,
                ),
                InkWell(
                  onTap: () {
                    var url = 'https://facebook.com/kungwi_app';

                    void launchURL() async {
                      if (!await launchUrl(Uri.parse(url),
                          mode: LaunchMode.externalApplication)) {
                        throw 'Could not launch $url';
                      }
                    }

                    launchURL();
                  },
                  child: _accountWidgets(
                      FontAwesomeIcons.facebook, "Follow Us On Facebook"),
                ),
                const Divider(),
                SizedBox(
                  height: 2.h,
                ),
                InkWell(
                  onTap: () {
                    var url = 'https://instagram.com/kungwi_app';

                    void launchURL() async {
                      if (!await launchUrl(Uri.parse(url),
                          mode: LaunchMode.externalApplication)) {
                        throw 'Could not launch $url';
                      }
                    }

                    launchURL();
                  },
                  child: _accountWidgets(
                      FontAwesomeIcons.instagram, "Follow Us On Instagram"),
                ),
                const Divider(),
                SizedBox(
                  height: 2.h,
                ),
                InkWell(
                  onTap: () {
                    var url =
                        'https://dashing-magic-1ac.notion.site/kungwi-97ce2676adb143b2bc3678c449b6a1b6?pvs=4';

                    void launchURL() async {
                      if (!await launchUrl(Uri.parse(url),
                          mode: LaunchMode.externalApplication)) {
                        throw 'Could not launch $url';
                      }
                    }

                    launchURL();
                  },
                  child: _accountWidgets(
                      FontAwesomeIcons.globe, "Privacy And Policy"),
                ),
                const Divider(),
                SizedBox(
                  height: 2.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _accountWidgets(IconData icon, String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(
                right: 8,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.all(8),
              child: Icon(
                icon,
                size: 15,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ],
        ),
        const Icon(
          FontAwesomeIcons.angleRight,
          size: 15,
        ),
      ],
    ),
  );
}
