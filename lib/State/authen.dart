import 'dart:convert';

import 'package:crypt/crypt.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myfirstpro/models/user_model.dart';
import 'package:myfirstpro/utility/encrypt.dart';
import 'package:myfirstpro/utility/my_constant.dart';
import 'package:myfirstpro/utility/my_dialog.dart';
import 'package:myfirstpro/widgets/show_image.dart';
import 'package:myfirstpro/widgets/show_title.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';

class Authen extends StatefulWidget {
  const Authen({Key? key}) : super(key: key);

  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  bool statusRedEyes = true;
  var encryptedText, plainText;
  var decryptedText;
  final formKey = GlobalKey<FormState>();
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        behavior: HitTestBehavior.opaque,
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              buildImage(size),
              buildAppName(),
              buildUser(size),
              buildPassword(size),
              buildLogin(size),
              buildCreateAccount(),
            ],
          ),
        ),
      )),
    );
  }

  Row buildCreateAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ShowTitle(
          title: 'Non Account ?',
          textStyle: Myconstant().h3Style(),
        ),
        TextButton(
          onPressed: () =>
              Navigator.pushNamed(context, Myconstant.routeCreateAccount),
          child: Text('Create Account'),
        ),
      ],
    );
  }

  Row buildLogin(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            margin: EdgeInsets.symmetric(vertical: 16),
            width: size * 0.6,
            child: ElevatedButton(
              style: Myconstant().myButtonStyle(),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  String user = userController.text.toLowerCase();
                  String passWord = passwordController.text;

                  encryptedText = EncryptAndDecrypt.encryptAES(passWord);

                  checkAuthen(user: user, password: encryptedText.base64);
                } else {}
              },
              child: Text('Login'),
            )),
      ],
    );
  }

  Future<Null> checkAuthen({String? user, String? password}) async {
    String apiCheckAuthen =
        '${Myconstant.domain}/tu2hand/getUserWhereUser.php?isAdd=true&user=$user';
    await Dio().get(apiCheckAuthen).then((value) async {
      //print('## value for API ==> $value');
      if (value.toString() == 'null') {
        MyDialog()
            .normalDialog(context, 'User false!', 'No $user in My Database');
      } else {
        for (var item in json.decode(value.data)) {
          // map value JSON ใน DB ทุกตัวไปยัง user_model
          UserModel model = UserModel.fromMap(item); // เปลี่ยน JSON เป็น model
          if (password == model.password) {
            // success authen
            String type = model.type;
            print('## Authen Success in type ==> $type');

            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            preferences.setString('id', model.id);
            preferences.setString('type', type);
            preferences.setString('user', model.user);
            preferences.setString('name', model.name);

            switch (type) {
              case 'buyer':
                Navigator.pushNamedAndRemoveUntil(
                    context, Myconstant.routeBuyerService, (route) => false);
                break;
              case 'seller':
                Navigator.pushNamedAndRemoveUntil(
                    context, Myconstant.routeSellerService, (route) => false);
                break;
              default:
            }
          } else {
            // false authen
            MyDialog()
                .normalDialog(context, 'Password Wrong!!', 'Please try again');
          }
        }
      }
    });
  }

  Row buildUser(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            controller: userController,
            validator: (value) {
              if (value!.isEmpty) {
                return '*Please fill your Username';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              labelStyle: Myconstant().h3Style(),
              labelText: 'Username :',
              prefixIcon: Icon(
                Icons.account_circle_outlined,
                color: Myconstant.dark,
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Myconstant.dark),
                  borderRadius: BorderRadius.circular(30)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Myconstant.light),
                  borderRadius: BorderRadius.circular(30)),
            ),
          ),
        ),
      ],
    );
  }

  Row buildPassword(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            controller: passwordController,
            validator: (value) {
              if (value!.isEmpty) {
                return '*Please fill your Password';
              } else {
                return null;
              }
            },
            obscureText: statusRedEyes,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    statusRedEyes = !statusRedEyes;
                  });
                },
                icon: statusRedEyes
                    ? Icon(
                        Icons.remove_red_eye,
                        color: Myconstant.dark,
                      )
                    : Icon(
                        Icons.remove_red_eye_outlined,
                        color: Myconstant.dark,
                      ),
              ),
              labelStyle: Myconstant().h3Style(),
              labelText: 'Password :',
              prefixIcon: Icon(
                Icons.lock_outlined,
                color: Myconstant.dark,
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Myconstant.dark),
                  borderRadius: BorderRadius.circular(30)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Myconstant.light),
                  borderRadius: BorderRadius.circular(30)),
            ),
          ),
        ),
      ],
    );
  }

  Row buildAppName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Myconstant().buildEmptyBlock(),
            Myconstant().buildEmptyBlock(),
            ShowTitle(
              title: Myconstant.appName,
              textStyle: Myconstant().h1Style(),
            ),
          ],
        ),
      ],
    );
  }

  Row buildImage(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Myconstant().buildEmptyBlock(),
            Myconstant().buildEmptyBlock(),
            Myconstant().buildEmptyBlock(),
            Myconstant().buildEmptyBlock(),
            Container(
                width: size * 0.3, child: showImage(path: Myconstant.image11)),
          ],
        ),
      ],
    );
  }
}
