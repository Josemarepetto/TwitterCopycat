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
  'https://cdn-icons-png.flaticon.com/512/168/168734.png',
  'https://cdn-icons-png.flaticon.com/512/147/147144.png',
  'https://cdn-icons.flaticon.com/png/512/147/premium/147129.png?token=exp=1635100825~hmac=161eabdd049a52fa7cca9ad2927b830e',
  'https://cdn-icons-png.flaticon.com/512/168/168719.png',
  'https://cdn-icons-png.flaticon.com/512/168/168722.png',
  'https://cdn-icons-png.flaticon.com/512/168/168726.png',
  'https://cdn-icons.flaticon.com/png/512/147/premium/147136.png?token=exp=1635100915~hmac=50717a5251df5eb2bc2c91fc81fdffde',
];
