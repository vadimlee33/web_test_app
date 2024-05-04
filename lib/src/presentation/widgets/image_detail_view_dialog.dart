import 'package:flutter/material.dart';
import 'package:web_test_app/src/domain/entities/image_model.dart';

class ImageDetailViewDialog extends StatelessWidget {
  final ImageModel image;

  const ImageDetailViewDialog({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        alignment: Alignment.topRight,
        children: <Widget>[
          Image.network(image.url),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: Row(
              children: <Widget>[
                const Icon(Icons.favorite, color: Colors.white),
                Text(' ${image.likes}   ',
                    style: const TextStyle(color: Colors.white)),
                const Icon(Icons.visibility, color: Colors.white),
                Text(' ${image.views}',
                    style: const TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
