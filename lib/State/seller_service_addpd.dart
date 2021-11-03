import 'package:flutter/material.dart';
import 'package:myfirstpro/utility/my_constant.dart';
import 'package:myfirstpro/widgets/show_image.dart';
import 'package:myfirstpro/widgets/show_title.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    buildProductName(constraints),
                    buildProductPrice(constraints),
                    buildProductDetail(constraints),
                    buildImage(constraints),
                    addProductButtom(constraints),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container addProductButtom(BoxConstraints constraints) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      width: constraints.maxWidth * 0.75,
      child: ElevatedButton(
        style: Myconstant().myButtonStyle(),
        onPressed: () {
          if (formKey.currentState!.validate()) {
          } else {}
        },
        child: Text('Add Product'),
      ),
    );
  }

  Future<Null> chooseSourceImageDialog(int index) async {
    print('Click From index ===>> $index');
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: showImage(path: Myconstant.image3),
          title: ShowTitle(title: 'Source Image ${index+1} ?', textStyle: Myconstant().h2Style()),
          subtitle: ShowTitle(title: 'Please Tap on camera or gallery', textStyle: Myconstant().h3Style()),
        ),
      ),
    );
  }

  Column buildImage(BoxConstraints constraints) {
    return Column(
      children: [
        Container(
          width: constraints.maxWidth * 0.3,
          height: constraints.maxWidth * 0.4,
          child: Image.asset(Myconstant.image7),
        ),
        Container(
          width: constraints.maxWidth * 0.7,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 35,
                child: InkWell(
                  onTap: () => chooseSourceImageDialog(0),
                  child: Image.asset(Myconstant.image7),
                ),
              ),
              Container(
                width: 40,
                height: 35,
                child: InkWell(
                  onTap: () => chooseSourceImageDialog(1),
                  child: Image.asset(Myconstant.image7),
                ),
              ),
              Container(
                width: 40,
                height: 35,
                child: InkWell(
                  onTap: () => chooseSourceImageDialog(2),
                  child: Image.asset(Myconstant.image7),
                ),
              ),
              Container(
                width: 40,
                height: 35,
                child: InkWell(
                  onTap: () => chooseSourceImageDialog(3),
                  child: Image.asset(Myconstant.image7),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildProductName(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.75,
      margin: EdgeInsets.only(top: 16),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please fill in blank';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelStyle: Myconstant().h3Style(),
          labelText: 'Name :',
          prefixIcon: Icon(
            Icons.production_quantity_limits_outlined,
            color: Myconstant.dark,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Myconstant.dark),
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Myconstant.light),
            borderRadius: BorderRadius.circular(30),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Myconstant.light),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }

  Widget buildProductPrice(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.75,
      margin: EdgeInsets.only(top: 16),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please fill in blank';
          } else {
            return null;
          }
        },
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelStyle: Myconstant().h3Style(),
          labelText: 'Price  :',
          prefixIcon: Icon(
            Icons.monetization_on_outlined,
            color: Myconstant.dark,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Myconstant.dark),
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Myconstant.light),
            borderRadius: BorderRadius.circular(30),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Myconstant.light),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }

  Widget buildProductDetail(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.75,
      margin: EdgeInsets.only(top: 16),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please fill in blank';
          } else {
            return null;
          }
        },
        maxLines: 5,
        decoration: InputDecoration(
          hintStyle: Myconstant().h3Style(),
          hintText: 'Detail :',
          prefixIcon: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 70),
            child: Icon(
              Icons.description_outlined,
              color: Myconstant.dark,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Myconstant.dark),
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Myconstant.light),
            borderRadius: BorderRadius.circular(30),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Myconstant.light),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
