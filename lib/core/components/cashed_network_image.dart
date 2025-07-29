import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yalla_nebi3/core/components/custom_circle_indicitor.dart';

class CahedNetworkImage extends StatelessWidget {
  final String url;
  const CahedNetworkImage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      placeholder:
          (context, url) => SizedBox(
            height: 200,

            width: double.infinity,
            child: CustomCircleProgressIndicictor(),
          ),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
