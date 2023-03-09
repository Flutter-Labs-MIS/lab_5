import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/exam.dart';

class ExamCard extends StatelessWidget {
  final Exam exam;

  const ExamCard(this.exam, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              exam.name,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              "Date: ${exam.date} Time: ${exam.time}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(180, 180, 180, 1),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 15),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width - 84,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on,
                  ),
                  Flexible(
                    child: Text(
                      exam.location,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      var addresses = await locationFromAddress(exam.location);

                      var locationCoordinates = addresses.first;

                      await Geolocator.requestPermission();
                      Position locationGeo =
                          await Geolocator.getCurrentPosition(
                              desiredAccuracy: LocationAccuracy.low);

                      String url =
                          'https://www.google.com/maps/dir/?api=1&origin=${locationGeo.latitude},${locationGeo.longitude}&destination=${locationCoordinates.latitude},${locationCoordinates.longitude}';

                      launchUrl(Uri.parse(url));
                    },
                    child: const Icon(Icons.map_sharp),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
