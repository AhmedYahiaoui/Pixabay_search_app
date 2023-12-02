import 'package:flutter_test/flutter_test.dart';
import 'package:image_search_app/blocs/images_search/image_search_bloc.dart';

void main() {
  group('ImageSearchBloc', () {
    test('Initial state is correct', () {
      final bloc = ImageSearchBloc();
      expect(bloc.state, equals(ImageSearchInitial()));
    });

    test('Emits ImageSearchSuccess state on successful fetch', () async {
      final bloc = ImageSearchBloc();

      bloc.add(FetchImagesEvent(query: 'example', page: 1));

      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<ImageSearchSuccess>(),
        ]),
      );
    });

    test('Emits ImageSearchFailure state on failed fetch', () async {
      final bloc = ImageSearchBloc();

      bloc.add(FetchImagesEvent(query: 'invalid_query', page: 1));

      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<ImageSearchFailure>(),
        ]),
      );
    });

    test('Loads next page successfully', () async {
      final bloc = ImageSearchBloc();

      bloc.add(FetchImagesEvent(query: 'example', page: 1));
      bloc.loadNextPage('example');

      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<ImageSearchSuccess>(),
          isA<ImageSearchSuccess>(),
        ]),
      );
    });
  });
}
