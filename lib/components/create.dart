import 'dart:io';

import 'package:clockify/constants.dart';
import 'package:clockify/screens/SignIn_screen.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;

import '../models/registerUser.dart';

class create extends StatefulWidget {
  create({Key? key}) : super(key: key);

  @override
  _createState createState() => _createState();
}

final TextEditingController emailController = TextEditingController();
final TextEditingController passController = TextEditingController();

Future<RegisterUser> createUser(String email, String password) async {
  try{
    final String apiUrl = 'https://5423-180-244-129-250.ngrok.io/user/signUp';
  
    final response = await http.post(Uri.parse(apiUrl), 
    headers:{
      HttpHeaders.authorizationHeader: 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjM1NGY1ZGFlLWU2NDUtNDRkYS1hYzEwLTliMWFjNzRkMDgwOCIsImlhdCI6MTY0ODAxMTg1NCwiZXhwIjoxNjQ4MDk4MjU0fQ.72BglM2K83XAXSmlhHC3ym5BrmO_kUVKB-emyHoLCV0',
    }, 
    body: {
    "email": email,
    "password": password,
    });
    if(response.statusCode == 401){
    final String responseString = response.body;

    return registerUserFromJson(responseString);
  }
  
  }catch (e){
    print(e.toString());
  }
  return createUser(email, password);
  
}

class _createState extends State<create> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  GlobalKey<FormState> passkey = GlobalKey<FormState>();
  GlobalKey<FormState> passkeyy = GlobalKey<FormState>();

  var confirmpass;
  bool manuallyclosed = false;


  String? validatePassword(String value) {
        if (value.isEmpty) {
          return "* Required";
        } else if (value.length < 8) {
          return "Password should be atleast 8 characters";
        } else if (value.length > 15) {
          return "Password should not be greater than 15 characters";
        } else
          return null;
  }

  bool _obscure = true;
  bool _obscuree = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Column(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 100, left: 50),
                      child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (
                              BuildContext context
                              ) => signIn()
                            )
                        );
                      },
                      child: Image.asset(
                        'assets/icons/back.png',
                        width: 18,
                        height: 20,
                      ),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 150, left: 50),
                      child: Text(
                        "Create New Account",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor
                        ),
                      ),
                    ),

                    Container(
                      width: 330,
                      margin: EdgeInsets.only(top: 250, left: 50),
                      child : Form(
                        key: formkey,
                        autovalidateMode: AutovalidateMode.always,
                        child: TextFormField(
                          controller: emailController,
                          style: TextStyle(
                            color: lineColor,
                          ),
                          decoration: InputDecoration(
                            labelText: "Input Your Email",
                            labelStyle: TextStyle(
                              color: lineColor,
                              fontSize: 14
                              ),
                            enabledBorder : UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: lineColor
                              ),
                            ),
                          ),
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Required"),
                            EmailValidator(errorText: "Enter a Valid Email")                  
                          ]),
                        ),
                      ),
                    ), 

                    Container(
                      width: 330,
                      margin: EdgeInsets.only(top: 360, left: 50),
                      child: Form(
                        key: passkey,
                        autovalidateMode: AutovalidateMode.always,
                        child: TextFormField(
                          controller: passController,
                          obscureText: _obscure,
                          style: TextStyle(
                            color: lineColor
                          ),
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: (){
                                setState(() {
                                  _obscure=!_obscure;
                                });
                              },
                              child: Icon(_obscure 
                              ? Icons.visibility 
                              : Icons.visibility_off,
                              color: lineColor,
                              ),
                            ),
                            labelText: "Create Your Password",
                            labelStyle: TextStyle(
                              color: lineColor,
                              fontSize: 14
                              ),
                            enabledBorder : UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: lineColor
                              ),
                            ),
                          ),
                          // validator: MultiValidator([
                          //   RequiredValidator(errorText: "Required"),
                          //   MinLengthValidator(6,
                          //       errorText: "Password should be atleast 8 characters"
                          //       ),
                          //   MaxLengthValidator(15,
                          //       errorText:
                          //       "Password should not be greater than 15 characters"
                          //       )
                          // ])
                          validator: (String? value) {
                                  confirmpass = value;
                                  if (value!.isEmpty) {
                                    return "Required";
                                  } else if (value.length < 8) {
                                    return "Password must be atleast 8 characters long";
                                  } 
                                },
                        ),
                      ),
                    ),

                    Container(
                      width: 330,
                      margin: EdgeInsets.only(top: 470, left: 50),
                      child: Form(
                        key: passkeyy,
                        autovalidateMode: AutovalidateMode.always,
                        child: TextFormField(
                          obscureText: _obscuree,
                          style: TextStyle(
                            color: lineColor
                          ),
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: (){
                                setState(() {
                                  _obscuree=!_obscuree;
                                });
                              },
                              child: Icon(_obscuree
                              ? Icons.visibility 
                              : Icons.visibility_off,
                              color: lineColor,
                              ),
                            ),
                            labelText: "Confirm Your Password",
                            labelStyle: TextStyle(
                              color: lineColor,
                              fontSize: 14
                              ),
                            enabledBorder : UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: lineColor
                              ),
                            ),
                          ),
                          // validator: MultiValidator([
                          //   RequiredValidator(errorText: "Required"),
                          //   MinLengthValidator(6,
                          //       errorText: "Password should be atleast 8 characters"
                          //       ),
                          //   MaxLengthValidator(15,
                          //       errorText:
                          //       "Password should not be greater than 15 characters"
                          //       )
                          // ])
                          validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return "Required";
                                  } else if (value.length < 8) {
                                    return "Password must be atleast 8 characters long";
                                  } else if (value != confirmpass) {
                                    return "Password must be same as above";
                                  }
                                },
                        ),
                      ),
                    ),

                    Container(
                      width: 330,
                      height: 48,
                      margin: EdgeInsets.only(top: 820, left: 50),
                      child: ElevatedButton(
                        onPressed: () async{
                          if (formkey.currentState!.validate() 
                          && passkey.currentState!.validate() 
                          && passkeyy.currentState!.validate()){
                              openDialog();
                              print("Validated");
                              Future.delayed(Duration(seconds: 2), (){
                                  Navigator.of(context).pop(true);
                                  Navigator.push(context,
                                  MaterialPageRoute(builder: (_) => signIn()));
                              });
                            //  Navigator.push(context,
                            //  MaterialPageRoute(builder: (_) => login()));
                        } else {
                          // Navigator.push(context,
                          // MaterialPageRoute(builder: (_) => create()));
                          print("Not Validated");
                        }
                        final String email = emailController.text;
                        final String password = passController.text;

                        final RegisterUser registerUser = await createUser(email, password);

                        },
                        child: Text('CREATE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.black,
                          primary: buttonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future openDialog() => showDialog(
    barrierDismissible: true,
    context: context, 
    builder: (builder) => AlertDialog(
      content: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/dialog.png',
            height: 300,
            fit: BoxFit.fill,
            ),
            // FutureBuilder(
            //   future: Future.delayed(Duration(seconds: 1), () {
            //     Navigator.of(context).pop(true);
            //   }),
              
            //   builder: (BuildContext context, AsyncSnapshot snapshot) {
            //     return AlertDialog();
            //   }
            // ),
        ],
      ),
    ),
  );
}