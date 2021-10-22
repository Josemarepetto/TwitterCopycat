import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TweetsScreen extends StatefulWidget {
  TweetsScreen({Key? key}) : super(key: key);

  @override
  _TweetsState createState() => _TweetsState();
}

class _TweetsState extends State<TweetsScreen> {
  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: StreamBuilder<QuerySnapshot>(
        stream: db.collection('tweets').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else
            return ListView(
              children: snapshot.data!.docs.map((doc) {
                return Container(
                    child: new Tweet(
                        doc.data()['user'],
                        doc.data()['text'],
                        doc.data()['imageURL'],
                        doc.data()['time'],
                        doc.data()['comments'],
                        doc.data()['likes'],
                        doc.data()['retweets']));
              }).toList(),
            );
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class Tweet extends StatelessWidget {
  String _user;
  String _text;
  String _imageURL;
  String _time;
  String _comments;
  String _likes;
  String _retweets;

  Tweet(this._user, this._text, this._imageURL, this._time, this._comments,
      this._likes, this._retweets);

  CollectionReference _userFromFirebase =
      FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    String _userImage = '';

    Future<void> getUserImage(String username) async {
      QuerySnapshot respuesta = await _userFromFirebase.get();

      if (respuesta.docs.length > 0) {
        for (var doc in respuesta.docs) {
          if (username == doc.data()['username']) {
            _userImage = doc.data()['imageURL'];
          }
        }
      }
    }

    getUserImage(_user);

    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(4.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  width: 50.0,
                  height: 50.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: Image.network(_userImage),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: _user,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 17.0,
                                          color: Colors.black),
                                    ),
                                    TextSpan(
                                      text: ' ' + _user,
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' $_time' + 'h',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 3.0),
                            child: Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        _text,
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 4.0, bottom: 4.0, right: 5.0),
                      child: ClipRRect(
                        child: Image.network(_imageURL),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 8.0, bottom: 8.0, right: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.comment,
                                color: Colors.grey,
                                size: 16.0,
                              ),
                              Text(
                                '  ' + _comments,
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.retweet,
                                color: Colors.grey,
                                size: 16.0,
                              ),
                              Text(
                                '  ' + _retweets,
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.heart,
                                color: Colors.grey,
                                size: 16.0,
                              ),
                              Text(
                                '  ' + _likes,
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                          Icon(
                            FontAwesomeIcons.shareAlt,
                            color: Colors.grey,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
