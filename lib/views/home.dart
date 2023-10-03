import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wallpapers/data/data.dart';
import 'package:wallpapers/model/wallpaper_model.dart';
import 'package:wallpapers/views/category.dart';
import 'package:wallpapers/views/image_view.dart';
import 'package:wallpapers/widget/widget.dart';
import 'package:wallpapers/model/categorie_model.dart';
import 'package:http/http.dart' as http;
import 'package:wallpapers/views/search.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List categories = <CategorieModel>[];
  List wallpapers = <Wallpaper_Model>[];
  //late String searchController;
  TextEditingController searchController = TextEditingController();

  getTrendingWallpapers() async{
    var response = await http.get(Uri.parse("https://api.pexels.com/v1/curated?per_page=80"),
    headers: {'Authorization': 'ebgbpFmyiSVQT4GzIWuBACJnAICR0FCPHsDFvwqPVEqJ77R7HQRNQr3m'});
    //print(response.body.toString());
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
    getTrendingWallpapers();
    categories = getCategories();
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
                      onChanged: (String value) => searchController.text=value,
                      decoration: InputDecoration(
                        hintText: "Search"  ,
                          border: InputBorder.none
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Search(
                        searchQuery: searchController.text,
                      )));
                    },
                    child: Container(
                        child: Icon(Icons.search)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 26),
            Container(
              height: 80,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: categories.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index){
                    return CategoriesTile(
                      title: categories[index].categorieName,
                      imgUrl: categories[index].imgUrl,
                    );
                  }),
            ),
            Expanded(
                child: wallpapersList(wallpapers: wallpapers, context: context)),
          ],
        ),
      ),
    );
  }
}

class CategoriesTile extends StatelessWidget {

  String imgUrl, title;
  CategoriesTile({super.key, required this.imgUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => Categorie(
            categorieSearch: title.toLowerCase(),
          )
        ));
      },
      child: Container(
        margin: EdgeInsets.only(right: 4),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
                child: Opacity(
                  opacity: 0.9,
                  child: (Image.network(
                      imgUrl,
                      height: 70,
                      width: 120,
                      fit: BoxFit.cover,
                    )
                  ),
                )
            ),
            Divider(height: 20, color: Colors.blue, thickness: 2, indent: 10,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black12,
              ),
              height: 70, width: 120,
              alignment: Alignment.center,
              child: Text(title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),),
            )
          ],
        ),
      ),
    );
  }
}

