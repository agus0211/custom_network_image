import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'ad_network_image_service.dart';

class ADNetworkImageWidget extends StatefulWidget {
  final String source;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Widget Function(
    BuildContext context,
    Object? error,
  )? onError;
  final Widget Function(BuildContext context)? onLoading;
  final Color? color;
  final Duration? cacheDuration;
  final Duration? timeoutDuration;

  const ADNetworkImageWidget(
    this.source, {
    Key? key,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.onError,
    this.onLoading,
    this.color,
    this.cacheDuration,
    this.timeoutDuration,
  }) : super(key: key);

  @override
  _ADNetworkImageWidgetState createState() => _ADNetworkImageWidgetState();
}

class _ADNetworkImageWidgetState extends State<ADNetworkImageWidget> {
  ImageProvider? _imageProvider;
  bool isError = false;
  Object? errorMessage;

  @override
  void initState() {
    super.initState();
    streamImage();
  }

  @override
  Widget build(BuildContext context) {
    if (isError) {
      return _errorWidget();
    }

    ImageProvider? provider = _imageProvider;
    if (provider == null) {
      return _loadingWidget();
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
      String encodedImage =
          await ADNetworkImageService.shared.getImage(widget.source) ?? '';
      Uint8List imageBytes;
      if (encodedImage.isNotEmpty) {
        debugPrint('stream image from cache');
        imageBytes = base64Decode(encodedImage);
      } else {
        debugPrint('stream image from uri');
        imageBytes = await getImageBytes();
        ADNetworkImageService.shared.saveImage(
          url: widget.source,
          encodedImage: base64Encode(imageBytes),
          duration: widget.cacheDuration ?? const Duration(days: 1),
        );
      }
      if (!mounted) {
        return;
      }
      setState(() {
        _imageProvider = MemoryImage(imageBytes);
      });
    } catch (e) {
      debugPrint('stream image error: $e');
      if (!mounted) {
        return;
      }
      setState(() {
        errorMessage = e;
        isError = true;
      });
    }
  }

  Future<Uint8List> getImageBytes() async {
    final ByteData imageData =
        await NetworkAssetBundle(Uri.parse(widget.source))
            .load(widget.source)
            .timeout(
              widget.timeoutDuration ?? const Duration(minutes: 2),
            );
    return imageData.buffer.asUint8List();
  }

  Widget _errorWidget() {
    Widget Function(
      BuildContext context,
      Object? error,
    )? callback = widget.onError;

    if (callback != null) {
      return callback(context, errorMessage);
    }

    return const SizedBox.shrink();
  }

  Widget _loadingWidget() {
    Widget Function(BuildContext context)? callback = widget.onLoading;

    if (callback != null) {
      return callback(context);
    }

    return const SizedBox.shrink();
  }
}
