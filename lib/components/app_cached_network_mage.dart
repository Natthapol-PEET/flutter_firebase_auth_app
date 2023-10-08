import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth_app/components/app_loading.dart';

class AppCachedNetworkImage extends StatelessWidget {
  final String imageUrl;

  const AppCachedNetworkImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            color: Colors.grey.shade200,
            child: const AppLoading(),
          ),
        ],
      ),
      errorWidget: (context, url, error) => Container(
        width: 100,
        color: Colors.grey.shade200,
        child: const Icon(Icons.error, size: 40),
      ),
      height: 160,
      width: 160,
      fit: BoxFit.fill,
    );
  }
}
