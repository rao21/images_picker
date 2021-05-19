import 'dart:io';

import 'package:flutter/material.dart';

import 'package:images_picker/images_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String path;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            ElevatedButton(
              child: Text('pick'),
              onPressed: () async {
                List<Media> res = await ImagesPicker.pick(
                  count: 1,
                  pickType: PickType.image,
                  language: Language.System,
                   //maxSize: 500,
                  cropOpt: CropOption(
                    aspectRatio: CropAspectRatio.wh9x16,
                  ),
                );
                if (res != null) {
                  print(res.map((e) => e.path).toList());
                  setState(() {
                    path = res[0].thumbPath;
                  });
                  // bool status = await ImagesPicker.saveImageToAlbum(File(res[0]?.path));
                  // print(status);
                }
              },
            ),
            ElevatedButton(
              child: Text('openCamera'),
              onPressed: () async {
                List<Media> res = await ImagesPicker.openCamera(
                  pickType: PickType.image,
                  quality: 0.5,
                  cropOpt: CropOption(
                    aspectRatio: CropAspectRatio.wh16x9,
                  ),
                  maxTime: 60,
                );
                if (res != null) {
                  print(res[0].path);
                  setState(() {
                    path = res[0].thumbPath;
                  });
                }
              },
            ),
            ElevatedButton(
              onPressed: () async {
                // File file =
                //     await downloadFile('https://cdn.chavesgu.com/logo.png');
                // bool res = await ImagesPicker.saveImageToAlbum(file,
                //     albumName: "chaves");
                // print(res);
              },
              child: Text('saveNetworkImageToAlbum'),
            ),
            ElevatedButton(
              onPressed: () async {
                // File file = await downloadFile(
                //     'https://cdn.chavesgu.com/SampleVideo.mp4');
                // bool res = await ImagesPicker.saveVideoToAlbum(file,
                //     albumName: "chaves");
                //print(res);
              },
              child: Text('saveNetworkVideoToAlbum'),
            ),
            path != null
                ? Container(
                    height: 200,
                    child: Image.file(
                      File(path),
                      fit: BoxFit.contain,
                    ),
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
