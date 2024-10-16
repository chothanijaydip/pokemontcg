import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../utils/custom_loading_indicators/loading_indicators.dart';

// ignore: must_be_immutable
class PostItemImage extends StatefulWidget {
  PostItemImage({
    super.key,
    required this.imageLink,
    this.onTap,
  });
  String imageLink;
  final VoidCallback? onTap;
  @override
  State<PostItemImage> createState() => _PostItemImageState();
}

class _PostItemImageState extends State<PostItemImage> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.imageLink,
      child: GestureDetector(
        onTap: widget.onTap,
        child: CachedNetworkImage(
          imageUrl: widget.imageLink,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                // fit: BoxFit.fill,
              ),
            ),
          ),
          placeholder: (context, url) =>
              const Stack(children: [Center(child: LoadingIndicators())]),
          errorWidget: (context, url, error) => Container(),
        ),
      ),
    );
  }
}
