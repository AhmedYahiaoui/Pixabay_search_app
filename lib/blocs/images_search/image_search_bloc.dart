import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:image_search_app/models/pixabay_image.dart';

part 'image_search_event.dart';
part 'image_search_state.dart';

class ImageSearchBloc extends Bloc<ImageSearchEvent, ImageSearchState> {
  final String pixabayApiKey = '39895250-6ba3002ea49bd06791573051a';
  final String pixabayEndPoint = 'https://pixabay.com/api/';

  final Dio _dio = Dio();
  final List<PixabayImage> _imageResults = [];
  int _currentPage = 1;
  int _totalPages = 1;
  String _currentQuery = '';

  ImageSearchBloc() : super(ImageSearchInitial());

  @override
  Stream<ImageSearchState> mapEventToState(ImageSearchEvent event) async* {
    if (event is FetchImagesEvent) {
      try {
        if (event.query != _currentQuery || event.page != _currentPage) {
          _currentQuery = event.query;
          _imageResults.clear();
          _currentPage = 1;
        }
        final response = await _dio.get(
          pixabayEndPoint,
          queryParameters: {
            'key': pixabayApiKey,
            'q': event.query,
            'page': _currentPage,
          },
        );

        final List<PixabayImage> newImages = (response.data['hits'] as List)
            .map((imageJson) => PixabayImage.fromJson(imageJson))
            .toList();

        _imageResults.addAll(newImages);
        _totalPages = (response.data['totalHits'] as int) ~/ 20;

        yield ImageSearchSuccess(
            images: _imageResults,
            hasMore: _currentPage < _totalPages,
            query: event.query);
      } catch (e) {
        yield ImageSearchFailure(error: 'Failed to fetch images');
      }
    }
  }

  Future<void> loadNextPage(String query) async {
    _currentPage++;
    add(FetchImagesEvent(query: query, page: _currentPage));
  }
}
