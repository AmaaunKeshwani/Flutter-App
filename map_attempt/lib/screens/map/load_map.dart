//import 'dart:html';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:map_attempt/services/auth.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_arcgis/flutter_map_arcgis.dart';
import 'package:latlong/latlong.dart';
import 'package:map_attempt/screens/wrapper.dart';


class LoadMap extends StatefulWidget {

  final Position location;
  LoadMap({this.location});
  @override
  _LoadMapState createState() => _LoadMapState(location);
}

class _LoadMapState extends State<LoadMap> {
  final AuthService _auth = AuthService();

  var _map = 0;
  Position location;

  _LoadMapState(Position loc){
    this.location = loc;
  }

  @override
  Widget build(BuildContext context) {
    return _map == 0?
    Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: Text('Map Attempt'),
        backgroundColor: Colors.black,
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text(
              'Logout',
              style: TextStyle(
                color: Colors.teal,
              ),
            ),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(5.0),
        child: Column(
          children: [
            Flexible(
              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(location.latitude, location.longitude),
                  zoom: 11.0,
                  plugins: [EsriPlugin()],

                ),
                layers: [
                  TileLayerOptions(
                    urlTemplate:
                    'http://{s}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
                    subdomains: ['mt0', 'mt1', 'mt2', 'mt3'],
                    tileProvider: CachedNetworkTileProvider(),
                  ),
                  /*FeatureLayerOptions(
                    url: "https://services.arcgis.com/P3ePLMYs2RVChkJx/arcgis/rest/services/USA_Congressional_Districts/FeatureServer/0",
                    geometryType:"polygon",
                    onTap: (attributes, LatLng location) {
                      print(attributes);
                    },
                    render: (dynamic attributes){
                      // You can render by attribute
                      return PolygonOptions(
                          borderColor: Colors.black,
                          color: Colors.black12,
                          borderStrokeWidth: 2
                      );
                    },

                  ),*/
                  FeatureLayerOptions(
                    url: "https://services.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer",
                    geometryType:"point",
                    render:(dynamic attributes){
                      // You can render by attribute
                      return Marker(
                        width: 30.0,
                        height: 30.0,
                        builder: (ctx) => Icon(Icons.person_pin),
                      );
                    },
                    onTap: (attributes, LatLng location) {
                      print(attributes);
                    },
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
      //),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _map = 1;
          });
        },
        child: Icon(Icons.close),
      ),
    )
        :Wrapper();
  }
}


