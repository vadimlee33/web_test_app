import 'dart:async';

import 'package:flutter/material.dart';
import 'package:web_test_app/src/locator_service.dart';
import 'package:web_test_app/src/presentation/blocs/image_bloc/image_bloc.dart';
import 'package:web_test_app/src/presentation/widgets/image_grid_view.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();
  final imageBloc = sl<ImageBloc>();
  Timer? _debounce;

  HomePage({super.key}) {
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      imageBloc.add(ImageFetched(query: _searchController.text));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Поиск',
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
            ),
          ),
          Expanded(
            child: ImageGridView(),
          ),
        ],
      ),
    );
  }
}
