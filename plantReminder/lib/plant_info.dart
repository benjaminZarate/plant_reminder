class Plant {
  String _name;
  String _specie;
  String _day;
  String _image;

  Plant(this._name, this._specie, this._day, this._image);

  //Getters
  String getName() {
    return _name;
  }

  String getSpecie() {
    return _specie;
  }

  String getDay() {
    return _day;
  }

  String getImage() {
    return _image;
  }

  //Setters
  String setName(String name) {
    this._name = name;
  }

  String setSpecie(String specie) {
    this._specie = specie;
  }

  String setDay(String day) {
    this._day = day;
  }

  String setImage(String image) {
    this._image = image;
  }
}
