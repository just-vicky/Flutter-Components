import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:upload_file/files_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    void openFile(PlatformFile file) {
      OpenFile.open(file.path!);
    }

    void openFiles(List<PlatformFile> files) =>
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FilesPage(files: files, onOpenedFile: openFile),
        ));

    Future<File> saveFilePermanently(PlatformFile file) async {
      final appStorage = await getApplicationDocumentsDirectory();
      final newFile = File('${appStorage.path}/${file.name}');

      return File(file.path!).copy(newFile.path);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('File upload'),
      ),
      body: Container(
        constraints: BoxConstraints(maxWidth: 400),
        padding: EdgeInsets.all(32),
        alignment: Alignment.center,
        child: ElevatedButton(
          child: Text('Pick file'),
          onPressed: () async {
            final result = await FilePicker.platform.pickFiles(
              allowMultiple: true,
              type: FileType.custom,
              allowedExtensions: ['pdf', 'mp4'],
            );
            if (result == null) return;
            final file = result.files.first;
            // openFile(file); For Single file
            openFiles(result.files);

            final newFile = await saveFilePermanently(file);
          },
        ),
      ),
    );
  }
}
