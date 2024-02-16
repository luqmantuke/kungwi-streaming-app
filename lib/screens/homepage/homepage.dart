import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:kungwi/common/modals/purchase/vifurushi/vifurushi_paywall.dart';
import 'package:kungwi/providers/purchases/credit/fetch_credit_provider.dart';
import 'package:kungwi/providers/series/series_provider.dart';
import 'package:kungwi/providers/shared_preference/shared_preference_provider.dart';
import 'package:kungwi/providers/videos/videos_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final trendingVideos = ref.watch(fetchTrendingVideosProvider);
    return Scaffold(
        body: trendingVideos.maybeWhen(
            orElse: () => const SizedBox(),
            loading: () => const Center(
                  child: CupertinoActivityIndicator(),
                ),
            data: (trendingVideosData) {
              return ListView(
                padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
                children: [
                  const BannerSlider(),
                  SizedBox(
                    width: 100.h,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: trendingVideosData.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: 3.h,
                            ),
                            child: InkWell(
                              onTap: () {
                                ref
                                    .read(isLoggedInProvider.future)
                                    .then((isLoggedIn) {
                                  if (isLoggedIn == true) {
                                    ref
                                        .read(userHasCreditsProvider.future)
                                        .then((userHasCredits) {
                                      if (userHasCredits == true) {
                                        context.pushNamed('videoDetailsPage',
                                            extra: trendingVideosData[index]);
                                      } else {
                                        vifurushiPayWallSheet(context, ref);
                                      }
                                    });
                                  } else {
                                    context.pushNamed("signUp");
                                  }
                                });
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 30.h,
                                    width: 100.w,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: FastCachedImageProvider(
                                            trendingVideosData[index]
                                                .videoImage
                                                .toString(),
                                          ),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Center(
                                        child: Icon(
                                      FontAwesomeIcons.circlePlay,
                                      size: 50,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .errorContainer,
                                    )),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 1.w),
                                    child: Text(
                                      trendingVideosData[index]
                                          .videoTitle
                                          .toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  )
                ],
              );
            }));
  }
}

class BannerSlider extends StatelessWidget {
  const BannerSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final trendingSeries = ref.watch(fetchTrendingSeriesProvider);
        return trendingSeries.maybeWhen(
            orElse: () => const SizedBox(),
            loading: () => Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Colors.black.withOpacity(0),
                      ],
                    ),
                  ),
                  child: Container(
                    height: 45.h,
                    width: 100.w,
                    decoration: const BoxDecoration(),
                    foregroundDecoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(
                              0.9), // Start with a less opaque black
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        stops: const [
                          0.4,
                          0.8
                        ], // Start from the very bottom and fade to 80%
                      ),
                    ),
                  ),
                ),
            data: (trendingSeriesData) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Colors.black.withOpacity(0),
                    ],
                  ),
                ),
                child: ImageSlideshow(
                  height: 45.h,
                  autoPlayInterval: 9000,
                  isLoop: true,
                  children: trendingSeriesData
                      .map((item) => Stack(
                            children: <Widget>[
                              Positioned(
                                  height: 50.h,
                                  width: 100.w,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: FastCachedImageProvider(
                                              item.seriesImage.toString(),
                                            ),
                                            fit: BoxFit.cover)),
                                    foregroundDecoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.black.withOpacity(
                                              0.9), // Start with a less opaque black
                                          Colors.transparent,
                                        ],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        stops: const [
                                          0.4,
                                          0.8
                                        ], // Start from the very bottom and fade to 80%
                                      ),
                                    ),
                                  )),
                              Positioned(
                                top: 25.h,
                                left: 30.w,
                                child: Center(
                                  child: Text(
                                    item.videoTitle.toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Positioned(
                                  top: 33.h,
                                  left: 33.w,
                                  child: FilledButton(
                                      onPressed: () {
                                        context.pushNamed('seriesDetailsPage',
                                            extra: item);
                                      },
                                      child: const Text("Tazama Sasa")))
                            ],
                          ))
                      .toList(),
                ),
              );
            });
        // Hello world
      },
    );
  }
}

class LinearGradientContainer extends StatelessWidget {
  final double height;
  final List<Color> colors;

  const LinearGradientContainer(
      {super.key, required this.height, required this.colors});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        image: const DecorationImage(
            image: FastCachedImageProvider(
              'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fi.ytimg.com%2Fvi%2FmB3vfEnvsH0%2Fmaxresdefault.jpg&f=1&nofb=1&ipt=afc069694c6550b8ae81b025d4afac7aaab1b14b1359641e0152715ecc55fcf6&ipo=images',
            ),
            fit: BoxFit.cover),
        gradient: LinearGradient(colors: colors),
      ),
    );
  }
}
