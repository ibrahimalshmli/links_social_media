import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:links_social_media/network/endpoints.dart';

import '../../../../network/save_token.dart';
import '../login/login.dart';

class EditLocatino with ChangeNotifier {
  Future<void> editlocation(
    BuildContext context, {

    required int id,
    required double lat,
    required double long,
  }) async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      final userId = await getUserId();
      double latitude = position.latitude;
      double longitude = position.longitude;
      final token = await SharedPreferencesHelper.getToken();

      final response = await http.put(
        Uri.parse("${Endpoints.locatino}$userId"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'lat': latitude.toString(),
          'long': longitude.toString(),
        }),
      );

      if (response.statusCode == 200) {
        debugPrint('location updated successfully');
        notifyListeners();
      } else {
        throw Exception('Failed to update location: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error updating location: $e');
      rethrow;
    }
  }
}
