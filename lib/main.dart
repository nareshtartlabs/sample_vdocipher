import 'package:flutter/material.dart';
import 'package:sample_vdo_cipher/video_playback_view.dart';
import 'package:vdocipher_flutter/vdocipher_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    const EmbedInfo embedInfo = EmbedInfo.streaming(
      otp: '20160313versUSE323acR62uawRT4VQUtPRNESY6L6hPsR4f1AjtOiwrOTcqpayG',
      playbackInfo:
          'eyJ2aWRlb0lkIjoiMjg2ZTU1MWYxNWM4NGI1NWFlNTI0MzBiMTYxYWJhMGMifQ==',
      embedInfoOptions: EmbedInfoOptions(autoplay: false),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            if (context.mounted) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const VdoPlaybackView(embedInfo: embedInfo),
                ),
              );
            }
          },
          child: const Text('Play Video'),
        ),
      ),
    );
  }
}
