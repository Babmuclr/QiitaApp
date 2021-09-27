import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qiita_app/tags.dart';

class Article extends StatefulWidget {
  final String title, id, tags, userURL;
  final int likesCount;

  const Article(
      {Key? key,
      required this.title,
      required this.tags,
      required this.id,
      required this.userURL,
      required this.likesCount})
      : super(key: key);
  @override
  _ArticleState createState() => _ArticleState();
}

class _ArticleState extends State<Article> {
  Image getImage(tags) {
    List _tagList = tags.split(', ');
    String assetName =
        _tagList.firstWhere((e) => allTags.contains(e), orElse: () => "Qiita");
    return Image.asset(
      "assets/img/" + assetName + ".png",
      fit: BoxFit.contain,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0), //or 15.0
              child: Container(
                height: 84.0,
                width: 84.0,
                child: getImage(widget.tags),
              ),
            ),
          ),
          Expanded(
              child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 75,
                      width: 210,
                      child: Text(
                        widget.title,
                        style: TextStyle(
                          fontFamily: 'Helvetica',
                          fontSize: 16,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 4.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(widget.userURL),
                            radius: 9,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 160,
                            child: Text(
                              "@ " + widget.id,
                              style: TextStyle(
                                fontFamily: 'Helvetica',
                                fontSize: 12,
                                color: Colors.black87,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 210,
                      child: Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.tags,
                            size: 16,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 160,
                            child: Text(
                              widget.tags,
                              style: TextStyle(
                                fontFamily: 'Helvetica',
                                fontSize: 12,
                                color: Colors.black87,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: LikeButton(
                    padding: EdgeInsets.all(8.0),
                    size: 18,
                    circleColor: CircleColor(
                        start: Color(0xff00ddff), end: Color(0xff0099cc)),
                    bubblesColor: BubblesColor(
                      dotPrimaryColor: Color(0xff33b5e5),
                      dotSecondaryColor: Color(0xff0099cc),
                    ),
                    likeBuilder: (bool isLiked) {
                      return Icon(
                        Icons.favorite,
                        color: isLiked ? Colors.pinkAccent : Colors.grey,
                        size: 18,
                      );
                    },
                    likeCount: widget.likesCount,
                  ),
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
