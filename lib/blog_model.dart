import 'dart:typed_data';

/*class Blog {
  int id;
  String name;
  Blog(this.id, this.name);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
    };
    return map;
  }

  Blog.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
  }
}*/

class Photo {
  int id;
  String photo_name;

  Photo(this.id, this.photo_name);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'photo_name': photo_name,
    };
    return map;
  }

  Photo.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    photo_name = map['photo_name'];
  }
}

  /*Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "picture" : picture,
  };*/
