import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'cardcontact.dart';
import 'InputText.dart';
import 'selectPhoto.dart';

class Homescreen extends StatefulWidget {
  static List<Map<String, dynamic>> contacts = []; 
  static List<File?> images = []; 

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  File? selectedImage; 

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path); 
      });
    }
  }
  void _deleteContact(int index) {
    setState(() {
      Homescreen.contacts.removeAt(index);
      if (Homescreen.images.isNotEmpty) {
        Homescreen.images.removeAt(index);
      }
    });}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff29384D),
      appBar: AppBar(
        backgroundColor: Color(0xff29384D),
        title: Image.asset(
          "assets/images/RouteAppbar.png",
          height: 39,
          width: 117,
          fit: BoxFit.fill,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Homescreen.contacts.isNotEmpty
                  ? GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.5,
                        crossAxisSpacing: 10,
                        
                        mainAxisSpacing: 10,
                      ),
                      itemCount: Homescreen.contacts.length,
                      itemBuilder: (context, index) {
                        var contact = Homescreen.contacts[index];
                        return CardContact(
                          image: Homescreen.images.isNotEmpty
                              ? Homescreen.images[index]!
                              : File(''),
                          name: contact['name'] ?? "No Name",
                          email: contact['email'] ?? "No Email",
                          phone: contact['phone'] ?? "No Phone",
                          onDelete: () => _deleteContact(index),
                        );
                      },
                    )
                  : Column(
                      children: [
                        Lottie.asset(
                          "assets/animations/list.json",
                          width: 368,
                          height: 368,
                          fit: BoxFit.fill,
                        ),
                        Text(
                          "There is No Contacts Added Here",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: Homescreen.contacts.length < 6, 

       child:FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Color(0xff29384D),
            context: context,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xff29384D),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Selectphoto(),
                        Inputtext(Text: "Name", nameController: nameController),
                        Inputtext(Text: "Email", nameController: emailController),
                        Inputtext(Text: "Phone", nameController: phoneController),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Homescreen.contacts.add({
                                'name': nameController.text,
                                'email': emailController.text,
                                'phone': phoneController.text
                              });

                            
                              if (Homescreen.contacts.isNotEmpty && Homescreen.images.isNotEmpty) {
                                Navigator.pop(context);

                                nameController.clear();
                                emailController.clear();
                                phoneController.clear();
                                selectedImage = null;

                                setState(() {});
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xffFFF1D4),
                              foregroundColor: Color(0xff29384D),
                              padding: EdgeInsets.all(16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Text(
                              "Enter User",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
      ),
    );
  }
}
