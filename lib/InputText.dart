import 'package:flutter/material.dart';

class Inputtext extends StatefulWidget {
  final String Text;
  final TextEditingController? nameController;

  Inputtext({required this.Text, required this.nameController});

  @override
  _InputtextState createState() => _InputtextState();
}

class _InputtextState extends State<Inputtext> {
  late TextEditingController nameController;
  bool hasError = false; // حالة لمعرفة إذا كان هناك خطأ

  @override
  void initState() {
    super.initState();
    nameController = widget.nameController ?? TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              fillColor: Color(0xff29384D),
              hintText: "Enter ${widget.Text}",
              hintStyle: TextStyle(
                color: Color(0xffE2F4F6),
                fontSize: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  width: 2,
                  color: Color(0xffFFF1D4),
                ),
              ),
              errorText: hasError ? "Please fill this field" : null, // نص رسالة الخطأ
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  width: 2,
                  color: Color(0xffEE403D),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  width: 2,
                  color: Color(0xffFFF1D4),
                ),
              ),
            ),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
            cursorColor: Color(0xffFFF1D4),
            onChanged: (value) {
              setState(() {
                hasError = value.isEmpty; // تحديث حالة الخطأ بناءً على النص المدخل
              });
            },
          ),
          if (hasError) 
            Padding(
              padding: EdgeInsets.only(top: 4),
              child: Text(
                "This field cannot be empty",
                style: TextStyle(
                  color: Color(0xffEE403D),
                  fontSize: 14,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
