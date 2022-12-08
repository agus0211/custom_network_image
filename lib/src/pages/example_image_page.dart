import 'package:custom_network_image/src/widgets/custom_image_network_v2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/item_param.dart';

class ExampleImagePage extends StatefulWidget {
  const ExampleImagePage({super.key});

  @override
  ExampleImagePageState createState() => ExampleImagePageState();
}

class ExampleImagePageState extends State<ExampleImagePage> {
  late DateTime startTime;

  final List<ItemParam> items = [
    ItemParam(title: 'Right URL', url: 'https://picsum.photos/id/28/200/400'),
    ItemParam(title: 'Square Image', url: 'https://picsum.photos/id/40/400'),
    ItemParam(title: 'Error Image', url: 'https:example.com/image'),
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
      print('SharedPref: $start - $end : $diff');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Custom Image with SharedPref',
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
                  .map((e) => _getImageItem(url: e.url, title: e.title))
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
            child: CustomImageNetworkV2(
              url,
              errorWidget: withPlaceholder
                  ? const Center(
                      child: Text(
                        'Image is error',
                        style: TextStyle(color: Colors.red),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
