import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:wisy_challenge/models/image_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';

class FirestoreService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<List<ImageModel>> getImages() async {
    var data = await firestore.collection('images').get();
    return List.from(data.docs.map((e) => ImageModel.fromSnapshot(e)));
  }

  Future<void> addImage(File image) async {
    UploadTask task;

    final path = 'images/${basename(image.path)}';
    final collection = firestore.collection('images');
    final ref = storage.ref().child(path);

    task = ref.putFile(image);

    final snapShot = await task.whenComplete(() {});

    final urlImage = await snapShot.ref.getDownloadURL();
    final imageModel =
        ImageModel(timeStamp: DateTime.now().toIso8601String(), url: urlImage);

    collection.add(imageModel.toMap());
  }
}
