import 'dart:async';
import 'dart:convert';
import 'dayOfJob.dart';
import 'package:http/http.dart' as http;

const url = 'https://jsonplaceholder.typicode.com/posts/1';

Future<DayOfJob> fetchDayOfJob(DateTime day) async {
  final response = await http.get('${url}/posts/${day}');
  if (tratamento(response)) {
    return DayOfJob.fromJson(json.decode(response.body));
  }
}

Future<bool> saveDayOfJob(DayOfJob d) async {
  final response = await http.post('${url}/save', body: d);
  return tratamento(response);
}

 bool tratamento(http.Response r) {
  if (r.statusCode == 200) {
    return true;
  } else {
    throw Exception('Failed to load post');
  }
  return false;
}
