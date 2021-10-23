class User {
  String _name;
  String _userName;
  String _pictureURL;
  String _followers;
  String _following;

  User(
    this._name,
    this._userName,
    this._pictureURL,
    this._followers,
    this._following,
  );

  String getName() {
    return this._name;
  }

  String getUserName() {
    return this._userName;
  }

  String getPictureURL() {
    return this._pictureURL;
  }

  String getFollowers() {
    return this._followers;
  }

  String getFollowing() {
    return this._following;
  }

  void setName(String name) {
    this._name = name;
  }

  void setUserName(String userName) {
    this._userName = userName;
  }

  void setPictureURL(String pictureURL) {
    this._pictureURL = pictureURL;
  }

  void setFollowers(String followers) {
    this._followers = followers;
  }

  void setFollowing(String following) {
    this._following = following;
  }
}

User currentUser = new User('', '', '', '', '');

List<String> profilePictures = [
'https://pbs.twimg.com/media/DmBx812U4AEWPmW.jpg',
'https://pbs.twimg.com/media/D2psc0UWoAEu8SC?format=jpg&name=small',
'https://pbs.twimg.com/media/Dz2EMDPXQAEgJkE?format=jpg&name=small',
'https://lh3.googleusercontent.com/proxy/csnaColBsvdHgEuyE4IptKaKQ3sDAqOWSwoC_tdXflSTCbAkbyIFdcRFvtUCrEPLZVhi9Ndk0oypgFye6M7P-1hkRABwF8wVq7VqVUI_bNNYRLQJOg0QvLlf3GOmQF5-H6CEJCPA4_rSGcAdIxtHqA',
'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBd1gAqnwG4nJe-ZoluW8W0NDgZKO7Mbc7f_NB2aAfWbORL7SAURzcLaUYkw1drbLXcc4&usqp=CAU',
];
