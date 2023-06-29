import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:metronome_frontend/repositories/song-repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metronome_frontend/models/song.dart';

part 'songs_events.dart';
part 'songs_states.dart';

class SongBloc extends Bloc<SongEvent, SongListState> {
  final SongRepository _songRepository;

  SongBloc(this._songRepository) : super(SongListLoadingState()) {
    on<FetchSongsEvent>((event, emit) async {
      emit(SongListLoadingState());
      try {
        final songs = await _songRepository.getSongs();
        songs.sort((a, b) => a.position!.compareTo(b.position!));
        emit(SongListLoadedState(songs));
      } catch (e) {
        print("Error");
        emit(UserErrorState(e.toString()));
      }
    });

     on<AddSongEvent>((event, emit) async {
      try {
        final songs = await _songRepository.addSong(event.newSong);
        add(FetchSongsEvent());

      } catch (e) {
        emit(UserErrorState(e.toString()));
      }
    });

    on<UpdateSongEvent>((event, emit) async {
      try {
        final songs = await _songRepository.updateSong(event.updatedSong);
        add(FetchSongsEvent());

      } catch (e) {
        emit(UserErrorState(e.toString()));
      }
    });

     on<DeleteSongEvent>((event, emit) async {

      try {
        final songs = await _songRepository.deleteSong(event.songId);
        add(FetchSongsEvent());

      } catch (e) {
        emit(UserErrorState(e.toString()));
      }
    });

    on<UpdateListOrderEvent>((event, emit) async {
      print("drag ${event.oldIndex} ${event.newIndex}");
      try {
        final songs = await _songRepository.updateListOrder(event.oldIndex, event.newIndex);
        add(FetchSongsEvent());

      } catch (e) {
        emit(UserErrorState(e.toString()));
      }
    });
  }
}