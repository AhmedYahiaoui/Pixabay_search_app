import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_search_app/blocs/images_search/image_search_bloc.dart';
import 'widgets/search_bar.dart';
import 'widgets/image_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pixabay Search App'),
      ),
      body: BlocProvider(
        create: (context) => ImageSearchBloc(),
        child: Column(
          children: [
            const SearchBarWidget(),
            Expanded(
              child: ImageList(),
            ),
          ],
        ),
      ),
    );
  }
}
