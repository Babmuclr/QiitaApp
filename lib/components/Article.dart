import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qiita_app/tags.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Article extends StatefulWidget {
  final String title, author, tags, url, id;
  final int likesCount;
  final bool isFavorite;

  const Article(
      {Key? key,
      required this.title,
      required this.tags,
      required this.author,
      required this.url,
      required this.id,
      required this.likesCount,
      this.isFavorite = false})
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

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    final Map<String, dynamic> _jsonData = {
      "title": widget.title,
      "tags": widget.tags,
      "likes_count": widget.likesCount,
      "author": widget.author,
      "url": widget.url,
    };
    String _jsonString = jsonEncode(_jsonData);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> _favoriteList = prefs.getStringList("favorite") ?? [];
    if (prefs.getString(widget.id) == null) {
      prefs.setString(widget.id, _jsonString);
      _favoriteList.add(widget.id);
      prefs.setStringList("favorite", _favoriteList);
    } else if (prefs.getString(widget.id) != null && widget.isFavorite) {
      prefs.remove(widget.id);
      _favoriteList.remove(widget.id);
      prefs.setStringList("favorite", _favoriteList);
    }
    if (widget.isFavorite) {
      return !isLiked;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.green,
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
                          Container(
                            width: 20,
                            child: FaIcon(
                              FontAwesomeIcons.userAlt,
                              size: 16,
                              color: Colors.green,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 180,
                            child: Text(
                              widget.author,
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
                          Container(
                            width: 20,
                            child: FaIcon(
                              FontAwesomeIcons.tags,
                              size: 16,
                              color: Colors.green,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 180,
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
                    onTap: onLikeButtonTapped,
                    padding: EdgeInsets.all(8.0),
                    size: 18,
                    circleColor: CircleColor(
                        start: Color(0xff00ddff), end: Color(0xff0099cc)),
                    bubblesColor: BubblesColor(
                      dotPrimaryColor: Color(0xff33b5e5),
                      dotSecondaryColor: Color(0xff0099cc),
                    ),
                    likeBuilder: (bool isLiked) {
                      return !widget.isFavorite
                          ? Icon(
                              Icons.favorite,
                              color: isLiked ? Colors.pinkAccent : Colors.grey,
                              size: 18,
                            )
                          : Icon(
                              FontAwesomeIcons.trash,
                              color: isLiked ? Colors.green : Colors.grey,
                              size: 18,
                            );
                    },
                    likeCount: widget.isFavorite ? null : widget.likesCount,
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
