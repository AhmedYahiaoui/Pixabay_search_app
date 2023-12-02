import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_search_app/models/pixabay_image.dart';
import 'package:image_search_app/screens/home/widgets/text_widget.dart';

class ImageDetailPage extends StatelessWidget {
  final PixabayImage image;

  const ImageDetailPage({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          text: image.type,
          color: Colors.white,
        ),
      ),
      body: Center(
        child: CachedNetworkImage(
          imageUrl: image.largeImageURL,
          fit: BoxFit.contain,
          height: double.infinity,
          width: double.infinity,
        ),
      ),
    );
  }
}
