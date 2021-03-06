import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class UploadDownload {

  Future uploadFile(String fileName, String filePath, String type, String extension) async {

    //TODO Filename should be userid sender + userid receiver + timestamp
    final StorageReference storageReference = FirebaseStorage.instance.ref().child(fileName);

    final StorageUploadTask storageUploadTask = storageReference.putFile(
      File(filePath),
      StorageMetadata(contentType: type + "/" + extension)
    );

    storageUploadTask.resume();
  }

  Future<String> downloadFile(String fileName) async {
    final StorageReference storageReference = FirebaseStorage.instance.ref().child(fileName);
    var url = await storageReference.getDownloadURL();
    return url;
  }
}
