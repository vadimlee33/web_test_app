import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_test_app/src/locator_service.dart';
import 'package:web_test_app/src/presentation/blocs/image_bloc/image_bloc.dart';
import 'package:web_test_app/src/presentation/widgets/image_detail_view_dialog.dart';

class ImageGridView extends StatelessWidget {
  final imageBloc = sl<ImageBloc>();
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  ImageGridView({
    super.key,
  }) {
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    final isLoadingNewImages = sl<ImageBloc>().isLoadingNewImages;
    final String query = sl<ImageBloc>().query;
    if (maxScroll - currentScroll <= _scrollThreshold && !isLoadingNewImages) {
      sl<ImageBloc>().add(ImageFetched(query: query));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageBloc, ImageState>(
      builder: (context, state) {
        if (state is ImageSuccess) {
          if (state.isQueryChanged && _scrollController.hasClients) {
            _scrollController.animateTo(
              0.0,
              curve: Curves.easeOut,
              duration: const Duration(milliseconds: 300),
            );
          }
          return LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              const double itemSize = 300.0;
              final count = (width / itemSize).floor();
              final isLoadingNewImages = sl<ImageBloc>().isLoadingNewImages;
              return GridView.builder(
                controller: _scrollController,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: count,
                  childAspectRatio: 1,
                ),
                itemCount: state.hasReachedMax
                    ? state.images.length
                    : state.images.length + 1,
                itemBuilder: (context, index) {
                  return index >= state.images.length
                      ? isLoadingNewImages
                          ? const Center(
                              child: SizedBox(
                                child: CircularProgressIndicator(
                                  strokeWidth: 1.5,
                                  color: Colors.red,
                                ),
                              ),
                            )
                          : Container()
                      : GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => ImageDetailViewDialog(
                                  image: state.images[index]),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: GridTile(
                              footer: GridTileBar(
                                backgroundColor: Colors.black54,
                                title: Row(
                                  children: [
                                    const Icon(Icons.favorite,
                                        color: Colors.white),
                                    Text(' ${state.images[index].likes} '),
                                    const Spacer(),
                                    const Icon(Icons.visibility,
                                        color: Colors.white),
                                    Text(' ${state.images[index].views}'),
                                  ],
                                ),
                              ),
                              child: Image.network(
                                state.images[index].url,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ));
                },
              );
            },
          );
        } else if (state is ImagesEmpty) {
          return const Center(child: Text('No images found'));
        } else if (state is ImageFailure) {
          return const Center(child: Text('Failed to fetch images'));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
