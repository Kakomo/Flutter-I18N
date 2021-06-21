import 'dart:convert';

import 'package:bytebank/http/webclient.dart';
import 'package:http/http.dart';

const LANGUAGE_EN = 'https://gist.githubusercontent.com/Kakomo/9c2093a60f0bf153024b7a90a1fd1dfe/raw/2072ae3d5232b2e7df28f5f508fc4a183eaddfa3/language_en.json';
const LANGUAGE_PT = 'https://gist.githubusercontent.com/Kakomo/4e153c2bb3efd6af20f771b4f9a5c6bc/raw/7568b8f1c45d7240dec74e11429522e1a5c8b6f6/language_pt.json';

class I18NWebClient{
  final String _key;
  I18NWebClient(this._key);

  getLanguage(){
    if(_key == 'LANGUAGE_PT'){
      return LANGUAGE_PT;
    }
    else{
      return LANGUAGE_EN;
    }
  }

  Future<Map<String,dynamic>> findAll() async{
    final Response response = await client.get(getLanguage());
    final Map<String,dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson;
  }
}