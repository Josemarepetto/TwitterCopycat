import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_copycat/models/user.dart';
import 'package:twitter_copycat/screens/tweets.dart';

GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: true,
        appBar: appBar,
        drawer: drawer,
        body: screens.elementAt(0),
        bottomNavigationBar: bottomNavBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(FontAwesomeIcons.feather),
        ),
      ),
    );
  }

  List<Widget> screens = [
    new TweetsScreen(),
  ];

  Widget bottomNavBar() {
    return new BottomNavigationBar(
        onTap: (index) {
          setState(() {
            selectedPageIndex = index;
          });
        },
        currentIndex: selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              FontAwesomeIcons.home,
              color: selectedPageIndex == 0
                  ? new Color.fromRGBO(56, 161, 243, 1)
                  : Colors.blueGrey,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              FontAwesomeIcons.search,
              color: selectedPageIndex == 1
                  ? new Color.fromRGBO(56, 161, 243, 1)
                  : Colors.blueGrey,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              FontAwesomeIcons.bell,
              color: selectedPageIndex == 2
                  ? new Color.fromRGBO(56, 161, 243, 1)
                  : Colors.blueGrey,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              FontAwesomeIcons.envelope,
              color: selectedPageIndex == 3
                  ? new Color.fromRGBO(56, 161, 243, 1)
                  : Colors.blueGrey,
            ),
          ),
        ]);
  }

  AppBar appBar = new AppBar(
    automaticallyImplyLeading: false,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            _scaffoldKey.currentState!.openDrawer();
          },
          child: Container(
            width: 30.0,
            height: 30.0,
            child: ClipRRect(
              child: Image.network(currentUser.getPictureURL()),
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            FontAwesomeIcons.twitter,
            color: new Color.fromRGBO(56, 161, 243, 1),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(FontAwesomeIcons.star),
          color: new Color.fromRGBO(56, 161, 243, 1),
        )
      ],
    ),
  );

  Drawer drawer = new Drawer(
    elevation: 40.0,
    child: new Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 180.0,
              child: UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(currentUser.getPictureURL()),
                  backgroundColor: Colors.grey.shade400,
                ),
                accountName: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        currentUser.getName(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0,
                            color: Colors.black),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 13.0),
                        child: Icon(Icons.keyboard_arrow_down),
                      )
                    ],
                  ),
                ),
                accountEmail: Container(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      currentUser.getUserName(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          color: Colors.grey),
                    ),
                    Container(
                      height: 30.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            currentUser.getFollowing(),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            ' Siguiendo',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Text(
                            currentUser.getFollowers(),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            ' Seguidores',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
              ),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.user),
              title: Text(
                'Perfil',
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),
              ),
            ),
            ListTile(
              leading: Icon(Icons.featured_play_list),
              title: Text(
                'Listas',
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),
              ),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.palette),
              title: Text(
                'Temas',
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),
              ),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.bookmark),
              title: Text(
                'Elementos guardados',
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),
              ),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.bolt),
              title: Text(
                'Momentos',
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),
              ),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.shoppingCart),
              title: Text(
                'Compras',
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),
              ),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.moneyBillAlt),
              title: Text(
                'Monetización',
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),
              ),
            ),
            Divider(
              height: 20.0,
            ),
            ListTile(
              title: Text(
                'Configuración y privacidad',
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),
              ),
            ),
            ListTile(
              title: Text(
                'Centro de Ayuda',
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Divider(
                height: 20.0,
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 14.0,
                  ),
                  Expanded(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(FontAwesomeIcons.lightbulb),
                          Icon(FontAwesomeIcons.qrcode)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 14.0,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 14.0,
            ),
          ],
        ),
      ),
    ),
  );
}
