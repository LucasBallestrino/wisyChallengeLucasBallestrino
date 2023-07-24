import 'dart:io';

import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wisy_challenge/app/screens/home/providers.dart';
import 'package:wisy_challenge/app/utils/file_utils.dart';

class CameraScreen extends ConsumerStatefulWidget {
  const CameraScreen({super.key});

  @override
  CameraScreenState createState() => CameraScreenState();
}

class CameraScreenState extends ConsumerState<CameraScreen> {
  String? imagePath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.5,
            child: CameraAwesomeBuilder.awesome(
              middleContentBuilder: (state) {
                return Container();
              },
              saveConfig: SaveConfig.photo(
                pathBuilder: () async {
                  final pathFuture = path(CaptureMode.photo);
                  var filePath = await pathFuture;
                  _changePath(filePath);
                  return pathFuture;
                },
              ),
              previewFit: CameraPreviewFit.fitWidth,
              onMediaTap: (mediaCapture) {},
            ),
          ),
          imagePath != null
              ? Image.file(
                  File(imagePath!),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.3,
                )
              : const SizedBox(),
          ElevatedButton(
              onPressed: () => imagePath == null
                  ? ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please take an image'),
                      ),
                    )
                  : _addImage(File(imagePath!)),
              child: const Text('Upload Image'))
        ],
      ),
    );
  }

  _addImage(File image) async {
    final db = ref.watch(databaseProvider);
    db!.addImage(image);
    db.getImages();
  }

  _changePath(String filePath) async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      imagePath = filePath;
    });
  }
}
