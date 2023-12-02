part of 'image_search_bloc.dart';

abstract class ImageSearchEvent {}

class FetchImagesEvent extends ImageSearchEvent {
  final String query;
  final int page;

  FetchImagesEvent({required this.query, required this.page});
}
