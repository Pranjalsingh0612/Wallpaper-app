import 'package:flutter/material.dart';
import 'package:wallpapers/views/image_view.dart';

Widget BrandName(){
  return Container(
    child: RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        children: const <TextSpan>[
          TextSpan(text: 'Wallpaper', style: TextStyle(color: Colors.black)),
          TextSpan(text: 'App', style: TextStyle(color: Colors.blue)),
        ],
      ),
    )
  );
}

Widget wallpapersList({List? wallpapers, context}){
  return SingleChildScrollView(
    child: Container(
      //color: Colors.black,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: GridView.count(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
        children: wallpapers!.map((wallpaper){
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => ImageView(
                  imgUrl: wallpaper.src.portrait,
                )
              ));
            },
            child: Hero(
              tag: wallpaper.src.portrait,
              child: GridTile(
                  child: Container(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(wallpaper.src.portrait, fit: BoxFit.cover,)),
                  )
              ),
            ),
          );
        }).toList(),
      ),
    ),
  );
}