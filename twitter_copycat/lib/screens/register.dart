import 'dart:math';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_copycat/models/user.dart';
import 'package:twitter_copycat/screens/login.dart';

TextEditingController _nameController = new TextEditingController();
TextEditingController _phoneOrEmailController = new TextEditingController();
TextEditingController _dateOfBirthController = new TextEditingController();
TextEditingController _passwdController = new TextEditingController();

// ignore: must_be_immutable
class InitialScreen extends StatefulWidget {
  //const LoginScreen({Key? key}) : super(key: key);

  InitialScreen(this.selectedPageIndex);
  var selectedPageIndex;
  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  void resetControllers() {
    _nameController = new TextEditingController();
    _phoneOrEmailController = new TextEditingController();
    _dateOfBirthController = new TextEditingController();
    _passwdController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = new AppBar(
      backgroundColor: Colors.black,
      automaticallyImplyLeading: false,
      title: this.widget.selectedPageIndex == 0
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  FontAwesomeIcons.twitter,
                  color: new Color.fromRGBO(56, 161, 243, 1),
                ),
                SizedBox()
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    resetControllers();
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: new Color.fromRGBO(56, 161, 243, 1),
                  ),
                ),
                Icon(
                  FontAwesomeIcons.twitter,
                  color: new Color.fromRGBO(56, 161, 243, 1),
                ),
                SizedBox()
              ],
            ),
    );

    Widget bottomNavBar() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(
                left: 20.0, right: 20.0, top: 40.0, bottom: 10.0),
            color: Colors.black,
            child: Row(
              mainAxisAlignment: this.widget.selectedPageIndex == 0
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  child: this.widget.selectedPageIndex == 0
                      ? Text(
                          'Have an account already? ',
                          style: TextStyle(color: Colors.white, fontSize: 12.0),
                        )
                      : SizedBox(),
                ),
                Container(
                  child: this.widget.selectedPageIndex == 0
                      ? TextButton(
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            alignment: Alignment.centerLeft,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen(0)),
                            );
                          },
                          child: Text(
                            'Log in',
                            style: TextStyle(
                                color: new Color.fromRGBO(56, 161, 243, 1),
                                fontSize: 12.0),
                          ),
                        )
                      : TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              new Color.fromRGBO(56, 161, 243, 1),
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                            ),
                          ),
                          onPressed: () {
                            if (this.widget.selectedPageIndex == 1) {
                              this.widget.selectedPageIndex = 2;
                              setState(() {});
                            } else
                              registerUser();
                          },
                          child: this.widget.selectedPageIndex == 1
                              ? Text(
                                  'Next',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                )
                              : Text(
                                  'Register',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                        ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    List<Widget> screens = [
      new FirstScreen(),
      new RegisterScreen(),
      new PasswordScreen()
    ];

    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          appBar: appBar,
          body: screens.elementAt(this.widget.selectedPageIndex),
          bottomNavigationBar: bottomNavBar(),
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    Random r = new Random();
    showDialog(
      context: context,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );
    await Future<void>.delayed(Duration(seconds: 1));

    Map<String, dynamic> nuevoUsuario = {
      'username': _phoneOrEmailController.text,
      'name': _nameController.text,
      'password': _passwdController.text,
      'imageURL': profilePictures.elementAt(
        r.nextInt(profilePictures.length - 1),
      ),
      'followers': r.nextInt(1000).toString(),
      'following': r.nextInt(1000).toString()
    };

    FirebaseFirestore.instance
        .collection('users')
        .add(nuevoUsuario)
        .then((value) {
      print('Usuario creado');
    }).whenComplete(() {
      resetControllers();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => InitialScreen(0),
        ),
        (route) => false,
      );
    });
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      alignment: Alignment.center,
      color: Colors.black,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(flex: 1, child: SizedBox()),
          Expanded(
            flex: 2,
            child: Text(
              'See what' + "'s happening in \nthe world right now",
              style: TextStyle(
                color: Colors.white,
                fontSize: 27.0,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.white,
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.03,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://i.pinimg.com/originals/c9/b1/6e/c9b16eceedd12986cd5b762474103507.webp'),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.03,
                      ),
                      Text(
                        'Sign in with Google',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 7,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 0.5, color: Colors.white54),
                        ),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        'Or',
                        style: TextStyle(color: Colors.white54, fontSize: 10.0),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 0.5, color: Colors.white54),
                        ),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      new Color.fromRGBO(56, 161, 243, 1),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => InitialScreen(1)),
                    );
                  },
                  child: Text(
                    'Create account',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'By signing, you agree to our ',
                      style: TextStyle(color: Colors.white, fontSize: 11.0),
                    ),
                    TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          alignment: Alignment.centerLeft,
                        ),
                        onPressed: () {},
                        child: Text(
                          'Terms',
                          style: TextStyle(
                              color: new Color.fromRGBO(56, 161, 243, 1),
                              fontSize: 11.0),
                        )),
                    Text(
                      ',',
                      style: TextStyle(color: Colors.white, fontSize: 11.0),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        alignment: Alignment.centerLeft,
                      ),
                      onPressed: () {},
                      child: Text(
                        'Privacy Policy',
                        style: TextStyle(
                            color: new Color.fromRGBO(56, 161, 243, 1),
                            fontSize: 11.0),
                      ),
                    ),
                    Text(', and ',
                        style: TextStyle(color: Colors.white, fontSize: 11.0)),
                    TextButton(
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        alignment: Alignment.centerLeft,
                      ),
                      onPressed: () {},
                      child: Text(
                        'Cookie Use',
                        style: TextStyle(
                            color: new Color.fromRGBO(56, 161, 243, 1),
                            fontSize: 11.0),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Expanded(flex: 1, child: SizedBox()),
        ],
      ),
    );
  }
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // alignment: Alignment.center,
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(left: 35.0, right: 20.0, top: 20.0),
              child: Text(
                'Create your account',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 27.0,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.only(left: 35.0, right: 35.0, bottom: 40.0),
                    child: TextField(
                      controller: _nameController,
                      style: TextStyle(
                        color: new Color.fromRGBO(56, 161, 243, 1),
                      ),
                      decoration: InputDecoration(
                        hintText: 'Name',
                        hintStyle:
                            TextStyle(color: Colors.white, fontSize: 17.0),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white38, width: 0.5),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: new Color.fromRGBO(56, 161, 243, 1),
                              width: 1.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 35.0, right: 35.0, bottom: 15.0),
                    child: TextField(
                      controller: _phoneOrEmailController,
                      style: TextStyle(
                        color: new Color.fromRGBO(56, 161, 243, 1),
                      ),
                      decoration: InputDecoration(
                        hintText: 'Phone number or email address',
                        hintStyle:
                            TextStyle(color: Colors.white, fontSize: 17.0),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white38, width: 0.5),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: new Color.fromRGBO(56, 161, 243, 1),
                              width: 0.5),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 35.0, right: 35.0),
                    child: TextField(
                      keyboardType: TextInputType.datetime,
                      controller: _dateOfBirthController,
                      style: TextStyle(
                        color: new Color.fromRGBO(56, 161, 243, 1),
                      ),
                      decoration: InputDecoration(
                        hintText: 'Date of birth',
                        hintStyle:
                            TextStyle(color: Colors.white, fontSize: 17.0),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white38, width: 0.5),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: new Color.fromRGBO(56, 161, 243, 1),
                              width: 0.5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(),
          )
        ],
      ),
    );
  }
}

class PasswordScreen extends StatelessWidget {
  PasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
            child: Text(
              'Create a password',
              style: TextStyle(
                color: Colors.white,
                fontSize: 27.0,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
            child: TextField(
              obscureText: true,
              controller: _passwdController,
              style: TextStyle(
                color: new Color.fromRGBO(56, 161, 243, 1),
              ),
              decoration: InputDecoration(
                hintText: 'Password',
                hintStyle: TextStyle(color: Colors.white, fontSize: 17.0),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white38, width: 0.5),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: new Color.fromRGBO(56, 161, 243, 1), width: 1.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
