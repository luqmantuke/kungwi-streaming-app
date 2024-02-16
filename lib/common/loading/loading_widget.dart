import 'package:flutter/material.dart';
import 'package:kungwi/utilities/assets/images_index.dart';

import 'package:lottie/lottie.dart';

class LottieLoadingWidget extends StatelessWidget {
  const LottieLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Lottie.asset(loadingIcon, alignment: Alignment.center));
  }
}
