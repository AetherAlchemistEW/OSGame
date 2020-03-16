import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';

class Uploader extends StatefulWidget {
  final File file;

  const Uploader({Key key, this.file}) : super(key: key);

  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  final FirebaseStorage _storage =
        FirebaseStorage(storageBucket: 'gs://frankensteintemplate.appspot.com');

  StorageUploadTask _uploadTask;


  void _startUpload() {
    final String uid = Provider.of<String>(context);
    String filePath = '$uid/images/${DateTime.now()}.png';

    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(widget.file);
    });
  }

  @override
  Widget build(BuildContext context) {
    if(_uploadTask != null){
      return StreamBuilder<StorageTaskEvent>(
        stream: _uploadTask.events,
        builder: (context, snapshot){
          var event = snapshot?.data?.snapshot;

          double progressPercent = event != null
              ? event.bytesTransferred / event.totalByteCount
              : 0;

          return progressWidget(context, progressPercent);
        },
      );
    } else {
      return FlatButton.icon(
          onPressed: _startUpload,
          icon: Icon(Icons.cloud_upload),
          label: Text('Upload to Firebase')
      );
    }
  }

  Widget progressWidget(BuildContext context, double progress){
    if(_uploadTask.isComplete){
      Navigator.pop(context);
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
      Navigator.pop(context);
      return Container();
    } else {
      return Container();
    }
  }
}
