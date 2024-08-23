import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vdocipher_flutter/vdocipher_flutter.dart';

class VdoPlaybackView extends StatefulWidget {
  final bool controls;
  final EmbedInfo? embedInfo;
  const VdoPlaybackView({super.key, this.controls = true, this.embedInfo});

  @override
  VdoPlaybackViewState createState() => VdoPlaybackViewState();
}

class VdoPlaybackViewState extends State<VdoPlaybackView> {
  final double aspectRatio = 16 / 9;
  VdoPlayerValue? vdoPlayerValue;
  final ValueNotifier<bool> _isFullScreen = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Flexible(
            child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 800,
              height: 550,
              child: VdoPlayer(
                embedInfo: widget.embedInfo!,
                aspectRatio: aspectRatio,
                onError: _onVdoError,
                onFullscreenChange: _onFullscreenChange,
                onPlayerCreated: (controller) => _onPlayerCreated(controller),
                controls: widget.controls,
              ),
            ),
          ],
        )),
      ]),
    ));
  }

  _onVdoError(VdoError vdoError) {
    if (kDebugMode) {
      print("Oops, the system encountered a problem: ${vdoError.message}");
    }
  }

  _onPlayerCreated(VdoPlayerController? controller) {
    setState(() {
      if (kIsWeb) {
        controller?.removeListener(() {});
        _vdoChangeListener(controller);
      }
    });
  }

  _vdoChangeListener(VdoPlayerController? controller) {
    controller!.addListener(() {
      VdoPlayerValue value = controller.value;
      setState(() {
        vdoPlayerValue = value;
      });
      if (kDebugMode) {
        print("Current Position : ${vdoPlayerValue?.position.inSeconds} ");
      }
    });
  }

  _onFullscreenChange(isFullscreen) {
    setState(() {
      _isFullScreen.value = isFullscreen;
    });
  }
}
