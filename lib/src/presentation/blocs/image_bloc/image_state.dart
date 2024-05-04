part of 'image_bloc.dart';

abstract class ImageState extends Equatable {
  const ImageState();

  @override
  List<Object> get props => [];
}

class ImageInitial extends ImageState {}

class ImagesEmpty extends ImageState {}

class ImageSuccess extends ImageState {
  final List<ImageModel> images;
  final bool hasReachedMax;
  final bool isQueryChanged;

  const ImageSuccess(this.images, this.hasReachedMax, this.isQueryChanged);

  @override
  List<Object> get props => [images, hasReachedMax];
}

class ImageFailure extends ImageState {}
