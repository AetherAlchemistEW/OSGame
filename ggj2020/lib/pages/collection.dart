import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rxdart/rxdart.dart';

class CollectionPage extends StatefulWidget {
  @override
  _CollectionPageState createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {

  bool isLoading = true;
  //Stream<CollectionModel> collectionStream;
  //StreamSink<CollectionModel> collectionSink;
  //StreamController<CollectionModel> collectionController;

  @override
  void initState() {
    super.initState();
    //collectionController = PublishSubject<CollectionModel>();
    //collectionStream = collectionController.stream;
    //collectionSink = collectionController.sink;
  }

  @override
  void dispose() {
    super.dispose();
    //collectionSink.close();
    //collectionController.close();
  }

  @override
  Widget build(BuildContext context) {
    final String uid = Provider.of<String>(context);
    final path = '/users/$uid/dossier'; //add index?
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection(path).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Container(
              width: 50, height: 50,
              child: Card(
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                ),
              ),
            ),
          );
        } else {
          final int tileCount = snapshot.data.documents.length;
          return Scaffold(
              body: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemCount: tileCount, itemBuilder: (_, int index) {
                        final DocumentSnapshot doc = snapshot.data.documents[index];
                        //add an initial empty entry if there's no data, maybe on sign in?
                        //return ListTile(title: Text('${snapshot.data}'));
                        return _collectionFormElement(doc);
                      },
                    ),
                  ),
                  RaisedButton(
                    child: Text("New Entry"),
                    onPressed: () => newEntry(tileCount), //add new field
                  )
                ],
              )
          );
        }
      }
    );
  }

  Future<void> checkData() async {
    print('checking...');
    //final String uid = Provider.of<String>(context, listen: false);
    //final path = '/users/$uid/dossier'; //add index?

    CollectionModel initialModel = CollectionModel(name: "", amount: 0);
    await submitData(initialModel, "0");
  }
  
  Future<void> newEntry(int index) async {
    CollectionModel blankModel = CollectionModel(name: "", amount: 0);
    await submitData(blankModel, "$index");
  }

  Future<void> submitData(CollectionModel model, String index) async {
    final String uid = Provider.of<String>(context, listen: false);
    final path = '/users/$uid/dossier/$index';
    final documentReference = Firestore.instance.document(path);
    print('try to submit...');
    final Map<String, dynamic> map = {"name": "", "amount": 0};
    await documentReference.setData(map);
    print('data set');
  }

  Future<void> updateDoc(CollectionModel model, DocumentSnapshot documentSnapshot) async {
    //final String uid = Provider.of<String>(context, listen: false);
    final Map<String, dynamic> map = {"name": model.name, "amount": model.amount};
    await documentSnapshot.reference.setData(map);
  }

  Widget _collectionFormElement(DocumentSnapshot documentSnapshot) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    CollectionModel model = CollectionModel(name: documentSnapshot.data["name"], amount: documentSnapshot.data["amount"]);

    //TODO: fix onEditing v onSubmitted issue
    return ListTile(
      title: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            elevation: 5.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  textAlign: TextAlign.center,
                  initialValue: model.name,
                  //onSaved: (input) {model.name = input; updateDoc(model, documentSnapshot);},
                  onFieldSubmitted: (input) {model.name = input; updateDoc(model, documentSnapshot);},
                  decoration: InputDecoration(
                    labelText: "Name",
                  ),
                ),
                TextFormField(
                  textAlign: TextAlign.center,
                  initialValue: model.amount.toString(),
                  onFieldSubmitted: (input) {model.amount = int.tryParse(input); updateDoc(model, documentSnapshot);},
                  decoration: InputDecoration(
                    labelText: "Amount"
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

 /*Future<CollectionModel> retrieveData() async {
    final String uid = Provider.of<String>(context);

  }*/
}

class CollectionModel{
  String name;
  int amount;

  CollectionModel({this.name, this.amount});
}
