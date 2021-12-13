import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:encrypt/encrypt.dart' as encrypt;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myfirstpro/main.dart';
import 'package:myfirstpro/utility/encrypt.dart';
import 'package:myfirstpro/utility/my_constant.dart';
import 'package:myfirstpro/utility/my_dialog.dart';
import 'package:myfirstpro/widgets/show_image.dart';
import 'package:myfirstpro/widgets/show_progress.dart';
import 'package:myfirstpro/widgets/show_title.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  String? typeUser;
  String userImg = '';
  File? file;
  bool statusRedEyes = true;
  double? lat, long;
  var encryptedText;
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  get sha256 => null;

  @override
  void initState() {
    super.initState();
    checkPermission();
  }

  Future<Null> checkPermission() async {
    bool locationSevice;
    // ignore: unused_local_variable
    LocationPermission locationPermission;

    locationSevice = await Geolocator.isLocationServiceEnabled();
    if (locationSevice) {
      print('Sevice Location Open');

      locationPermission = await Geolocator.checkPermission();
      if (locationPermission == LocationPermission.denied) {
        locationPermission = await Geolocator.requestPermission();
        if (locationPermission == LocationPermission.deniedForever) {
          MyDialog().alertLocationService(
              context, 'ไม่อนุญาตแชร์ Location', 'โปรดแชร์ Location');
        } else {
          // Find Lat Long
          findLatLong();
        }
      } else {
        if (locationPermission == LocationPermission.deniedForever) {
          MyDialog().alertLocationService(
              context, 'ไม่อนญาตแชร์ Location', 'โปรดแชร์ Location');
        } else {
          // Find Lat Long
          findLatLong();
        }
      }
    } else {
      print('Sevice Location Close');
      MyDialog().alertLocationService(context, 'Location Service is closed ?',
          'Please Open Location Sevice');
    }
  }

  Future<Null> findLatLong() async {
    print('findLatLong ==> Work');
    Position? position = await findPosition();
    setState(() {
      lat = position!.latitude;
      long = position.longitude;
      print('lat = $lat,long = $long');
    });
  }

  Future<Position?> findPosition() async {
    Position position;
    try {
      position = await Geolocator.getCurrentPosition();
      return position;
    } catch (e) {
      return null;
    }
  }

  Row buildName(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            controller: nameController,
            validator: MultiValidator([
              RequiredValidator(errorText: 'กรุณาระบุส่วนนี้'),
              MaxLengthValidator(20, errorText: 'ชื่อไม่ควรเกิน 20 ตัวอักษร')
            ]),
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
            controller: addressController,
            validator: MultiValidator([
              RequiredValidator(errorText: 'กรุณาระบุส่วนนี้'),
            ]),
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
            controller: phoneController,
            keyboardType: TextInputType.phone,
            validator: MultiValidator([
              RequiredValidator(errorText: 'กรุณาระบุส่วนนี้'),
            ]),
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
            controller: userController,
            validator: MultiValidator([
              RequiredValidator(errorText: 'กรุณาระบุส่วนนี้'),
            ]),
            decoration: InputDecoration(
              labelStyle: Myconstant().h3Style(),
              labelText: 'UserName :',
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
            controller: passwordController,
            validator: MultiValidator([
              RequiredValidator(errorText: 'กรุณาระบุส่วนนี้'),
              MinLengthValidator(8,
                  errorText: 'ความยาวของ Password อย่างน้อย 8 ตัวอักษร'),
            ]),
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
        actions: [
          buildCreateNewAccount(),
        ],
        title: Text('Create New Account'),
        backgroundColor: Myconstant.primary,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        behavior: HitTestBehavior.opaque,
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
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
                buildTitle('แสดงพิกัดตำแหน่งปัจจุบัน'),
                buildMap(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconButton buildCreateNewAccount() {
    return IconButton(
      onPressed: () {
        if (formKey.currentState!.validate()) {
          if (typeUser == null) {
            print('Non Choose Type User');
            MyDialog().normalDialog(context, 'ยังไม่ได้เลือกชนิดผู้ใช้งาน',
                'กรุณาเลือกชนิดของผู้ใช้งาน');
          } else {
            print('Process Insert to DATABASE');
            uploadPicAndInsertData();
          }
        }
      },
      icon: Icon(Icons.cloud_upload),
    );
  }

  Future<Null> uploadPicAndInsertData() async {
    String name = nameController.text.toLowerCase();
    String address = addressController.text;
    String phone = phoneController.text;
    String user = userController.text;
    encryptedText = EncryptAndDecrypt.encryptAES(passwordController.text);
    //print('################## ${EncryptAndDecrypt.decryptAES(encryptedText)}');
    print(
        "### name = $name, address = $address, phone = $phone, user = $user, password = ${encryptedText.base64}");
    String path =
        '${Myconstant.domain}/tu2hand/getUserWhereUser.php?isAdd=true&user=$user';
    await Dio().get(path).then((value) async {
      print('## value ==>> $value');
      if (value.toString() == 'null') {
        print('## User can use');

        if (file == null) {
          //no img
          processInsertMySQL(
            name: name,
            address: address,
            phone: phone,
            user: user,
            password: encryptedText.base64,
          );
        } else {
          //img
          print('### process Upload Pic');
          String apiSaveUserImg = '${Myconstant.domain}/tu2hand/saveFile.php';
          int i = Random().nextInt(100000);
          String nameImg = 'profile_$i.jpg';
          Map<String, dynamic> map = Map();
          map['file'] =
              await MultipartFile.fromFile(file!.path, filename: nameImg);
          FormData data = FormData.fromMap(map);
          await Dio().post(apiSaveUserImg, data: data).then((value) {
            userImg = '/tu2hand/userImg/$nameImg';
            processInsertMySQL(
              name: name,
              address: address,
              phone: phone,
              user: user,
              password: encryptedText.base64,
            );
          });
        }
      } else {
        MyDialog()
            .normalDialog(context, 'User can not use?', 'please change user');
      }
    });
  }

  Future<Null> processInsertMySQL(
      {String? name,
      String? address,
      String? phone,
      String? user,
      String? password}) async {
    print('## processInsertMySQL and img is work ==>> $password');
    String apiInsertUser =
        '${Myconstant.domain}/tu2hand/insertUser.php?isAdd=true&name=$name&type=$typeUser&address=$address&phone=$phone&user=$user&password=$password&img=$userImg&lat=$lat&long=$long';
    await Dio().get(apiInsertUser).then((value) {
      if (value.toString() == 'true') {
        Navigator.pop(context); // กลับไปหาหน้าแรก
      } else {
        MyDialog()
            .normalDialog(context, 'Create new user false', 'Please try again');
      }
    });
  }

  Set<Marker> setMarker() => <Marker>[
        Marker(
          markerId: MarkerId('id'),
          position: LatLng(lat!, long!),
          infoWindow: InfoWindow(
              title: 'You are here', snippet: 'Lat = $lat,Long = $long'),
        ),
      ].toSet();

  Widget buildMap() => Container(
        width: double.infinity,
        height: 200,
        child: lat == null
            ? ShowProgress()
            : GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(lat!, long!),
                  zoom: 16,
                ),
                onMapCreated: (controller) {},
                markers: setMarker(),
              ),
      );

  Future<Null> chooseImage(ImageSource source) async {
    try {
      var result = await ImagePicker().pickImage(
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
