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
  final List<ItemParam> items = [
    ItemParam(
        title: 'JPEG Image',
        url:
            'https://firebasestorage.googleapis.com/v0/b/ecotrade-81289.appspot.com/o/testing_images%2FScreenshot_20221007-085422_Staging%20-%20AgriAku%20Mitra.jpg?alt=media&token=c6201ce0-71b8-4cc5-afbd-d81ae7f1a07a'),
    ItemParam(
        title: 'PNG Image',
        url:
            'https://firebasestorage.googleapis.com/v0/b/ecotrade-81289.appspot.com/o/testing_images%2Ffirebase-logo.png?alt=media&token=966dfd64-75c0-4693-83a0-f9f5e7068fc4'),
    ItemParam(
        title: 'PNG Image',
        url:
            'https://firebasestorage.googleapis.com/v0/b/ecotrade-81289.appspot.com/o/testing_images%2FScreenshot_20220920-180431_Staging%20-%20AgriAku%20Mitra.jpg?alt=media&token=49cb8648-073f-4144-b483-a33f9cd2d960'),
    ItemParam(
        title: 'PNG Image',
        url:
            'https://firebasestorage.googleapis.com/v0/b/ecotrade-81289.appspot.com/o/testing_images%2FScreenshot_20211122-110032.jpg?alt=media&token=7f386eef-fb22-4112-8f2b-70e41958f9ba'),
    ItemParam(
        title: 'PNG Image',
        url:
            'https://firebasestorage.googleapis.com/v0/b/ecotrade-81289.appspot.com/o/testing_images%2F2022-09-26%2014_29_21-Enhance%20Tracking%20-%20Google%20Sheets.png?alt=media&token=a83faa23-5fec-483c-96b4-9a0957d13917'),
    ItemParam(
        title: 'PNG Image',
        url:
            'https://firebasestorage.googleapis.com/v0/b/ecotrade-81289.appspot.com/o/testing_images%2F2022-09-23%2001_50_21-2022-09-23%2001_49_50-2000.jpg%20(3000%C3%972000).png%20%E2%80%8E-%20Photos.png?alt=media&token=19db2b8a-c2d2-4291-af2a-2a10be4ab8d9'),
    ItemParam(
        title: 'PNG Image',
        url:
            'https://firebasestorage.googleapis.com/v0/b/ecotrade-81289.appspot.com/o/testing_images%2F2022-07-25%2013_55_07-NEW%20Mitra%20App%20%E2%80%93%20Figma.png?alt=media&token=bc674511-82b1-45ec-b889-abe9fbd58025'),
    ItemParam(
        title: 'PNG Image',
        url:
            'https://firebasestorage.googleapis.com/v0/b/ecotrade-81289.appspot.com/o/testing_images%2F2022-08-25%2016_11_04-.png?alt=media&token=11642838-9a08-4549-b563-f3fb2bff0d9b'),
    ItemParam(
        title: 'PNG Image',
        url:
            'https://firebasestorage.googleapis.com/v0/b/ecotrade-81289.appspot.com/o/testing_images%2F2022-07-27%2013_39_33-Backend%20Master%20Docs%20-%20Google%20Docs.png?alt=media&token=cd40d93f-1809-448d-9bbb-67a1dad79693'),
    ItemParam(
        title: 'PNG Image',
        url:
            'https://firebasestorage.googleapis.com/v0/b/ecotrade-81289.appspot.com/o/testing_images%2Forder_confirmation-_summary.png?alt=media&token=137f8aee-cad2-4e16-8ad8-81d476088e6b'),
    ItemParam(
        title: 'PNG Image',
        url:
            'https://firebasestorage.googleapis.com/v0/b/ecotrade-81289.appspot.com/o/testing_images%2FCari%20Barang.png?alt=media&token=968d06ec-7c93-4816-9767-8d72777c87ec'),
    ItemParam(
        title: 'PNG Image',
        url:
            'https://firebasestorage.googleapis.com/v0/b/ecotrade-81289.appspot.com/o/testing_images%2Fempty_purchased.png?alt=media&token=e4907aa5-60af-4087-a462-18dfbcc8c61e'),
    ItemParam(
        title: 'PNG Image',
        url:
            'https://firebasestorage.googleapis.com/v0/b/ecotrade-81289.appspot.com/o/testing_images%2Fexample_image.png?alt=media&token=59d38b98-ded2-4d27-8159-772669e3a47e'),
    ItemParam(
        title: 'PNG Image',
        url:
            'https://firebasestorage.googleapis.com/v0/b/ecotrade-81289.appspot.com/o/testing_images%2Fss.png?alt=media&token=1ec2d2ba-6626-4ef8-a47f-61aa39a1651a'),
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
      debugPrint('FCP: $start - $end : $diff ms');
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
