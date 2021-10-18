import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_copycat/models/tweet.dart';

class TweetsScreen extends StatefulWidget {
  TweetsScreen({Key? key}) : super(key: key);

  @override
  _TweetsState createState() => _TweetsState();
}

class _TweetsState extends State<TweetsScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: ListView.builder(
        itemCount: tweets.length,
        itemBuilder: (context, i) => new Column(
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
                        child:
                            Image.network(tweets[i].getUser().getPictureURL()),
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
                                          text: tweets[i].getUser().getName(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 17.0,
                                              color: Colors.black),
                                        ),
                                        TextSpan(
                                          text: ' ' +
                                              tweets[i].getUser().getUserName(),
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '  ' + tweets[i].getTime(),
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
                            tweets[i].getText(),
                            style: TextStyle(fontSize: 15.0),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 4.0, bottom: 4.0, right: 5.0),
                          child: ClipRRect(
                            child: Image.network(tweets[i].getImageURL()),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 8.0, bottom: 8.0, right: 10.0),
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
                                    '  ' + tweets[i].getComment(),
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
                                    '  ' + tweets[i].getRetweets(),
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
                                    '  ' + tweets[i].getLikes(),
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
        ),
      ),
    );
  }
}
