import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WebsiteCard extends StatefulWidget {
  final String text;
  final String url;
  final String image;
  const WebsiteCard({
    super.key,
    required this.text,
    required this.url,
    required this.image,
  });

  @override
  State<WebsiteCard> createState() => _WebsiteCardState();
}

class _WebsiteCardState extends State<WebsiteCard> {
  launchURL(String url) async {
    if (await (canLaunchUrl(Uri.parse(url)))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await launchURL(widget.url);
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Icon(
              //   widget.icon ?? Icons.link,
              //   color: Colors.white,
              // ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  "assets/images/${widget.image}",
                  height: 50,
                  width: 50,
                ),
              ),
              Text(
                widget.text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
