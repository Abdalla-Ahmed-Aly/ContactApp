import 'dart:io';
import 'package:contactapp/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class Selectphoto extends StatefulWidget {
  @override
  State<Selectphoto> createState() => _SelectphotoState();
}

class _SelectphotoState extends State<Selectphoto> {
  Future<void> _pickImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        Homescreen.images.add(File(pickedFile.path)); 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () async {
            await _pickImageFromGallery();
          },
          child: Padding(
            padding: EdgeInsets.only(left: 20, top: 18),
            child: Container(
              width: 143,
              height: 146,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: Colors.white, width: 1),
              ),
              child: Homescreen.images.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(28),
                      child: Image.file(
                        Homescreen.images.last!, 
                        width: 143,
                        height: 146,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Lottie.asset(
                      "assets/animations/camera.json",
                      width: 143,
                      height: 146,
                      fit: BoxFit.fill,
                    ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "User Name",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.white),
                ),
                SizedBox(height: 16),
                Container(
                  height: 0.5,
                  width: 192,
                  color: Color(0xffFFF1D4),
                ),
                SizedBox(height: 16),
                Text(
                  "example@email.com",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.white),
                ),
                SizedBox(height: 16),
                Container(
                  height: 0.5,
                  width: 192,
                  color: Color(0xffFFF1D4),
                ),
                SizedBox(height: 16),
                Text(
                  "+200000000000",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
