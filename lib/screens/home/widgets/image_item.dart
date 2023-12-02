import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_search_app/models/pixabay_image.dart';
import 'package:image_search_app/screens/home/widgets/text_widget.dart';
import 'package:image_search_app/screens/image/image_detail_page.dart';

class ImageItem extends StatelessWidget {
  final PixabayImage image;
  final Function? onTap;

  const ImageItem({
    Key? key,
    required this.image,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap ??
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ImageDetailPage(
                  image: image,
                ),
              ),
            );
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: image
                    .largeImageURL, // since we're using CachedNetworkImage the image will fetched once and gonna be saved once in cache
                fit: BoxFit.fill,
                height: MediaQuery.of(context).size.height * .3,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                  color: Colors.black.withOpacity(0.3),
                ),
                padding: const EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        const Icon(
                          Icons.remove_red_eye_sharp,
                          color: Colors.white,
                        ),
                        TextWidget(
                          text: image.downloads.toString(),
                          color: Colors.white,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Icon(
                          Icons.favorite,
                          color: Colors.white,
                        ),
                        TextWidget(
                          text: image.likes.toString(),
                          color: Colors.white,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Icon(
                          Icons.insert_comment,
                          color: Colors.white,
                        ),
                        TextWidget(
                          text: image.comments.toString(),
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
