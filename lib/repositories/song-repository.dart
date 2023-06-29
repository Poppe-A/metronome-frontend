import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:metronome_frontend/models/models.dart';

class SongRepository {
  String serverUrl = "http://10.0.2.2:5000";

  Future<List<SongModel>> getSongs() async {
    try {
      var url = Uri.parse("$serverUrl/songs/all");

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List result = jsonDecode(response.body);
        var songList = result.map((e) => SongModel.fromJson(e)).toList();

        return songList;
      } else {
        print("fetch song error -------- ${response.reasonPhrase}");
        return [];
      }
    } catch (e) {
      print("fetch error: ${e}");
      return [];
    }
    
  }

  Future addSong(SongModel newSong) async {
    var url = Uri.parse("$serverUrl/songs/add");

    var title = DateTime.now();
    final response = await http.post(
      url,
      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'name': newSong.name,
        'tempo': newSong.tempo
      }),
    );
    
    if (response.statusCode == 200) {
      // return getSongs();
    } else {
      print("add song error -------- ${response.reasonPhrase}");

    }
  }

  Future updateSong(SongModel updatedSong) async {
    var url = Uri.parse("$serverUrl/songs/update");

    var title = DateTime.now();
    final response = await http.patch(
      url,
      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': updatedSong.id,
        'name': updatedSong.name,
        'tempo': updatedSong.tempo
      }),
    );
    
    if (response.statusCode == 200) {
      // return getSongs();
    } else {
    }

  }

  Future deleteSong(int songId) async {
    var url = Uri.parse("$serverUrl/songs/delete/$songId");

    final response = await http.delete(
      url,
      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      }
    );
    
    if (response.statusCode == 200) {
      // return getSongs();
    } else {
    }

  }

    Future updateListOrder(int oldIndex, int newIndex) async {
    var url = Uri.parse("$serverUrl/songs/updateListOrder");

    final response = await http.patch(
      url,
      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'oldIndex': oldIndex,
        'newIndex': newIndex,
      }),
    );
    
    if (response.statusCode == 200) {
      print("update list order ok");
      // return getSongs();
    } else {
      print("update song error -------- ${response.reasonPhrase}");
    }

  }
}