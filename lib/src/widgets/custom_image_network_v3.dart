import 'dart:convert';
import 'package:custom_network_image/src/services/cache_file_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomImageNetworkV3 extends StatefulWidget {
  final String source;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Widget? errorWidget;
  final Widget? placeHolderWidget;
  final Color? color;
  final Duration? cacheDuration;

  const CustomImageNetworkV3(
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
  CustomImageNetworkV3State createState() => CustomImageNetworkV3State();
}

class CustomImageNetworkV3State extends State<CustomImageNetworkV3> {
  final CacheFileService _service = CacheFileService();

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
      String encodedImage = await _service.getImage(widget.source) ?? '';
      Uint8List imageBytes;
      if (encodedImage.isNotEmpty) {
        imageBytes = base64Decode(encodedImage);
      } else {
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
