import 'package:custom_network_image/src/ad_chaced_network_image/example_ad_image_page.dart';
import 'package:custom_network_image/src/pages/example_image_page.dart';
import 'package:custom_network_image/src/pages/example_image_page_v1.dart';
import 'package:custom_network_image/src/storage/cache_image_storage.dart';
import 'package:custom_network_image/src/storage/sqflite_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'example_image_page_v3.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Image Widget'),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // _getButton(
                //   title: 'With SqfLite',
                //   onTap: () => Navigator.push(
                //     context,
                //     CupertinoPageRoute(
                //       builder: (context) => ExampleImagePageSqfLite(),
                //     ),
                //   ),
                // ),
                // const SizedBox(
                //   height: 20,
                // ),
                // _getButton(
                //   title: 'With SharedPreferences',
                //   onTap: () => Navigator.push(
                //     context,
                //     CupertinoPageRoute(
                //       builder: (context) => ExampleImagePage(),
                //     ),
                //   ),
                // ),
                // const SizedBox(
                //   height: 20,
                // ),
                _getButton(
                  title: 'With File Manager',
                  onTap: () => Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => ExampleADImagePage(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {
                    SqfliteStorage.instance.removeAll();
                    CacheImageStorage.instance.clearCache();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: const Text(
                      'Clear Cache',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getButton({
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.deepOrange,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
