import 'package:custom_network_image/src/ad_chaced_network_image/ad_network_image_widget.dart';
import 'package:flutter/material.dart';

class ImageDetailView extends StatelessWidget {
  final String imageUrl;
  final TransformationController viewerController = TransformationController();

  ImageDetailView({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        color: Colors.black,
        height: double.infinity,
        width: double.infinity,
        child: InteractiveViewer(
          transformationController: viewerController,
          child: ADNetworkImageWidget(imageUrl),
        ),
      ),
    );
  }
}
