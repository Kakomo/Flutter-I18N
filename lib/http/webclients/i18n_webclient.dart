import 'dart:convert';

import 'package:bytebank/http/webclient.dart';
import 'package:http/http.dart';

const LANGUAGE_EN = 'https://gist.githubusercontent.com/Kakomo/9c2093a60f0bf153024b7a90a1fd1dfe/raw/2072ae3d5232b2e7df28f5f508fc4a183eaddfa3/language_en.json';

class I18NWebClient{

  Future<Map<String,dynamic>> findAll() async{
    final Response response = await client.get(LANGUAGE_EN);
    final Map<String,dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson;
  }
}