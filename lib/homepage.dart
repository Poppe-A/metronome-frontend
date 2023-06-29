import 'package:metronome_frontend/blocs/blinkerCubit/blinkerCubit.dart';
import 'package:metronome_frontend/blocs/songsBloc/songs_bloc.dart';
import 'package:metronome_frontend/components/blinker.dart';
import 'package:metronome_frontend/components/songFormModal.dart';
import 'package:metronome_frontend/models/models.dart';
import 'package:metronome_frontend/repositories/song-repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SongBloc>(
      create: (_) => SongBloc(SongRepository()),
      child: blocBody()
    );
  }

  // Widget buttoonz(BuildContext context) {
  // Widget buttoonz() {
  //   return BlocBuilder<SongBloc, SongState>(
  //     builder: (context, state) {
  //     });
  // } 


  Widget blocBody() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SongBloc>(
          create: (context) => SongBloc(
            SongRepository(),
          )..add(FetchSongsEvent())
        ),
        BlocProvider<BlinkerCubit>(create: (_) => BlinkerCubit())
      ],
      child: BlocBuilder<SongBloc, SongListState>(
        // buildWhen: (previous, current) => previous != current,
        builder: (BuildContext context, SongListState songListState) {
          return SafeArea(
            child: BlocBuilder<BlinkerCubit, SongModel>(
              builder: (context, blinkerState) {
                return Column(
                  children: [
                    Blinker(
                      tempo: blinkerState.tempo,
                      children: [
                        _displayTitle(),
                        _displaySongList(songListState, blinkerState, context),
                        _displayBottomBar(blinkerState, context)
                      ],
                      ),
                  ]
                );
              }
            )
          );
        },
      ),
    );
  }
}

_displayTitle() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text( 
          "VOID SHELTER - SETLIST", 
          style: TextStyle(
            color: Colors.white,
            fontSize: 25
          )
        ),
      ],
    ),
  );
}

_displaySongList(songListState, blinkerState, context) {
  if (songListState is SongListLoadingState) {
    print("loading state");
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
  if (songListState is SongListLoadedState) {
    print("state: SongListLoadedState");
    List<SongModel> songList = songListState.songs;
    if (songList.isEmpty) {
      return const Text("Not able to display your track list");
    } else {
      print("list ${songList}");
    }
    return Expanded(
      child: Container(
        // height: 500,
        child: ReorderableListView.builder(
          itemCount: songList.length,
          shrinkWrap: true,
          onReorder: (oldIndex, newIndex) => {
            // Here we just avoid triggering an update if we drag an item and don't change its place
            if(!((oldIndex < newIndex) && (newIndex - oldIndex == 1))) {
              BlocProvider.of<SongBloc>(context).add(UpdateListOrderEvent(oldIndex, newIndex))
            }
          },
          itemBuilder: (_, index) {
            return Padding(
              key: ValueKey(songList[index]),

              padding:
                const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Card(
                // color: Theme.of(context).primaryColor,
                color: blinkerState.id == songList[index].id ? Colors.red : Color.fromARGB(141, 96, 125, 139),
                child: ListTile(
                  onTap: () => BlocProvider.of<BlinkerCubit>(context).selectSong(songList[index]),
                  title: FractionallySizedBox(
                    widthFactor: 0.75,
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${songList[index].name.toUpperCase()}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          '${songList[index].tempo.toString().toUpperCase()} BPM',
                          style: const TextStyle(color: Colors.white),
                        ),
                        
                      ],
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.settings, color: Colors.white,),
                    onPressed: () => _showSimpleModalDialog(context, songList[index]),
                    
                  ),
                )
              ),
            );
          }
        ),
      ),
    );    
  }
  if (songListState is UserErrorState) {
    // const a = state.error.
    print("Error: ${songListState.error.split(',')}");
    return const Center(
      child: Text("Error"),
    );
  }
}

_displayBottomBar(blinkerState, context) {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => {_showSimpleModalDialog(context, null)}, 
          child: const Text("Add song")
        ),
        if (blinkerState.tempo != 0) ...[
          const SizedBox(width: 20),
          ElevatedButton(
            onPressed: () => BlocProvider.of<BlinkerCubit>(context).resetSong(),
            child: const Text("Pause"),
          )
        ]
      ],
    ),
  );
}

_showSimpleModalDialog(context, SongModel? songToUpdate){
  // resetSong();
  showDialog(
    context: context,
    builder: (BuildContext newContext) => Dialog(
      
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: SongFormModal(songBloc: BlocProvider.of<SongBloc>(context), songToUpdate: songToUpdate)
            )
          ]
        ),
      )
  );
}
