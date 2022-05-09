class Usermodel {
  var id;
  var name;
  var mobilenumber;
  var password;

  Usermodel({this.id, this.name, this.mobilenumber, this.password});

  Usermodel.frommap(Map<String, dynamic> data)
      : id = data['id'],
        name = data['name'],
        mobilenumber = data['mobilenumber'],
        password = data['password'];

  Map<String, dynamic> tomap() => {
        'id': id,
        'name': name,
        'mobilenumber': mobilenumber,
        'password': password
      };
}

class Usermodel1 {
  var id;
  String? name;
  String? phoneno;

  Usermodel1({this.id, this.name, this.phoneno});

  Usermodel1.fromjson(Map<String, dynamic> data)
      : id = data['id'],
        name = data['name'],
        phoneno = data['phoneno'];

  Map<String, dynamic> tomap() => {'id': id, 'name': name, 'phoneno': phoneno};
}

class Usermodel2{
  var id;
  String? name;
  String? phoneno;

  Usermodel2({this.id, this.name, this.phoneno});

  Usermodel2.fromjson(Map<String, dynamic> data)
      : id = data['id'],
        name = data['name'],
        phoneno = data['phoneno'];

  Map<String, dynamic> tomap() => {'id': id, 'name': name, 'phoneno': phoneno};
}