
import 'package:do_an_dd/updata.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';



class TatCaNhatKy extends StatefulWidget {
  const TatCaNhatKy({super.key});

  @override
  State<TatCaNhatKy> createState() => _TatCaNhatKyState();
}

class _TatCaNhatKyState extends State<TatCaNhatKy> {

  Widget build(BuildContext context) {
    DatabaseReference db_Ref =
    FirebaseDatabase.instance.ref().child('products');
    return Scaffold(
      appBar: AppBar(
        title: Text('Tất Cả Nhật Ký'),
        centerTitle:true,
        //backgroundColor: Colors.indigo[900],
      ),
      body: FirebaseAnimatedList(
        query: db_Ref,
        shrinkWrap: true,
        itemBuilder: (context, snapshot, animation, index) {
          Map Contact = snapshot.value as Map;
          Contact['key'] = snapshot.key;
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(15),
              ),
              child: InkWell(
                onTap: (){  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => UpdateRecord(
                      Contact_Key: Contact['key'],
                    ),
                  ),
                );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text("Tiêu đề:"),
                        SizedBox(width: 10),
                        Text(Contact['tieude']),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Ngày Tạo:"),
                        SizedBox(width: 10),
                        Text(Contact['tieude']),
                        SizedBox(width: 120,),

                      ],
                    ),
                    Row(
                      children: [
                        Text("Nội Dung:"),
                        SizedBox(width: 10),
                        Text(Contact['tieude']),

                      ],
                    ),
                    const SizedBox(height: 10),
              Image.network(Contact['url'],
                   // Chiều cao của hình ảnh

                  width: double.infinity, // Rộng bằng chiều rộng của Container
                  fit: BoxFit.cover
              ),

                  ],
                ),
              ),



            ),
          );
        },
      ),

    );


  }
}
