import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_search_app/blocs/images_search/image_search_bloc.dart';
import 'package:image_search_app/screens/home/widgets/text_widget.dart';
import 'image_item.dart';

class ImageList extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  ImageList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageSearchBloc, ImageSearchState>(
      builder: (context, state) {
        if (state is ImageSearchInitial) {
          return const Center(
              child:
                  TextWidget(text: 'Make your search by write your query 👆.'));
        } else if (state is ImageSearchSuccess) {
          return NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              if (scrollNotification is ScrollEndNotification &&
                  _scrollController.position.extentAfter == 0) {
                if (state.images.isNotEmpty) {
                  BlocProvider.of<ImageSearchBloc>(context).loadNextPage(
                    state.query ?? '',
                  );
                }
              }
              return false;
            },
            child: ListView.builder(
              controller: _scrollController,
              primary: false,
              itemCount: state.images.length + (state.hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < state.images.length) {
                  return ImageItem(image: state.images[index]);
                } else {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
          );
        } else if (state is ImageSearchFailure) {
          return Center(
            child: TextWidget(text: 'Error: ${state.error}'),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
