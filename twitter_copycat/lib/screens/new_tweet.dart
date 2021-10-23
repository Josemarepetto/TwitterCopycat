import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:twitter_copycat/models/user.dart';

TextEditingController _tweetTextController = new TextEditingController();

class NewTweetScreen extends StatefulWidget {
  const NewTweetScreen({Key? key}) : super(key: key);

  @override
  _NewTweetScreenState createState() => _NewTweetScreenState();
}

class _NewTweetScreenState extends State<NewTweetScreen> {
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
              _tweetTextController = new TextEditingController();
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.close,
              color: new Color.fromRGBO(56, 161, 243, 1),
            ),
          ),
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
              shareNewTweet();
            },
            child: Text(
              'Tweet',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );

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
          body: WriteNewTweet(),
        ),
      ),
    );
  }

  String getUsername() {
    String _username = '';
    if ((GetUtils.isNumericOnly(currentUser.getUserName()) &&
            currentUser.getUserName().length == 9) ||
        GetUtils.isEmail(currentUser.getUserName())) {
      _username = '@${currentUser.getName().toLowerCase().replaceAll(' ', '')}';
    } else
      _username = currentUser.getUserName();

    return _username;
  }

  void shareNewTweet() {
    Random r = new Random();
    Map<String, dynamic> newTweet = {
      'comments': r.nextInt(100).toString(),
      'imageURL': '',
      'likes': r.nextInt(100).toString(),
      'retweets': r.nextInt(100).toString(),
      'text': _tweetTextController.text,
      'time': DateTime.now().toString(),
      'user': currentUser.getName(),
      'userName': getUsername(),
      'userProfilePicture': currentUser.getPictureURL(),
    };

    FirebaseFirestore.instance
        .collection('tweets')
        .add(newTweet)
        .whenComplete(() {
      _tweetTextController = new TextEditingController();
      Navigator.of(context).pop();
    });
  }
}

class WriteNewTweet extends StatelessWidget {
  const WriteNewTweet({
    Key? key,
  }) : super(key: key);

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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      width: 50.0,
                      height: 50.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25.0),
                        child: Image.network(currentUser.getPictureURL()),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 8,
                  child: TextField(
                    autofocus: true,
                    controller: _tweetTextController,
                    style: TextStyle(
                      color: new Color.fromRGBO(56, 161, 243, 1),
                    ),
                    decoration: InputDecoration(
                      hintText: 'What´s happening?',
                      hintStyle: TextStyle(color: Colors.white, fontSize: 17.0),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
