import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_app/global/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ImageNetworkWidget extends StatelessWidget {
  const ImageNetworkWidget({
    required this.imageUrl,
    super.key,
    this.width,
    this.height,
    this.fit,
  });
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit ?? BoxFit.cover,
      height: height,
      placeholder: (context, url) => SizedBox(
        height: height,
        width: width,
        child: Center(
          child: LoadingAnimationWidget.staggeredDotsWave(
            color: appPrimaryColor,
            size: 20,
          ),
        ),
      ),
      errorWidget: (context, url, error) => const Icon(
        Icons.error,
        color: appPrimaryColor,
      ),
    );
  }
}
