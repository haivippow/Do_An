
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';


class ThemNhatKy extends StatefulWidget {
  const ThemNhatKy({super.key});

  @override
  State<ThemNhatKy> createState() => _ThemNhatKyState();
}

class _ThemNhatKyState extends State<ThemNhatKy> {
  File? _image;


  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);

      });
    }
  }



  Future<void> uploadAndSaveImage() async {
    // Chọn hình ảnh từ điện thoại
      File imageFile = File(_image!.path);

      // Upload hình ảnh lên Firebase Storage
      String imageURL = await uploadImageToFirebaseStorage(imageFile);

      // Lưu URL vào Firebase Realtime Database
      saveURLToFirebaseDatabase(tieude.text,noidung.text,selectedDate.toString(), imageURL);

  }
  Future<String> uploadImageToFirebaseStorage(File imageFile) async {
    var storageReference = FirebaseStorage.instance.ref().child("images").child(DateTime.now().toString());
    var uploadTask = storageReference.putFile(imageFile);
    var snapshot = await uploadTask.whenComplete(() => null);

    return await snapshot.ref.getDownloadURL();
  }

  void saveURLToFirebaseDatabase(String tieude,String noidung,String ngaytao,String imageURL) {
    DatabaseReference databaseReference = FirebaseDatabase.instance.reference().child("products");
    databaseReference.push().set({
      "tieude":tieude,
      "noidung":noidung,
      "ngaytao": ngaytao,
      "url": imageURL
    });
  }





  @override
  final TextEditingController tieude = TextEditingController();
  final TextEditingController noidung = TextEditingController();
  DateTime selectedDate = DateTime.now();


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thêm Nhật Ký'),
        centerTitle:true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tiêu đề:'),
            TextField(
              controller: tieude,
              decoration: InputDecoration(
                hintText: 'Nhập tiêu đề',
              ),
            ),
            SizedBox(height: 16.0),
            Text('Nội dung:'),
            TextField(
              controller: noidung,
              decoration: InputDecoration(
                hintText: 'Nhập nội dung',
              ),
            ),
            SizedBox(height: 16.0),
            Text('Ngày:'),
            Row(
              children: [

                Text("${selectedDate.toLocal()}".split(' ')[0]),
                SizedBox(width: 30.0),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: Icon(Icons.date_range),
                ),
                SizedBox(width: 50.0),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Icon(Icons.camera_alt),
                ),
              ],
            ),

            SizedBox(height: 16.0),
            if (_image != null)
              Center(
                  child: Image.file(_image!,width: 200,height: 200,)
              ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: MaterialButton(
                onPressed: (){
                  uploadAndSaveImage();
                  // _uploadImage();
                },
                child: const Text(
                  "Lưu",
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
    );
  }
}