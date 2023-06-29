
part of 'songs_bloc.dart';

@immutable
abstract class SongEvent extends Equatable {
  const SongEvent();
}

class FetchSongsEvent extends SongEvent {
  @override
  List<Object?> get props => [];
}

class AddSongEvent extends SongEvent {
  const AddSongEvent(
    this.newSong
  );

  final SongModel newSong;

  @override
  List<Object?> get props => [];
}

class UpdateSongEvent extends SongEvent {
  const UpdateSongEvent(
    this.updatedSong
  );

  final SongModel updatedSong;

  @override
  List<Object?> get props => [];
}

class DeleteSongEvent extends SongEvent {
  const DeleteSongEvent(
    this.songId
  );

  final int songId;

  @override
  List<Object?> get props => [];
}

class UpdateListOrderEvent extends SongEvent {
  const UpdateListOrderEvent(
    this.oldIndex,
    this.newIndex
  );

  final int oldIndex;
  final int newIndex;

  @override
  List<Object?> get props => [];
}