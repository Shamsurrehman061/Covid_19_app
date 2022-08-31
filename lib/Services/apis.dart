import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Models/all_world_data.dart';
import 'ApiUrls/api_url.dart';

class Api{
  Future<AllWorldData> getAllWorldData() async{
    final response = await http.get(Uri.parse(ApiUrl.allWord));
    if(response.statusCode == 200)
      {
        var data = jsonDecode(response.body);
        return AllWorldData.fromJson(data);
      }
    else
      {
        throw Exception('Error');
      }
  }

  Future<List<dynamic>> getCountryData() async{
    var data;
    final response = await http.get(Uri.parse(ApiUrl.countries));
    if(response.statusCode == 200)
    {
      data = jsonDecode(response.body);
      return data;
    }
    else
    {
      throw Exception('Error');
    }
  }

}