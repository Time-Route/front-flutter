import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'markers_data.dart';

void main() => runApp(const MapScreen());

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(37.6316684, 127.0774813);

  // Node 데이터를 이용하여 마커 데이터 생성 함수
  List<Marker> getNodeMarkers(List<Node> nodes) {
    return nodes.map((node) {
      return Marker(
        markerId: MarkerId(node.id), // 노드의 ID를 마커 ID로 사용합니다.
        position: node.position,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure), // 마커 아이콘 설정 (예시로 파란색 아이콘)
        infoWindow: InfoWindow(
          title: node.id, // 노드의 ID를 마커 제목으로 사용합니다.
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final List<Marker> markers = getMarkersData().map((data) {
      return Marker(
        markerId: MarkerId(data['id']),
        position: data['position'],
        infoWindow: InfoWindow(
          title: data['title'],
          snippet: data['snippet'],
        ),
      );
    }).toList();

    final List<Edge> edges = getEdgesData(); // 엣지 정보

    final List<Polyline> polylines = edges.map((edge) {
      return Polyline(
        polylineId: PolylineId('${edge.startNodeId}-${edge.endNodeId}'),
        color: Colors.blue,
        points: edge.coordinates,
        width: 8,
      );
    }).toList();

    // 노드 마커 데이터 생성
    final List<Marker> nodeMarkers = getNodeMarkers(nodes);

    return MaterialApp(
      title: '지도',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 16.5,
          ),
          markers: Set<Marker>.from(markers + nodeMarkers),
          polylines: Set<Polyline>.from(polylines),
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
}