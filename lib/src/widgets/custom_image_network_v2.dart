import 'dart:convert';
import 'package:custom_network_image/src/services/cache_image_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomImageNetworkV2 extends StatefulWidget {
  final String source;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Color? color;
  final Duration? cacheDuration;
  final Widget? errorWidget;
  final Widget? placeHolderWidget;

  const CustomImageNetworkV2(
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
  CustomImageNetworkV2State createState() => CustomImageNetworkV2State();
}

class CustomImageNetworkV2State extends State<CustomImageNetworkV2> {
  final CacheImageService _service = CacheImageService();

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
    if (isError) {
      return widget.errorWidget ?? const SizedBox.shrink();
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
      String encodedImage = await _service.getImage(widget.source) ?? '';
      Uint8List imageBytes;
      if (encodedImage.isNotEmpty) {
        debugPrint('Resolve image from cache');
        imageBytes = base64Decode(encodedImage);
      } else {
        debugPrint('Resolve image from uri');
        imageBytes = await getImageBytes();
        _service.saveImage(
          url: widget.source,
          encodedImage: base64Encode(imageBytes),
          duration: widget.cacheDuration ?? const Duration(days: 1),
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
