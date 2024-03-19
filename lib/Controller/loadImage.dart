// ignore_for_file: file_names, avoid_function_literals_in_foreach_calls, empty_catches

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

Future<ImageInfo> _getUiImage(String path) async {
  Completer<ImageInfo> completer = Completer();
  CachedNetworkImageProvider networkImageProvider =
      CachedNetworkImageProvider(path);

  networkImageProvider
      .resolve(const ImageConfiguration())
      .addListener(ImageStreamListener((ImageInfo info, bool _) {
    completer.complete(info);
  }));

  ImageInfo imageInfo = await completer.future;

  return imageInfo;
}

Future<ImageDetails?> loadImagesToPaint(String path, Size size) async {
  final ImageDetails completedLevelImageDetails = ImageDetails(
      imageInfo: await _getUiImage(path), size: Size(size.width, size.height));

  return completedLevelImageDetails;
}

class ImageDetails {
  final ImageInfo imageInfo;
  final Size size;

  ImageDetails({required this.imageInfo, required this.size});
}
