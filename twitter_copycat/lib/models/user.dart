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
  'http://cemokalab.com/wp-content/uploads/2015/07/avatar-372-456324.png',
  'https://www.dralejandroreynoso.com.mx/wp-content/uploads/2021/08/mujer-avatar.png',
  'https://www.dralejandroreynoso.com.mx/wp-content/uploads/2021/08/mujer-avatar-2.png',
  'https://www.dralejandroreynoso.com.mx/wp-content/uploads/2021/08/hombre-avatar-3.png',
  'https://www.dralejandroreynoso.com.mx/wp-content/uploads/2021/08/hombre-avatar-5.png',
];
