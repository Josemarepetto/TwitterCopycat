import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class PasswdTextFormField extends StatefulWidget {
  // PasswdTextFormField({Key? key}) : super(key: key);
  bool _ocultarPasswd;
  String _textoLabel;
  TextEditingController _passwdController;
  PasswdTextFormField(
      this._ocultarPasswd, this._textoLabel, this._passwdController);

  @override
  _PasswdTextFormFieldState createState() => _PasswdTextFormFieldState();
}

class _PasswdTextFormFieldState extends State<PasswdTextFormField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0),
      child: ListTile(
        trailing: IconButton(
          icon: this.widget._ocultarPasswd == true
              ? Icon(
                  FontAwesomeIcons.eye,
                  color: Colors.white38,
                )
              : Icon(
                  FontAwesomeIcons.eyeSlash,
                  color: Colors.white38,
                ),
          onPressed: () {
            this.widget._ocultarPasswd = !this.widget._ocultarPasswd;
            setState(() {});
          },
        ),
        title: TextField(
          obscureText: this.widget._ocultarPasswd,
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
    );
  }

  TextEditingController getPasswdController() {
    return this.widget._passwdController;
  }
}
