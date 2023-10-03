import 'dart:convert';

class Wallpaper_Model{
  String? photographer;
  String? photographer_url;
  int? photographer_id;
  SrcModel? src;

  Wallpaper_Model({this.src, this.photographer, this.photographer_id, this.photographer_url});

  factory Wallpaper_Model.fromMap(Map jsonData){
    return Wallpaper_Model(
      src: SrcModel.fromMap(jsonData['src']),
      photographer: jsonData['photographer'],
      photographer_id: jsonData['photographer_id'],
      photographer_url: jsonData['photographer_url']
    );
  }
}

class SrcModel{
  String? portrait;
  String? original;
  String? small;

  SrcModel({this.portrait, this.original, this.small});

  factory SrcModel.fromMap(Map jsonData){
    return SrcModel(
      portrait: jsonData['portrait'],
      original: jsonData['original'],
      small: jsonData['small']
    );
  }
}