
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:image_picker/image_picker.dart';



class DangKy extends StatefulWidget {
  const DangKy({super.key});

  @override
  State<DangKy> createState() => _DangKyState();
}

class _DangKyState extends State<DangKy> {

  TextEditingController taikhoan = TextEditingController();
  TextEditingController matkhau = TextEditingController();
  TextEditingController matkhau1 = TextEditingController();
  String imageURL="";
  void uploadProduct(String title, String content) {
    DatabaseReference productRef = FirebaseDatabase.instance.reference().child('products');
    productRef.push().set({
      'taikhoan': taikhoan.text,
      'matkhau': matkhau.text,
    });
  }
  void uploadImage() async {
    final picker = ImagePicker();
    PickedFile? pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);

      DatabaseReference imageRef = FirebaseDatabase.instance.reference().child('images');
      imageRef.push().set({
        'url': imageFile.path,
      });
    }
  }
  Future<void> uploadAndSaveImage() async {
    // Chọn hình ảnh từ điện thoại
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);

      // Upload hình ảnh lên Firebase Storage
      String imageURL = await uploadImageToFirebaseStorage(imageFile);

      // Lưu URL vào Firebase Realtime Database
      saveURLToFirebaseDatabase(taikhoan.text,taikhoan.text, imageURL);
    }
  }
  Future<String> uploadImageToFirebaseStorage(File imageFile) async {
    var storageReference = FirebaseStorage.instance.ref().child("images").child(DateTime.now().toString());
    var uploadTask = storageReference.putFile(imageFile);
    var snapshot = await uploadTask.whenComplete(() => null);

    return await snapshot.ref.getDownloadURL();
  }

  void saveURLToFirebaseDatabase(String tieude,String noidung,String imageURL) {
    DatabaseReference databaseReference = FirebaseDatabase.instance.reference().child("products");
    databaseReference.push().set({
      "tieude":tieude,
      "noidung":noidung,
      "url": imageURL
    });
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:  const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Đăng Ký Tài Khoản",
                style: TextStyle(
                  fontSize:20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: taikhoan,
                decoration: InputDecoration(
                  label:const  Text("Tài Khoản"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: matkhau,
                obscureText: true,
                decoration: InputDecoration(
                  label:const  Text("Mật Khẩu"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: matkhau1,
                obscureText: true,
                decoration: InputDecoration(
                  label:const  Text("Xác Nhận Mật Khẩu"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: MaterialButton(
                  onPressed: uploadAndSaveImage,
                  child: const Text(
                    "Đăng Ký",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.red,
                  minWidth: double.infinity,
                  shape:  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 40,
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: MaterialButton(
                  onPressed: () async {

                            ImagePicker image = ImagePicker();
                            XFile? file = await image.pickImage(source: ImageSource.gallery);
                            print('${file?.path}');

                  },
                  child: const Text(
                    "Ảnh",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.red,
                  minWidth: double.infinity,
                  shape:  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 40,
                ),
              ),

            ],

          ),
        ),
      ),
    );
  }
}

