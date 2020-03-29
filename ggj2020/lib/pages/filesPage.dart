import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ggj2020/services/uploader.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class FilesPage extends StatefulWidget {
  @override
  _FilesPageState createState() => _FilesPageState();
}

class _FilesPageState extends State<FilesPage> {
  File _imageFile;

  final FirebaseStorage _storage =
  FirebaseStorage(storageBucket: 'gs://frankensteintemplate.appspot.com');

  StorageUploadTask _uploadTask;

  @override
  Widget build(BuildContext context) {
    if(_uploadTask != null){
      print('uploading');
      return Container(
        color: Theme.of(context).backgroundColor,
        child: StreamBuilder<StorageTaskEvent>(
          stream: _uploadTask.events,
          builder: (context, snapshot){
            var event = snapshot?.data?.snapshot;

            double progressPercent = event != null
                ? event.bytesTransferred / event.totalByteCount
                : 0;

            return progressWidget(context, progressPercent);
          },
        ),
      );
    } else {
      return Scaffold(
        bottomNavigationBar: BottomAppBar(
          color: Theme
              .of(context)
              .bottomAppBarColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: IconButton(
                  icon: Icon(Icons.photo_camera),
                  onPressed: () => _pickImage(ImageSource.camera),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: IconButton(
                  icon: Icon(Icons.photo_library),
                  onPressed: () => _pickImage(ImageSource.gallery),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: IconButton(
                    icon: Icon(Icons.cloud),
                    onPressed: () => {} //_pickCloud
                ),
              ),
              /*Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: IconButton(
                    icon: Icon(Icons.cloud_upload),
                    onPressed: () => _startUpload
                ),
              ),*/
            ],
          ),
        ),
        body: imageBody(),
      );
    }
  }

  void _startUpload() {
    print('start an upload');
    if(_imageFile != null) {
      final String uid = Provider.of<String>(context, listen: false);
      String filePath = '$uid/images/0.png';

      setState(() {
        _uploadTask = _storage.ref().child(filePath).putFile(_imageFile);
      });
    }
  }

  /*Widget uploadPage(){
    if(_uploadTask != null){
      return Container(
        color: Theme.of(context).backgroundColor,
        child: StreamBuilder<StorageTaskEvent>(
          stream: _uploadTask.events,
          builder: (context, snapshot){
            var event = snapshot?.data?.snapshot;

            double progressPercent = event != null
                ? event.bytesTransferred / event.totalByteCount
                : 0;

            return progressWidget(context, progressPercent);
          },
        ),
      );
    } else {
      return Container(
        color: Theme.of(context).backgroundColor,
        child: FlatButton.icon(
            onPressed: _startUpload,
            icon: Icon(Icons.cloud_upload),
            label: Text('Upload to Firebase')
        ),
      );
    }
  }*/

  Widget progressWidget(BuildContext context, double progress){
    if(_uploadTask.isComplete){
      //_clear();
      _imageFile = null;
      //Navigator.pop(context);
      _uploadTask = null;
      return Container();
    } else if(_uploadTask.isInProgress) {
      return Column(
        children: <Widget>[
          FlatButton(
            child: Icon(Icons.pause),
            onPressed: _uploadTask.pause,
          ),
          LinearProgressIndicator(),
        ],
      );
    } else if(_uploadTask.isPaused) {
      return Column(
        children: <Widget>[
          FlatButton(
            child: Icon(Icons.play_arrow),
            onPressed: _uploadTask.resume,
          ),
          LinearProgressIndicator(value: progress),
        ],
      );
    } else if(_uploadTask.isCanceled){
      _clear();
      //Navigator.push(context, route)
      _uploadTask = null;
      return Container();
    } else {
      return Container();
    }
  }

  Widget imageBody(){
    if(_imageFile == null){
      return Container(child: Center(child: Text("Attach image")),color: Theme.of(context).backgroundColor,);
    } else {
      return Center(
        child: Container(
          color: Theme.of(context).backgroundColor,
          child: ListView(
              children: <Widget>[
                Image.file(_imageFile),
                Row(
                  children: <Widget>[
                    FlatButton(
                      child: Icon(Icons.crop, color: Theme.of(context).iconTheme.color),
                      onPressed: _cropImage,
                      color: Theme.of(context).buttonColor,
                    ),
                    FlatButton(
                      child: Icon(Icons.refresh, color: Theme.of(context).iconTheme.color),
                      onPressed: _clear,
                      color: Theme.of(context).buttonColor,
                    )
                  ],
                ),
                FlatButton(
                  child: Icon(Icons.file_upload, color: Theme.of(context).iconTheme.color),
                  onPressed: _startUpload, //() => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Uploader(file: _imageFile,))),
                  color: Theme.of(context).buttonColor,
                ),
              ]
          ),
        ),
      );
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);

    setState(() {
      _imageFile = selected;
    });
  }

  Future<void> _cropImage() async{
    File cropped = await ImageCropper.cropImage(
      sourcePath: _imageFile.path,
    );

    setState(() {
      _imageFile = cropped;
    });
  }

  /*Future<void> _pickCloud() async {
    print('cloud');
    final String uid = Provider.of<String>(context, listen: false);
    final FirebaseStorage _storage =
    FirebaseStorage(storageBucket: 'gs://frankensteintemplate.appspot.com');

    final String url = await _storage.ref().getDownloadURL();
    print(url);
      //final String uuid = Uuid().v1();
      final http.Response downloadData = await http.get(url);
      final Directory systemTempDir = Directory.systemTemp;
      final File tempFile = File('${systemTempDir.path}/tmp$uid.png');
      if (tempFile.existsSync()) {
        await tempFile.delete();
      }
      await tempFile.create();
      assert(await tempFile.readAsString() == "");
      final StorageFileDownloadTask task = _storage.ref().writeToFile(tempFile);
      final int byteCount = (await task.future).totalByteCount;
      final String tempFileContents = await tempFile.readAsString();

      final String fileContents = downloadData.body;
      //final String name = await ref.getName();
      //final String bucket = await ref.getBucket();
      //final String path = await ref.getPath();

    //await task.future.then((_) => _imageFile = tempFile);

    setState(() async {
      await task.future.then((_) => _imageFile = tempFile);
    });
  }*/

  void _clear(){
    setState(() => _imageFile = null);
  }
}
