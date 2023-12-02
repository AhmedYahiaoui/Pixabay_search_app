import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_search_app/blocs/images_search/image_search_bloc.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({Key? key}) : super(key: key);

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _controller = TextEditingController();
  String _previousQuery = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Type your search query here  .. 👇',
              ),
              autofocus: false,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {
              String query = _controller.text;
              if (query.isNotEmpty && query != _previousQuery) {
                _previousQuery = query;

                BlocProvider.of<ImageSearchBloc>(context).add(
                  FetchImagesEvent(
                    query: query,
                    page: 1,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
