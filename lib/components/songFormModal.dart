import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metronome_frontend/models/song.dart';

import '../blocs/songsBloc/songs_bloc.dart';

class SongFormModal extends StatefulWidget {

  const SongFormModal({
    super.key,
    this.songToUpdate,
    required this.songBloc, 
  });

  final SongModel? songToUpdate;
  final SongBloc songBloc;

  @override
  SongFormModalState createState() {
    return SongFormModalState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class SongFormModalState extends State<SongFormModal> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final tempoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.songToUpdate?.name ?? '';
    tempoController.text = (widget.songToUpdate?.tempo != null ? widget.songToUpdate?.tempo.toString() : '')!;
  }

   @override
  void dispose() {
    nameController.dispose();
    tempoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Column(
      
      children: [
        Text(widget.songToUpdate != null ? 'Update song' : 'Create song'),
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'Enter your song name',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: tempoController,
                decoration: const InputDecoration(
                  hintText: 'Enter your song tempo',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          if (widget.songToUpdate == null) {
                            var newSong = SongModel(name: nameController.value.text, tempo: int.parse(tempoController.value.text), id: 0); // TODO fix ID
                            widget.songBloc.add(AddSongEvent(newSong));
                            Navigator.pop(context);
                          } else {
                            var updatedSong = SongModel(name: nameController.value.text, tempo: int.parse(tempoController.value.text), id: widget.songToUpdate!.id); // TODO fix ID
                            widget.songBloc.add(UpdateSongEvent(updatedSong));
                            Navigator.pop(context);
                          }
                        }
                      },
                      child: const Text('Submit'),
                    ),
                    if(widget.songToUpdate != null) ...[
                      const SizedBox(width: 50),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black
                        ),
                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise.
                            widget.songBloc.add(DeleteSongEvent(widget.songToUpdate!.id));
                            Navigator.pop(context);
                        },
                        child: const Text('Delete song'),
                      ),
                    ]
                   
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}