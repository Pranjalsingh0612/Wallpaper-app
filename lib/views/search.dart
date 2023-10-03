import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:wallpapers/widget/widget.dart';

import '../model/wallpaper_model.dart';

class Search extends StatefulWidget {
  final String searchQuery;
  Search({super.key, required this.searchQuery});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {

  TextEditingController searchController = TextEditingController();
  List wallpapers = <Wallpaper_Model>[];

  getSearchWallpapers(String query) async{
    var x = Uri.parse("https://api.pexels.com/v1/search?query=$query&per_page=80");
    var response = await http.get(x,
        headers: {'Authorization': 'ebgbpFmyiSVQT4GzIWuBACJnAICR0FCPHsDFvwqPVEqJ77R7HQRNQr3m'});
    print(response.body.toString());
    print(x);
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
    getSearchWallpapers(widget.searchQuery);
    searchController.text = widget.searchQuery;
    print(searchController.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: BrandName(
        ),
        elevation: 0,
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.blue[200],
                borderRadius: BorderRadius.circular(50),
              ),
              padding: EdgeInsets.symmetric(horizontal: 24),
              margin: EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Search"  ,
                          border: InputBorder.none
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      getSearchWallpapers(searchController.text);
                    },
                    child: Container(
                        child: Icon(Icons.search)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16,),
            Expanded(
                child: wallpapersList(wallpapers: wallpapers, context: context)
            ),
          ],
        ),
      )
    );
  }
}
