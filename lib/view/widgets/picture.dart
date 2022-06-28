import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';



class Picture extends StatelessWidget {
  const Picture(
      {Key? key,
      required this.url,
      required this.radius,
      required this.isLocalRep,
      this.fit,
      this.height,
      this.width,
      })
      : super(key: key);

  final String url;
  final double radius;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final bool isLocalRep;
  

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        child: (isLocalRep) ?
          Image.asset(url)
         : CachedNetworkImage(
          imageUrl: url,
          errorWidget: (context, url, error) => const Icon(Icons.error),
          placeholder: (context, url) => const CircularProgressIndicator()   
        ));
  }
}
