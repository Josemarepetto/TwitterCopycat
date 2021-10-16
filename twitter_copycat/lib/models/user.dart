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

User currentUser = new User(
    'José Repetto',
    '@joserepettorav',
    'https://media-exp1.licdn.com/dms/image/C4E03AQH68BIYeHMz2Q/profile-displayphoto-shrink_800_800/0/1542082157831?e=1639612800&v=beta&t=K1IgyoEPrb76Zh0iYX9zOzuem4qlhUfj-TMDJuQWSV4',
    '125',
    '130');
