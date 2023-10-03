import 'dart:io';
//import 'dart:typed_data';
import 'dart:ui';
//import 'package:cached_network_image/cached_network_image.dart';
//import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
//import 'package:image_gallery_saver/image_gallery_saver.dart';
//import 'package:permission_handler/permission_handler.dart';
//import 'package:url_launcher/url_launcher.dart';

class ImageView extends StatefulWidget {

  final String imgUrl;
  ImageView({required this.imgUrl});

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: widget.imgUrl,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.network(widget.imgUrl, fit: BoxFit.cover,),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () async {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context)=> const Center(child: CircularProgressIndicator()),
                    );
                    await Permission.storage.request();
                    await GallerySaver.saveImage(widget.imgUrl);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Downloaded to Gallery!'),
                        backgroundColor: Colors.blue,
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width/2.2,
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white60),
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        stops: [
                          0.4,
                          0.2,
                          0.4,
                        ],
                        colors: [
                          Color(0xff1C1B1B),
                          Colors.black12,
                          Color(0xff1C1B1B),
                        ],
                      ),
                    ),
                    child: Container(
                      child: Column(
                        children: [
                          Text('Set Wallpaper', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                          Divider(color: Colors.black, indent: 25, thickness: 0.5, height: 2, endIndent: 25,),
                          Text('Image will be saved to gallery', style: TextStyle(color: Colors.white, fontSize: 14),),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                    child: Text('Cancel', style: TextStyle(color: Colors.white, fontSize: 18),)),
                SizedBox(height: 30,),
              ],
            ),
          )
        ],
      ),
    );
  }
}
