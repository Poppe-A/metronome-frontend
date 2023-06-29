
part of 'songs_bloc.dart';

abstract class SongListState {}

class SongListLoadingState extends SongListState {
  @override
  List<Object?> get props => [];
}

class SongListLoadedState extends SongListState {
  final List<SongModel> songs;
  SongListLoadedState(this.songs);
  @override
  List<Object?> get props => [songs];
}

class UserErrorState extends SongListState {
  final String error;
  UserErrorState(this.error);
  @override
  List<Object?> get props => [error];
}