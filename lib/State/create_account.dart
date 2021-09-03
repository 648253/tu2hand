import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myfirstpro/utility/my_constant.dart';
import 'package:myfirstpro/widgets/show_image.dart';
import 'package:myfirstpro/widgets/show_title.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  String? typeUser;
  File? file;
  bool statusRedEyes = true;

  Row buildName(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            decoration: InputDecoration(
              labelStyle: Myconstant().h3Style(),
              labelText: 'Name :',
              prefixIcon: Icon(
                Icons.fingerprint,
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

  Row buildAddress(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'Address :',
              hintStyle: Myconstant().h3Style(),
              prefixIcon: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
                child: Icon(
                  Icons.home,
                  color: Myconstant.dark,
                ),
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

  Row buildPhone(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            decoration: InputDecoration(
              labelStyle: Myconstant().h3Style(),
              labelText: 'Phone :',
              prefixIcon: Icon(
                Icons.phone_android,
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

  Row buildUser(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            decoration: InputDecoration(
              labelStyle: Myconstant().h3Style(),
              labelText: 'User :',
              prefixIcon: Icon(
                Icons.perm_identity,
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

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Account'),
        backgroundColor: Myconstant.primary,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        behavior: HitTestBehavior.opaque,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            buildTitle('ข้อมูลทั่วไป :'),
            buildName(size),
            buildTitle('ประเภทผู้ใช้ :'),
            buildRadioBuyer(size),
            buildRadioSeller(size),
            buildTitle('ข้อมูลพื้นฐาน'),
            buildAddress(size),
            buildPhone(size),
            buildUser(size),
            buildPassword(size),
            buildTitle('รูปภาพ'),
            buildSubTitle(),
            buildAvatar(size),
          ],
        ),
      ),
    );
  }

  Future<Null> chooseImage(ImageSource source) async {
    try {
      var result = await ImagePicker().getImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
      );
      setState(() {
        file = File(result!.path);
      });
    } catch (e) {}
  }

  Row buildAvatar(double size) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: () => chooseImage(ImageSource.camera),
          icon: Icon(
            Icons.add_a_photo,
            size: 30,
            color: Myconstant.dark,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          width: size * 0.3,
          child: file == null
              ? showImage(path: Myconstant.avatar)
              : Image.file(file!),
        ),
        IconButton(
          onPressed: () => chooseImage(ImageSource.gallery),
          icon: Icon(
            Icons.add_photo_alternate,
            size: 30,
            color: Myconstant.dark,
          ),
        ),
      ],
    );
  }

  ShowTitle buildSubTitle() {
    return ShowTitle(
        title: '*ตั้งรูปโปรไฟล์ (ไม่บังคับ)',
        textStyle: Myconstant().h3Style());
  }

  Row buildRadioBuyer(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.6,
          child: RadioListTile(
            value: 'buyer',
            groupValue: typeUser,
            onChanged: (value) {
              setState(() {
                typeUser = value as String?;
              });
            },
            title: ShowTitle(
              title: 'ผู้ซื้อ (ฺBuyer)',
              textStyle: Myconstant().h3Style(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildRadioSeller(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.6,
          child: RadioListTile(
            value: 'seller',
            groupValue: typeUser,
            onChanged: (value) {
              setState(() {
                typeUser = value as String?;
              });
            },
            title: ShowTitle(
              title: 'ผู้ขาย (ฺSeller)',
              textStyle: Myconstant().h3Style(),
            ),
          ),
        ),
      ],
    );
  }

  Container buildTitle(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      child: ShowTitle(
        title: title,
        textStyle: Myconstant().h2Style(),
      ),
    );
  }
}
