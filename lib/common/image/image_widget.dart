import 'package:flutter/material.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';

Widget imageWidget(String imageUrl, [double? height = 0, double? width = 0]) {
  return FastCachedImage(
      url: imageUrl,
      loadingBuilder: (context, progress) {
        return Shimmer.fromColors(
          baseColor: const Color.fromARGB(255, 160, 156, 156),
          highlightColor: Colors.grey.shade100,
          child: SizedBox(
            width: width,
            height: height?.toDouble() ?? 500.0,
            child: Container(),
          ),
        );
      },
      fit: BoxFit.cover,
      fadeInDuration: const Duration(seconds: 1),
      errorBuilder: (context, exception, stacktrace) {
        return const Icon(FontAwesomeIcons.image);
      });
}

FastCachedImageProvider fastCachedNetwrokImageProvider(String imageUrl) {
  return FastCachedImageProvider(imageUrl);
}
