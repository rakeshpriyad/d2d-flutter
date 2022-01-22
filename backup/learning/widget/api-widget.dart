import 'dart:async';
import 'dart:convert';

import 'package:d2d_flutter/dto/emp.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as HTTP;
import 'package:http/http.dart';

class ApiWidget {//extends InheritedWidget {
  static final String _BASE_URL = "http://dummy.restapiexample.com/api/v1";
  static const _TIMEOUT = Duration(seconds: 10);

  /*ApiWidget({
    required Key key,
    required Widget child,
  })  : assert(child != null),
        super(key: key, child: child);

  static ApiWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ApiWidget>();
  }
*/
  /*@override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }*/

  Future<List<Employee>> loadAndParseEmployees() async {
    var url = '${_BASE_URL}/employees';
    List<Employee> listEmps = [];
    final response = await HTTP.get(Uri.parse(url)).timeout(_TIMEOUT);
    if (response.statusCode == 200) {
      final parsed =jsonDecode(response.body) as Map<String, dynamic>;
      for (var i = 0; i < parsed["data"].length; i++) {
        Map<String, dynamic> map = parsed["data"][i];
        listEmps.add(Employee.fromJson(map));
        // _loadAds.add(parsed["ads"][i]);
      }
      //final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      /*var list =
          parsed.map<Employee>((json) => Employee.fromJson(json)).toList();*/
      return listEmps;
    }

    return badStatusCode(response);
  }

  Future<Employee> loadEmployee(String id) async {
    var url = '${_BASE_URL}/employee/${id}';
    final response = await HTTP.get(Uri.parse(url)).timeout(_TIMEOUT);
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      return Employee.fromJson(parsed);
    }
    return badStatusCode(response);
  }

  Future<dynamic> saveEmployee(Employee employee) async {
    bool isUpdate = employee.id.isNotEmpty;
    final uri = _BASE_URL + (isUpdate ? '/update/${employee.id}' : '/create');
// profile image does not seem to update
    final response = isUpdate
        ? await HTTP
            .put(Uri.parse(uri), body: json.encode(employee))
            .timeout(_TIMEOUT)
        : await HTTP
            .post(Uri.parse(uri), body: json.encode(employee))
            .timeout(_TIMEOUT);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
// If that response was not OK, throw an error.
      badStatusCode(response);
    }
  }

  Future<dynamic> deleteEmployee(String id) async {
    final uri = '${_BASE_URL}/delete/${id}';
    final response = await HTTP.delete(Uri.parse(uri)).timeout(_TIMEOUT);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
// If that response was not OK, throw an error.
      badStatusCode(response);
    }
  }

  badStatusCode(Response response) {
    debugPrint("Bad status code ${response.statusCode} returned from server.");
    debugPrint("Response body ${response.body} returned from server.");
    throw Exception(
        'Bad status code ${response.statusCode} returned from server.');
  }
}
