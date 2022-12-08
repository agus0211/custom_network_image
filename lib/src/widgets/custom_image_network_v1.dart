import 'dart:convert';

import 'package:custom_network_image/src/models/cache_image_sqflite_model.dart';
import 'package:custom_network_image/src/services/sqflite_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomImageNetworkV1 extends StatefulWidget {
  final String source;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Widget? errorWidget;
  final Widget? placeHolderWidget;
  final Color? color;
  final Duration? cacheDuration;

  const CustomImageNetworkV1(
    this.source, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.errorWidget,
    this.placeHolderWidget,
    this.color,
    this.cacheDuration,
  });

  @override
  CustomImageNetworkV1State createState() => CustomImageNetworkV1State();
}

class CustomImageNetworkV1State extends State<CustomImageNetworkV1> {
  final SqfliteService _service = SqfliteService();

  ImageProvider? _imageProvider;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    streamImage();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _getImage();
  }

  Widget _getImage() {
    Widget? defaultErrorWidget = widget.errorWidget;
    if (isError) {
      return defaultErrorWidget ?? const SizedBox.shrink();
    }

    ImageProvider? provider = _imageProvider;
    if (provider == null) {
      return const Center(
        child: SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Image(
      image: provider,
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      color: widget.color,
    );
  }

  Future streamImage() async {
    try {
      String encodedImage = await _service.getSingleImage(widget.source) ?? '';
      Uint8List imageBytes;
      if (encodedImage.isNotEmpty) {
        debugPrint('Resolve image from cache');
        imageBytes = base64Decode(encodedImage);
      } else {
        debugPrint('Resolve image from uri');
        imageBytes = await getImageBytes();
        _service.insertImage(
          param: CacheImageSqfliteModel(
            encodedImage: base64Encode(imageBytes),
            url: widget.source,
            expiredAt: DateTime.now().add(
              widget.cacheDuration ?? const Duration(days: 1),
            ),
          ),
        );
      }

      setState(() {
        _imageProvider = MemoryImage(imageBytes);
      });
    } catch (e) {
      debugPrint('error stream image: $e');
      setState(() {
        isError = true;
      });
    }
  }

  Future<Uint8List> getImageBytes() async {
    final ByteData imageData =
        await NetworkAssetBundle(Uri.parse(widget.source)).load('');
    return imageData.buffer.asUint8List();
  }
}
