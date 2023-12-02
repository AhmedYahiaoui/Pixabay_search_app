part of 'image_search_bloc.dart';

abstract class ImageSearchState {}

class ImageSearchInitial extends ImageSearchState {}

class ImageSearchSuccess extends ImageSearchState {
  final List<PixabayImage> images;
  final bool hasMore;
  final String? query;

  ImageSearchSuccess({required this.images, required this.hasMore, this.query});
}

class ImageSearchFailure extends ImageSearchState {
  final String error;

  ImageSearchFailure({required this.error});
}
