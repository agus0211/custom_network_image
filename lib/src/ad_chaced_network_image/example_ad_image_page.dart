import 'package:custom_network_image/src/ad_chaced_network_image/ad_network_image_widget.dart';
import 'package:custom_network_image/src/ad_chaced_network_image/image_detail_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../widgets/item_param.dart';

class ExampleADImagePage extends StatefulWidget {
  const ExampleADImagePage({super.key});

  @override
  ExampleADImagePageState createState() => ExampleADImagePageState();
}

class ExampleADImagePageState extends State<ExampleADImagePage> {
  late DateTime startTime;
  // https://picsum.photos/500
  final List<ItemParam> items = [
    ItemParam(
        title: 'JPEG Image',
        url:
            'https://firebasestorage.googleapis.com/v0/b/ecotrade-81289.appspot.com/o/testing_images%2FScreenshot_20221007-085422_Staging%20-%20AgriAku%20Mitra.jpg?alt=media&token=c6201ce0-71b8-4cc5-afbd-d81ae7f1a07a'),
    ItemParam(
        title: 'PNG Image',
        url:
            'https://firebasestorage.googleapis.com/v0/b/ecotrade-81289.appspot.com/o/testing_images%2Ffirebase-logo.png?alt=media&token=966dfd64-75c0-4693-83a0-f9f5e7068fc4'),
    ItemParam(title: 'Random Image', url: 'https://picsum.photos/500'),
    ItemParam(title: 'Random Image', url: 'https://picsum.photos/600'),
    ItemParam(title: 'Random Image', url: 'https://picsum.photos/1024'),
    ItemParam(title: 'Random Image', url: 'https://picsum.photos/400'),
    ItemParam(title: 'Random Image', url: 'https://picsum.photos/450'),
    ItemParam(title: 'Random Image', url: 'https://picsum.photos/560'),
    ItemParam(title: 'Random Image', url: 'https://picsum.photos/id/1004/500'),
    ItemParam(title: 'Random Image', url: 'https://picsum.photos/id/400/600'),
    ItemParam(title: 'Random Image', url: 'https://picsum.photos/id/1023/800'),
    ItemParam(title: 'Random Image', url: 'https://picsum.photos/id/460/600'),
    ItemParam(title: 'Random Image', url: 'https://picsum.photos/id/500'),
    ItemParam(title: 'Random Image', url: 'https://picsum.photos/id/430/500'),
    ItemParam(title: 'Random Image', url: 'https://picsum.photos/id/200/900'),
    ItemParam(title: 'Random Image', url: 'https://picsum.photos/id/200/900'),
    ItemParam(title: 'Random Image', url: 'https://picsum.photos/id/100/900'),
    ItemParam(title: 'Random Image', url: 'https://picsum.photos/id/230/600'),
    ItemParam(title: 'Random Image', url: 'https://picsum.photos/id/170/700'),
    ItemParam(title: 'Random Image', url: 'https://picsum.photos/id/15/100'),
    ItemParam(title: 'Random Image', url: 'https://picsum.photos/id/16/700'),
    ItemParam(title: 'Random Image', url: 'https://picsum.photos/id/12/700'),
    ItemParam(title: 'Random Image', url: 'https://picsum.photos/id/4/600'),
    ItemParam(title: 'Random Image', url: 'https://picsum.photos/id/8/650'),
    ItemParam(title: 'Random Image', url: 'https://picsum.photos/id/76/650'),
    ItemParam(title: 'Random Image', url: 'https://picsum.photos/id/160'),
    ItemParam(title: 'Random Image', url: 'https://picsum.photos/id/860'),
    ItemParam(title: 'Random Image', url: 'https://picsum.photos/id/90'),
    ItemParam(title: 'Random Image', url: 'https://picsum.photos/id/100/500'),
    ItemParam(title: 'Random Image', url: 'https://picsum.photos/id/30/900'),
    ItemParam(title: 'Random Image', url: 'https://picsum.photos/id/32/400'),
    ItemParam(title: 'Random Image', url: 'https://picsum.photos/id/43/900'),
    ItemParam(title: 'Random Image', url: 'https://picsum.photos/id/40/450'),
    ItemParam(title: 'Random Image', url: 'https://picsum.photos/id/800/450'),
    ItemParam(title: 'Random Image', url: 'https://picsum.photos/id/340/50'),
    ItemParam(title: 'Random Image', url: 'https://picsum.photos/id/23/800'),
    ItemParam(title: 'Random Image', url: 'https://picsum.photos/id/90/230'),
    ItemParam(title: 'Random Image', url: 'https://picsum.photos/id/40/700'),
    ItemParam(title: 'Random Image', url: 'https://picsum.photos/id/98'),
    ItemParam(title: 'Random Image', url: 'https://picsum.photos/id/90/400'),
    ItemParam(title: 'Random Image', url: 'https://picsum.photos/id/87/500'),
    ItemParam(title: 'Random Image', url: 'https://picsum.photos/id/8/560'),
    ItemParam(title: 'Random Image', url: 'https://picsum.photos/id/98/560'),
    ItemParam(title: 'Random Image', url: 'https://picsum.photos/id/540/560'),
  ];

  @override
  void initState() {
    super.initState();
    startTime = DateTime.now();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      DateTime endTime = DateTime.now();
      final diff = endTime.difference(startTime).inMilliseconds;
      String start = DateFormat('HH:mm:ss SSSS').format(startTime);
      String end = DateFormat('HH:mm:ss SSSS').format(endTime);
      print('FCP: $start - $end : $diff ms');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AD Cached Network Image',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            children: [
              ...items
                  .map((e) => _getImageItem(
                        url: e.url,
                        title: e.title,
                        withPlaceholder: true,
                      ))
                  .toList(),
              _getImageItem(
                url:
                    'https://webserver-images-stg.s3.ap-southeast-1.amazonaws.com/tester',
                title: 'Error Image with placeholder widget',
                withPlaceholder: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getImageItem({
    required String url,
    required String title,
    bool withPlaceholder = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => ImageDetailView(imageUrl: url),
                  ),
                );
              },
              child: ADNetworkImageWidget(
                url,
                onError: (context, error) {
                  return withPlaceholder
                      ? Center(
                          child: Text(
                            error.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.red),
                          ),
                        )
                      : const SizedBox.shrink();
                },
                onLoading: (context) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: url));
                },
                child: const Icon(
                  Icons.copy,
                  size: 20,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
