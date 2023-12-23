import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MusicPlayer extends StatefulWidget {
  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  final audioPlayer = AudioPlayer();
  String currentPlayingDocId = '';
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    audioPlayer.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        setState(() {
          currentPlayingDocId = '';
          isPlaying = false;
        });
      }
    });
  }

  Future<void> playAudio(String audioUrl, String docId) async {
    if (docId != currentPlayingDocId) {
      if (isPlaying) {
        await audioPlayer.stop();
      }
      await audioPlayer.setUrl(audioUrl);
      await audioPlayer.play();
      setState(() {
        currentPlayingDocId = docId;
        isPlaying = true;
      });
    } else if (isPlaying) {
      await audioPlayer.pause();
      setState(() {
        isPlaying = false;
      });
    } else {
      await audioPlayer.play();
      setState(() {
        isPlaying = true;
      });
    }
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('songs').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final songs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: songs.length,
            itemBuilder: (context, index) {
              final song = songs[index]; 
              final songName = song['sname'];
              final songImage = song['simage'];
              final songAudioUrl = song['song'];
              final docId = song.id;

              return Card(
                child: ListTile(
                  title: Text(songName,style: TextStyle(color: Colors.purple),),
                  leading: Image.network(songImage,height: 200,width:100,fit:BoxFit.cover),
                  trailing: StreamBuilder<PlayerState>(
                    stream: audioPlayer.playerStateStream,
                    builder: (context, playerStateSnapshot) {
                      final playerState = playerStateSnapshot.data;
                      return IconButton(color: isPlaying?Colors.green:Colors.purple,
                        icon: (currentPlayingDocId == docId && isPlaying)  
                            ? Icon(Icons.pause)
                            : Icon(Icons.play_arrow),
                        onPressed: () { 
                          if (currentPlayingDocId != docId || !isPlaying) {
                            playAudio(songAudioUrl, docId);
                          } else {
                            playAudio(songAudioUrl, docId);
                          }
                        },
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
