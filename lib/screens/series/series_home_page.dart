import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kungwi/providers/series/series_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SeriesPage extends ConsumerStatefulWidget {
  const SeriesPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SeriesPageState();
}

class _SeriesPageState extends ConsumerState<SeriesPage> {
  @override
  Widget build(BuildContext context) {
    final allSeries = ref.watch(fetchAllSeriesProvider);
    return Scaffold(
        body: allSeries.maybeWhen(
            orElse: () => const SizedBox(),
            loading: () => const Center(
                  child: CupertinoActivityIndicator(),
                ),
            data: (allSeriesData) {
              return SafeArea(
                  child: ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: 3.w,
                  vertical: 2.h,
                ),
                children: [
                  Text(
                    "Series",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  GridView.builder(
                      shrinkWrap: true,
                      itemCount: allSeriesData.length,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 25,
                      ),
                      itemBuilder: (context, index) {
                        final seriesData = allSeriesData[index];
                        return InkWell(
                          onTap: () {
                            context.pushNamed("seriesDetailsPage",
                                extra: seriesData);
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: FastCachedImageProvider(
                                        seriesData.seriesImage.toString(),
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                seriesData.videoTitle.toString(),
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ],
              ));
            }));
  }
}
