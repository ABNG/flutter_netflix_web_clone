import 'package:flutter/material.dart';
import 'package:flutter_netflix_web_clone/models/content_model.dart';
import 'package:flutter_netflix_web_clone/widgets/responsive.dart';
import 'package:flutter_netflix_web_clone/widgets/vertical_icon_button.dart';
import 'package:video_player/video_player.dart';

class ContentHeader extends StatelessWidget {
  final Content featuredContent;

  ContentHeader({this.featuredContent});
  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: _ContentHeaderMobile(featuredContent: featuredContent),
        desktop: _ContentHeaderDesktop(featuredContent: featuredContent));
  }
}

class _ContentHeaderMobile extends StatelessWidget {
  final Content featuredContent;

  _ContentHeaderMobile({this.featuredContent});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 500,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(featuredContent.imageUrl), fit: BoxFit.cover),
          ),
        ),
        Positioned(
          bottom: -1,
          left: 0,
          right: 0,
          child: Container(
            height: 500,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [Colors.black, Colors.transparent],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            )),
          ),
        ),
        Positioned(
          bottom: 110.0,
          child: SizedBox(
            width: 250.0,
            child: Image.asset(featuredContent.titleImageUrl),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 40.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              VerticalIconButton(
                icon: Icons.add,
                title: "List",
                onTap: () {},
              ),
              _PlayButton(),
              VerticalIconButton(
                icon: Icons.info_outline,
                title: "Info",
                onTap: () {},
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _ContentHeaderDesktop extends StatefulWidget {
  final Content featuredContent;

  _ContentHeaderDesktop({this.featuredContent});

  @override
  __ContentHeaderDesktopState createState() => __ContentHeaderDesktopState();
}

class __ContentHeaderDesktopState extends State<_ContentHeaderDesktop> {
  VideoPlayerController _controller;
  bool isMuted = true;

  @override
  void initState() {
    _controller = VideoPlayerController.network(widget.featuredContent.videoUrl)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      })
      ..setVolume(0)
      ..play();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _controller.value.isPlaying
              ? _controller.pause()
              : _controller.play();
        });
      },
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          AspectRatio(
            aspectRatio: _controller.value.initialized
                ? _controller.value.aspectRatio
                : 2.344,
            child: _controller.value.initialized
                ? VideoPlayer(_controller)
                : Image.asset(
                    widget.featuredContent.imageUrl,
                    fit: BoxFit.cover,
                  ),
          ),
          Positioned(
            bottom: -1.0,
            left: 0,
            right: 0,
            child: AspectRatio(
              aspectRatio: _controller.value.initialized
                  ? _controller.value.aspectRatio
                  : 2.344,
              child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  colors: [Colors.black, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                )),
              ),
            ),
          ),
          Positioned(
            left: 60.0,
            right: 60.0,
            bottom: 150.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 250.0,
                  child: Image.asset(widget.featuredContent.titleImageUrl),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Text(
                  widget.featuredContent.description,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18.0,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          offset: Offset(2.0, 4.0),
                          blurRadius: 6.0,
                        ),
                      ]),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    _PlayButton(),
                    const SizedBox(
                      width: 16.0,
                    ),
                    TextButton.icon(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.fromLTRB(25, 10, 30, 10),
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () {},
                      icon: const Icon(
                        Icons.info_outline,
                        size: 30,
                        color: Colors.black,
                      ),
                      label: const Text(
                        "More Info",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                            color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    if (_controller.value.initialized)
                      IconButton(
                        icon: Icon(
                          isMuted ? Icons.volume_off : Icons.volume_up,
                        ),
                        iconSize: 30.0,
                        color: Colors.white,
                        onPressed: () => setState(
                          () {
                            isMuted
                                ? _controller.setVolume(100)
                                : _controller.setVolume(0);
                            isMuted = _controller.value.volume == 0;
                          },
                        ),
                      ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _PlayButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        style: TextButton.styleFrom(
          padding: !Responsive.isDesktop(context)
              ? EdgeInsets.fromLTRB(15, 5, 20, 5)
              : EdgeInsets.fromLTRB(25, 10, 30, 10),
          backgroundColor: Colors.white,
        ),
        onPressed: () {},
        icon: const Icon(
          Icons.play_arrow,
          size: 30,
          color: Colors.black,
        ),
        label: Text(
          "Play",
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 16.0, color: Colors.black),
        ));
  }
}
