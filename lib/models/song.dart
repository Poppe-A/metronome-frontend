import 'package:equatable/equatable.dart';

class SongModel extends Equatable {
  late int id;
  late String name;
  late int? position;
  late int tempo;

  SongModel({required this.name, required this.tempo, required this.id, this.position});

  SongModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    tempo = json['tempo'];
    position = json['position'];
  }

   SongModel copyWith({
    required int id,
    required String name,
    required int tempo,
    int? position,
  }) {
    print('copyWith name ${name} ${id} ${tempo}');
    return SongModel(
      id: id,
      name: name,
      tempo: tempo ,
      position: position
    );
  }
  List<Object?> get props => [id, name, tempo];

}

SongModel emptySong = SongModel(name: "", tempo: 0, id: 0, position: 9999);

class UserModel {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;

  UserModel({this.id, this.email, this.firstName, this.lastName, this.avatar});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    avatar = json['avatar'];
  }
}