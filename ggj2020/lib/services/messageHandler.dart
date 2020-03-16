import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'dart:async';
import 'package:provider/provider.dart';

class MessageHandler extends StatefulWidget {
  @override
  _MessageHandlerState createState() => _MessageHandlerState();
}

class _MessageHandlerState extends State<MessageHandler> {

  final FirebaseMessaging _fcm = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    _fcm.configure(
        onMessage: (Map<String, dynamic> message) async{
          print("onMessage: $message");

          final snackbar = SnackBar(
            content: Text(message['notification']['title']),
            action: SnackBarAction(
              label: 'Go',
              onPressed: () => null,
            ),
          );
          Scaffold.of(context).showSnackBar(snackbar);
        },

        onLaunch: (Map<String, dynamic> message) async{
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: ListTile(
                  title: Text(message['notification']['title']),
                  subtitle: Text(message['notification']['title']),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Ok'),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              )
          );
        }
    );
    _fcm.subscribeToTopic('puppies');
    _saveDeviceToken();
  }

  Future<void> _saveDeviceToken() async {
    final String uid = Provider.of<String>(context, listen: false);
    String fcmToken = await _fcm.getToken();
    final path = '/users/$uid/tokens/$fcmToken';
    final documentReference = Firestore.instance.document(path);
    //alternatively
    //final documentReference = Firestore.instance.collection('users').document(uid).collection('tokens').document(fcmToken);

    await documentReference.setData({
      'token' : fcmToken,
      'createdAt' : FieldValue.serverTimestamp(),
      'platform' : Platform.operatingSystem,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}