import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Model/world_state_record.dart';
import 'Utilities/app_url.dart';


class StatesServices {

  Future<WorldStateRecord> fetchWorldStatesRecord () async{
    final response = await http.get(Uri.parse(AppUrl.worldStateApi));

    if(response.statusCode == 200){
      var data = jsonDecode(response.body.toString());
      return WorldStateRecord.fromJson(data);
    }else{
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> countryListApi () async{
    var data;
    final response = await http.get(Uri.parse(AppUrl.countriesList));

    if(response.statusCode == 200){
      data = jsonDecode(response.body.toString());
      return data;
    }else{
      throw Exception('Error');
    }
  }

}