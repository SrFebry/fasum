import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatelessWidget {
  final String documentId;
  final String imageUrl;
  final String description;
  final Timestamp timestamp;
  final String userEmail;
  final double latitude;
  final double longitude;

  const DetailScreen({
    required this.documentId,
    required this.imageUrl,
    required this.description,
    required this.timestamp,
    required this.userEmail,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              height: 200,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Deskripsi: $description',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Timestamp: ${DateFormat.yMMMd().add_jm().format(timestamp.toDate())}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Posted by: $userEmail',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _openMaps(latitude, longitude);
                        },
                        child: Text('Open Maps'),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          'Latitude: $latitude, Longitude: $longitude',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void _openMaps(double latitude, double longitude) async {
    String mapsUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    try {
      if (await canLaunch(mapsUrl)) {
        await launch(mapsUrl);
      } else {
        throw 'Could not launch $mapsUrl';
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
