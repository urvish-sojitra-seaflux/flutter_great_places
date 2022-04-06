import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import './src/locations.dart' as locations;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    setState(() {
      _markers.clear();
      for (final office in googleOffices.offices) {
        final marker = Marker(
          markerId: MarkerId(office.name),
          position: LatLng(office.lat, office.lng),
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.address,
          ),
        );
        _markers[office.name] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(children: [
          GoogleMap(
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            buildingsEnabled: true,
            mapType: MapType.normal,
            zoomControlsEnabled: true,
            onMapCreated: _onMapCreated,
            initialCameraPosition: const CameraPosition(
              target: LatLng(0, 0),
              zoom: 4,
            ),
            markers: _markers.values.toSet(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 50),
            child: TextFormField(
              keyboardAppearance: Brightness.dark,
              autofillHints: const [
                "Delhi",
                "Delhi",
                "Delhi",
                "Delhi",
                "Delhi",
                "Delhi",
                "Delhi",
                "Delhi",
                "Delhi",
                "Delhi",
                "Delhi",
              ],
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                focusColor: Colors.black12,
                focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    borderSide: BorderSide(color: Colors.green),
                    gapPadding: 5.0),
                suffixIcon: const Icon(Icons.search),
                constraints: BoxConstraints.loose(const Size(500, 100)),
                prefixIcon: const Icon(Icons.location_on),
                prefixIconColor: Colors.black,
                contentPadding: const EdgeInsets.all(10),
                hintStyle: const TextStyle(fontSize: 12),
                hintText: "Search your Destination",
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    borderSide: BorderSide(color: Colors.black12),
                    gapPadding: 5.0),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
