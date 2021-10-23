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
        stream: db
            .collection('tweets')
            .orderBy('time', descending: true)
            .snapshots(),
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
                      doc.data()['userName'],
                      doc.data()['userProfilePicture'],
                      doc.data()['text'],
                      doc.data()['imageURL'],
                      doc.data()['time'],
                      doc.data()['comments'],
                      doc.data()['likes'],
                      doc.data()['retweets']),
                );
              }).toList(),
            );
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class Tweet extends StatefulWidget {
  String _user;
  String _userName;
  String _userProfilePicture;
  String _text;
  String _imageURL;
  String _time;
  String _comments;
  String _likes;
  String _retweets;

  Tweet(this._user, this._userName, this._userProfilePicture, this._text,
      this._imageURL, this._time, this._comments, this._likes, this._retweets);

  @override
  _TweetState createState() => _TweetState();
}

class _TweetState extends State<Tweet> {
  String calculateTime() {
    if (DateTime.now().difference(DateTime.parse(widget._time)).inMinutes >
            60 &&
        DateTime.now().difference(DateTime.parse(widget._time)).inHours < 24) {
      return ' ${DateTime.now().difference(DateTime.parse(widget._time)).inHours}h';
    } else if (DateTime.now().difference(DateTime.parse(widget._time)).inHours >
        24) {
      return ' ${DateTime.now().difference(DateTime.parse(widget._time)).inDays}d';
    } else if (DateTime.now()
            .difference(DateTime.parse(widget._time))
            .inSeconds >
        60) {
      return ' ${DateTime.now().difference(DateTime.parse(widget._time)).inMinutes}min';
    } else
      return ' ${DateTime.now().difference(DateTime.parse(widget._time)).inSeconds}s';
  }

  @override
  Widget build(BuildContext context) {
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
                    child: Image.network(widget._userProfilePicture),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      text: widget._user,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 17.0,
                                          color: Colors.black),
                                    ),
                                    TextSpan(
                                      text: ' ' + widget._userName,
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    TextSpan(
                                      text: calculateTime(),
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
                        widget._text,
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 4.0, bottom: 4.0, right: 5.0),
                      child: ClipRRect(
                        child: widget._imageURL == ''
                            ? SizedBox()
                            : Image.network(widget._imageURL),
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
                                '  ' + widget._comments,
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
                                '  ' + widget._retweets,
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
                                '  ' + widget._likes,
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
