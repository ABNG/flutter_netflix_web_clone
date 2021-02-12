import 'package:flutter/material.dart';
import 'package:flutter_netflix_web_clone/data/data.dart';
import 'package:flutter_netflix_web_clone/widgets/content_header.dart';
import 'package:flutter_netflix_web_clone/widgets/content_list.dart';
import 'package:flutter_netflix_web_clone/widgets/custom_app_bar.dart';
import 'package:flutter_netflix_web_clone/widgets/previews.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _scrollOffset = 0.0;
  ScrollController controller;
  @override
  void initState() {
    print("initState");
    controller = ScrollController()
      ..addListener(() {
        setState(() {
          _scrollOffset = controller.offset;
        });
      });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 50.0),
        child: CustomAppBar(
          scrollOffset: _scrollOffset,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.cast),
        onPressed: () {},
        backgroundColor: Colors.grey[850],
      ),

      //if you have gridview inside listview use customscrollview
      //because neverscrollablephysical() is performance intensive
      //because it loads all the data.
      //without neverscrollablephysical() data loads only for that part
      //visible on screen
      body: CustomScrollView(
        controller: controller,
        slivers: [
          SliverToBoxAdapter(
            child: ContentHeader(
              featuredContent: sintelContent,
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(top: 20.0),
            sliver: SliverToBoxAdapter(
              child: Previews(
                key: PageStorageKey("previews"),
                title: "Previews",
                contentList: previews,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: ContentList(
              key: PageStorageKey("myList"),
              title: "My List",
              contentList: myList,
            ),
          ),
          SliverToBoxAdapter(
            child: ContentList(
              key: PageStorageKey("Originals"),
              title: "Netflix Originals",
              contentList: originals,
              isOriginals: true,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 20.0),
            sliver: SliverToBoxAdapter(
              child: ContentList(
                key: PageStorageKey("trending"),
                title: "Trending",
                contentList: trending,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
