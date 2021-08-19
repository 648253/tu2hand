import 'package:flutter/material.dart';
import 'package:myfirstpro/utility/my_constant.dart';
import 'package:myfirstpro/widgets/show_image.dart';
import 'package:myfirstpro/widgets/show_title.dart';

class Authen extends StatefulWidget {
  const Authen({Key? key}) : super(key: key);

  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  bool statusRedEyes = true;

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          buildImage(size),
          buildAppName(),
          buildUser(size),
          buildPassword(size)
        ],
      )),
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
        ShowTitle(
          title: Myconstant.appName,
          textStyle: Myconstant().h1Style(),
        ),
      ],
    );
  }

  Row buildImage(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(width: size * 0.6, child: showImage(path: Myconstant.image1)),
      ],
    );
  }
}
