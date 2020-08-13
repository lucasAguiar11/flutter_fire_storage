import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Teste(),
    );
  }
}

class Teste extends StatefulWidget {
  @override
  _TesteState createState() => _TesteState();
}

class _TesteState extends State<Teste> {
  final firestoreInstance = Firestore.instance;
  String teste = "Nada aqui";
  String pathImg = 'https://picsum.photos/250?image=9';

  //https://medium.com/firebase-tips-tricks/how-to-use-cloud-firestore-in-flutter-9ea80593ca40
  //  -> exemplos

  //get all
//    firestoreInstance.collection("affiliator").getDocuments().then((querySnapshot) {
//      querySnapshot.documents.forEach((result) {
//        print(result.data);
//      });
//    });

  //get by document
//    firestoreInstance.collection("affiliator").document("2").get().then((querySnapshot) {
//      print(querySnapshot.data);
//      print(querySnapshot.data["primary_color"]);
//    });

  //realtime
//    firestoreInstance.collection("affiliator").document("2").snapshots().listen((event) {
//      print(event.data);
//    });

  
//  void getText() {
//    setState(() {
//      firestoreInstance
//          .collection("affiliator")
//          .document("2")
//          .snapshots()
//          .listen((event) {
//        print(event.data["primary_color"]);
//        teste = event.data["primary_color"];
//      });
//    });
//  }

  @override
  void initState() {
    firestoreInstance
        .collection("affiliator")
        .document("2")
        .snapshots()
        .listen((event) {
      Evento(event);
    });

    super.initState();
  }

  void Evento(DocumentSnapshot event) {
    print(event.data["primary_color"]);
    setState(() {
      teste = event.data["title"];
      pathImg = event.data["logo"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Teste fire_store"),
        primary: true,
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.network(
              pathImg,
              width: 300,
              height: 300,
            ),
            Text(teste),
            RaisedButton(
              onPressed: () {},
              child: Text("Button"),
            )
          ],
        ),
      ),
    );
  }
}
