import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:kungwi/models/series/series_model.dart';
import 'package:kungwi/models/videos/videos_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SeriesDetailsPage extends ConsumerStatefulWidget {
  final SeriesModelData seriesData;
  const SeriesDetailsPage({super.key, required this.seriesData});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SeriesDetailsPageState();
}

class _SeriesDetailsPageState extends ConsumerState<SeriesDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kungwi Series'),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            context.pop();
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            // color: kTextColor,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(children: [
        Container(
          height: 30.h,
          width: 100.w,
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0.9), // Start with a less opaque black
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
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: FastCachedImageProvider(
                  widget.seriesData.seriesImage.toString()),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 2.w,
            vertical: 1.h,
          ),
          child: Text(
            widget.seriesData.seriesDescription.toString(),
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 2.w,
            vertical: 1.h,
          ),
          child: Text(
            "Episodes (${widget.seriesData.seriesEpisodes?.length})",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          width: 100.h,
          child: ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: 2.w,
                vertical: 1.h,
              ),
              shrinkWrap: true,
              itemCount: widget.seriesData.seriesEpisodes?.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final seriesEpisode = widget.seriesData.seriesEpisodes?[index];
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: 3.h,
                  ),
                  child: InkWell(
                    onTap: () {
                      VideosModelData videoData = VideosModelData(
                          id: seriesEpisode?.id,
                          videoTitle: seriesEpisode?.episodeTitle,
                          videoDescription: seriesEpisode?.episodeDescription,
                          videoImage: seriesEpisode?.episodeImage,
                          videoUrl: seriesEpisode?.episodeUrl.toString());
                      context.pushNamed('videoDetailsPage', extra: videoData);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 30.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                                image: FastCachedImageProvider(
                                  "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fi.ytimg.com%2Fvi%2FmB3vfEnvsH0%2Fmaxresdefault.jpg&f=1&nofb=1&ipt=afc069694c6550b8ae81b025d4afac7aaab1b14b1359641e0152715ecc55fcf6&ipo=images",
                                ),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                              child: Icon(
                            FontAwesomeIcons.circlePlay,
                            size: 50,
                            color: Theme.of(context).colorScheme.errorContainer,
                          )),
                        ),
                        const Text(
                          "Namna Bora Yakumfanya Mwanamke Afike Kileleni Ndani Ya Muda Mchache",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }),
        )
      ]),
    );
  }
}
