import 'package:bloc/bloc.dart';
import 'package:metronome_frontend/models/song.dart';


class BlinkerCubit extends Cubit<SongModel> {
  BlinkerCubit() : super(emptySong);

  void selectSong(SongModel song) => {
    print("chouette"),
    print(song.name),
    emit(song)
  };

  void resetSong() {
    emit(emptySong);
  }
}
