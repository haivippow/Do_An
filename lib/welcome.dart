
import 'package:do_an_dd/danhsachnhatky.dart';
import 'package:do_an_dd/danhsachnhatky1.dart';
import 'package:flutter/material.dart';

import 'dangky.dart';
class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Welcome",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20,),
          const Text(
            "Vui lòng đăng nhập",
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: MaterialButton(
              onPressed: (){
               Navigator.push(context, MaterialPageRoute(builder: (context)=> const TatCaNhatKy(),),);
              },
              child: const Text(
                "Đăng Nhập",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.red,
              minWidth: double.infinity,
              shape:  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              height: 40,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: MaterialButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const DangKy(),),);
              },
              child: const Text(
                "Đăng Ký",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.red,
              minWidth: double.infinity,
              shape:  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              height: 40,
            ),
          ),
        ],
      ),
    );
  }
}
