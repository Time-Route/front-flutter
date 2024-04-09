import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(const MapScreen());

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(37.6316684, 127.0774813);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    // 마커 정보 리스트
    final List<Map<String, dynamic>> markersData = [
      {
        'id': '미래관',
        'position': LatLng(37.629143, 127.081267),
        'title': '미래관',
        'snippet': '서울과기대 미래관',
      },
      {
        'id': '무궁관',
        'position': LatLng(37.630777, 127.080934),
        'title': '무궁관',
        'snippet': '서울과기대 무궁관',
      },
      {
        'id': '혜성관',
        'position': LatLng(37.631724, 127.081898),
        'title': '혜성관',
        'snippet': '서울과기대 혜성관',
      },
      {
        'id': '청운관',
        'position': LatLng(37.633323, 127.080757),
        'title': '청운관',
        'snippet': '서울과기대 청운관',
      },
      {
        'id': '창학관',
        'position': LatLng(37.632383, 127.079457),
        'title': '창학관',
        'snippet': '서울과기대 창학관',
      },
      {
        'id': '다산관',
        'position': LatLng(37.632427, 127.078041),
        'title': '다산관',
        'snippet': '서울과기대 다산관',
      },
      {
        'id': '어의관',
        'position': LatLng(37.635328, 127.076671),
        'title': '어의관',
        'snippet': '서울과기대 어의관',
      },
      {
        'id': '다빈치관',
        'position': LatLng(37.635115, 127.078510),
        'title': '다빈치관',
        'snippet': '서울과기대 다빈치관',
      },
      {
        'id': '창조관',
        'position': LatLng(37.634767, 127.079351),
        'title': '창조관',
        'snippet': '서울과기대 창조관',
      },
      {
        'id': '프론티어관',
        'position': LatLng(37.631387, 127.076023),
        'title': '프론티어관',
        'snippet': '서울과기대 프론티어관',
      },
      {
        'id': '하이테크관',
        'position': LatLng(37.632030, 127.076223),
        'title': '하이테크관',
        'snippet': '서울과기대 하이테크관',
      },
      {
        'id': '테크노큐브관',
        'position': LatLng(37.630195, 127.079873),
        'title': '테크노큐브관',
        'snippet': '서울과기대 테크노큐브관',
      },
      {
        'id': '아름관',
        'position': LatLng(37.629973, 127.080865),
        'title': '아름관',
        'snippet': '서울과기대 아름관',
      },
      {
        'id': '상상관',
        'position': LatLng(37.631, 127.0804),
        'title': '상상관',
        'snippet': '서울과기대 상상관',
      },
      {
        'id': '국제관',
        'position': LatLng(37.6349, 127.0775),
        'title': '국제관',
        'snippet': '서울과기대 국제관',
      },
    ];

    // 마커 객체 리스트
    final List<Marker> markers = markersData.map((data) {
      return Marker(
        markerId: MarkerId(data['id']),
        position: data['position'],
        infoWindow: InfoWindow(
          title: data['title'],
          snippet: data['snippet'],
        ),
      );
    }).toList();

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
          markers: Set<Marker>.from(markers), // 마커 추가
        ),
      ),
    );
  }
}