import 'package:flutter/material.dart';
import 'package:flutter_netflix_web_clone/models/content_model.dart';

class Previews extends StatelessWidget {
  final String title;
  final List<Content> contentList;

  Previews({Key key, this.title, this.contentList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          height: 165,
          child: ListView.builder(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
              itemCount: contentList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final Content content = contentList[index];
                return GestureDetector(
                  onTap: () {},
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16.0),
                        height: 130,
                        width: 130,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: content.color, width: 4.0),
                          image: DecorationImage(
                              image: AssetImage(content.imageUrl),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16.0),
                        height: 130,
                        width: 130,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: content.color, width: 4.0),
                          gradient: LinearGradient(
                            colors: [
                              Colors.black87,
                              Colors.black45,
                              Colors.transparent
                            ],
                            stops: [0.0, 0.25, 0.1],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),
                      Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: SizedBox(
                            height: 60.0,
                            child: Image.asset(content.titleImageUrl),
                          ))
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }
}
