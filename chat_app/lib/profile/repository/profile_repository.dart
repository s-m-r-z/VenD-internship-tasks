import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:chat_app/profile/model/profile_model.dart' as u;

class ProfileRepostiory {
  FirebaseStorage storage = FirebaseStorage.instance;
  final user = FirebaseFirestore.instance.collection("users");
  final String auth = FirebaseAuth.instance.currentUser!.uid;
  late String imageURL;
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Stream<List<u.User>> streamLoggedInUser() {
    return user.snapshots().map(
        (event) => event.docs.map((e) => u.User.fromJson(e.data())).toList());
  }

  Future<void> editProfile() async {
    await user.doc(auth).set(const u.User(name: "", contact: "").toJson());
  }

  Future<void> saveProfile(String name, String contact) async {
    await user.doc(auth).set(u.User(name: name, contact: contact).toJson());
  }

  Future<void> editPhoto(ImageSource source) async {
    final file = await _picker.pickImage(source: source);

    _imageFile = file;

    final fileName = path.basename(_imageFile!.path);
    final imageFile = File(_imageFile!.path);
    await user.doc(auth).set(u.User(photo: fileName).toJson());
    await uploadPhoto(fileName, imageFile);
  }

  Future<void> uploadPhoto(String fileName, File imageFile) async {
    try {
      await storage.ref(fileName).putFile(
            imageFile,
          );
      final ref1 = FirebaseStorage.instance.ref().child(fileName);

      imageURL = await ref1.getDownloadURL();
    } on FirebaseException catch (error) {
      log(error.toString());
    } catch (err) {
      log(err.toString());
    }
  }
}
