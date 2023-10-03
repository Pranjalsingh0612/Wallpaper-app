import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/wallpaper_model.dart';
import '../widget/widget.dart';

class Categorie extends StatefulWidget {

  final String? categorieSearch;
  Categorie({this.categorieSearch});

  @override
  State<Categorie> createState() => _CategorieState();
}

class _CategorieState extends State<Categorie> {

  List wallpapers = <Wallpaper_Model>[];

  getSearchWallpapers(String? query) async{
    var response = await http.get(Uri.parse("https://api.pexels.com/v1/search?query=$query&per_page=80"),
        headers: {'Authorization': 'ebgbpFmyiSVQT4GzIWuBACJnAICR0FCPHsDFvwqPVEqJ77R7HQRNQr3m'});
    print(response.body.toString());
    Map jsonData = jsonDecode(response.body) as Map;
    jsonData["photos"]?.forEach((element){
      Wallpaper_Model wallpaper_model = Wallpaper_Model();
      wallpaper_model = Wallpaper_Model.fromMap(element);
      wallpapers.add(wallpaper_model);
    });

    setState(() {});
  }

  @override
  void initState() {
    getSearchWallpapers(widget.categorieSearch);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: BrandName(),
        elevation: 0,
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 16,
            ),
            Expanded(
                child: wallpapersList(wallpapers: wallpapers, context: context)),
          ],
        ),
      ),
    );
  }
}
