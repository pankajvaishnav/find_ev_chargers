import 'package:flutter/material.dart';

class CustomAppbar extends StatefulWidget {
  final String title;
  final bool showLeading;
  const CustomAppbar({ Key? key, required this.title, required this.showLeading }) : super(key: key);

  @override
  State<CustomAppbar> createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Container(height: 40,
            decoration: const BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: SizedBox(width: double.infinity,
              child: Stack(alignment: Alignment.topCenter,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(color: Colors.black,
                    fontWeight: FontWeight.w800, 
                    fontSize: 16),
                  ),
                  if(widget.showLeading)
                    Positioned(left: 0,
                      child: InkWell(onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.arrow_back_ios))),
                ],
              ),
            ),
          )
        ],
      );
  }
}