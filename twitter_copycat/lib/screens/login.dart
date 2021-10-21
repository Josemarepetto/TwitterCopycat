import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_copycat/screens/util/passwdtextfield.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  //const LoginScreen({Key? key}) : super(key: key);
  var selectedPageIndex;
  LoginScreen(this.selectedPageIndex);

  TextEditingController passController = new TextEditingController();

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var selectedPageIndex = 0;
  TextEditingController passController = new TextEditingController();
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
                    print(selectedPageIndex);
                    selectedPageIndex = 1;
                    setState(() {});
                  },
                  child: Text(
                    'Next',
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
      child: Scaffold(
        appBar: appBar,
        body: screens.elementAt(selectedPageIndex),
        bottomNavigationBar: bottomNavBar(),
      ),
    );
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
  const PasswordScreen({Key? key}) : super(key: key);

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
              child: PasswdTextFormField(
                  true, 'Password', LoginScreen(0).passController)),
        ],
      ),
    );
  }
}
