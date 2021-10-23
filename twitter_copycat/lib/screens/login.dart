import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_copycat/home.dart';
import 'package:twitter_copycat/models/user.dart';

TextEditingController _usernameController = new TextEditingController();
TextEditingController _passwordController = new TextEditingController();

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  //const LoginScreen({Key? key}) : super(key: key);
  var selectedPageIndex;
  LoginScreen(this.selectedPageIndex);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void resetControllers() {
    _usernameController = new TextEditingController();
    _passwordController = new TextEditingController();
  }

  var selectedPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    AppBar appBar = new AppBar(
      backgroundColor: Colors.black,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              resetControllers();
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.close,
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
            color: Colors.black,
            child: Divider(
              color: Colors.grey,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forgot password?',
                    style: TextStyle(
                      color: new Color.fromRGBO(56, 161, 243, 1),
                    ),
                  ),
                ),
                SizedBox(),
                TextButton(
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
                    if (selectedPageIndex == 0) {
                      selectedPageIndex = 1;
                      setState(() {});
                    } else {
                      loginUser(_usernameController.text,
                          _passwordController.text, context);
                    }
                  },
                  child: selectedPageIndex == 0
                      ? Text(
                          'Next',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        )
                      : Text(
                          'Log in',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                )
              ],
            ),
          ),
        ],
      );
    }

    List<Widget> screens = [new UsernameScreen(), new PasswordScreen()];

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
          body: screens.elementAt(selectedPageIndex),
          bottomNavigationBar: bottomNavBar(),
        ),
      ),
    );
  }

  Future<void> loginUser(
      String username, String password, BuildContext context) async {
    //String passwd = sha256.convert(utf8.encode(password)).toString();
    Map<String, dynamic> usuario = new Map<String, dynamic>();
    String idDoc = '';

    CollectionReference _userFromFirebase =
        FirebaseFirestore.instance.collection('users');
    showDialog(
      context: context,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );
    await Future<void>.delayed(Duration(seconds: 1));

    QuerySnapshot respuesta = await _userFromFirebase.get();

    if (respuesta.docs.length > 0) {
      for (var doc in respuesta.docs) {
        if (username == doc.data()['username']) {
          usuario = doc.data();
          idDoc = doc.id;
        }
      }
      if (idDoc != '') {
        if (usuario['password'] == password) {
          currentUser = new User(usuario['name'], usuario['username'],
              usuario['imageURL'], usuario['followers'], usuario['following']);
          resetControllers();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => Home(),
            ),
            (route) => false,
          );
        } else {
          Navigator.of(context).pop();
          if (usuario['password'] != password) {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: Text('Error!'),
                content: Text('Contraseña incorrecta!'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Aceptar'),
                  )
                ],
                elevation: 20.0,
              ),
            );
          }
        }
      } else {
        Navigator.of(context).pop();

        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Error!'),
            content: Text('Usuario no existe!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Aceptar'),
              )
            ],
            elevation: 20.0,
          ),
        );
      }
    }
  }
}

class UsernameScreen extends StatelessWidget {
  const UsernameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
            child: Text(
              'To get started, first enter your phone, email, or @username',
              style: TextStyle(
                color: Colors.white,
                fontSize: 27.0,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
            child: TextField(
              controller: _usernameController,
              style: TextStyle(
                color: new Color.fromRGBO(56, 161, 243, 1),
              ),
              decoration: InputDecoration(
                hintText: 'Phone, email, or username',
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

class PasswordScreen extends StatelessWidget {
  PasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // alignment: Alignment.center,
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
            child: Text(
              'Enter your password',
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
              controller: _passwordController,
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
