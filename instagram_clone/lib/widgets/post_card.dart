import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:intl/intl.dart';

class PostCard extends StatelessWidget {
  final snap;
  const PostCard({super.key, required this.snap});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: mobileBackgroundColor,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 16,
            ).copyWith(right: 0),
            child: Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(snap['profImage']),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text(
                          snap['username'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: ListView(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                          ),
                          shrinkWrap: true,
                          children: [
                            'Delete',
                          ]
                              .map(
                                (e) => InkWell(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 16),
                                    child: Text(e),
                                  ),
                                  onTap: () {},
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.more_vert,
                  ),
                ),
              ],
            ),
            // IMAGE SECTION
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
            child: Image.network(
              snap['postUrl'],
              fit: BoxFit.cover,
            ),
          ),
          // Like comment etc section
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.comment_outlined,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.send,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.bookmark_border),
                  ),
                ),
              ),
            ],
          ),
          // Description and number of comments
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultTextStyle(
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                child: Text(
                  '${snap['likes'].length} likes',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 8),
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(color: primaryColor),
                    children: [
                      TextSpan(
                        text: snap['username'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: ' ${snap['description']}',
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: const Text(
                    'View all 200 comments',
                    style: TextStyle(
                      fontSize: 16,
                      color: secondaryColor,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  DateFormat.yMMMd().format(
                    snap['datePublished'].toDate(),
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                    color: secondaryColor,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
