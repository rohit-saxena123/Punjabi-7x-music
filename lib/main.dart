import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:punjabi/registerfile.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: registerfile(),
      debugShowCheckedModeBanner: false,

    );
  }
}


class Punjabimusic extends StatefulWidget {
  const Punjabimusic({super.key});

  @override
  State<Punjabimusic> createState() => _PunjabimusicState();
}

class _PunjabimusicState extends State<Punjabimusic> {
  bool _isLoading = true;
  late  VlcPlayerController _vlcPlayerController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _vlcPlayerController = VlcPlayerController.network(
      'https://stream.e2is.in/hls/7xMusic.m3u8',
      hwAcc: HwAcc.auto,
      autoPlay: true,
      options: VlcPlayerOptions(),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _vlcPlayerController.dispose();
    _vlcPlayerController.getAvailableRendererServices();
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: VlcPlayer(
            controller: _vlcPlayerController,
            aspectRatio: 16/9,
          placeholder: Center(child: CircularProgressIndicator(color: Colors.black,)),

        ),
      ),
    );
  }
}



