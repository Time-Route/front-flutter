import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'markers_data.dart';

class MapScreen extends StatefulWidget {
  MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(37.6316684, 127.0774813);

  final colors = [
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
    Colors.pink,
    Colors.teal,
    Colors.lime,
    Colors.amber,
    Colors.brown,
    Colors.grey,
  ];
  int colorIndex = 0;

  List<Map<String, String>> buildingInfo = [];

  // Node 데이터를 이용하여 마커 데이터 생성 함수
  List<Marker> getNodeMarkers(List<mNode> nodes) {
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
    // 강의실 마커 표시
    final List<Marker> markers = markerList.map((data) {
      return Marker(
        markerId: MarkerId(data['id']),
        position: data['position'],
        infoWindow: InfoWindow(
          title: data['title'],
          snippet: data['snippet'],
        ),
      );
    }).toList();

    final graph = Graph(nodes: nodes, edges: edges); // 그래프 초기화

    // 모든 간선 표시하기
    final List<Polyline> polylines = edges.map((edge) {
      return Polyline(
        polylineId: PolylineId('${edge.startNodeId}-${edge.endNodeId}'),
        color: Colors.blue,
        points: edge.coordinates,
        width: 8,
      );
    }).toList();

    final courses = Get.arguments;
    log(courses.toString());
    if (courses != null) {
      // 코스가 2개 이상일 경우 2개씩 묶어 다익스트라 알고리즘 적용
      if (courses.length >= 2) {
        for (int i = 0; i < courses.length - 1; i++) {
          String startNodeId = courses[i]['building']!;
          String endNodeId = courses[i + 1]['building']!;
          log('Start: $startNodeId, End: $endNodeId');
          List<Edge> shortestPath = dijkstra(graph, startNodeId, endNodeId);

          if (shortestPath.isNotEmpty) {
            print('Shortest path from $startNodeId to $endNodeId:');
            double totalDistance = 0;
            for (var edge in shortestPath) {
              print('${edge.startNodeId} to ${edge.endNodeId}: ${(edge.length * 1000).toInt()}m');
              totalDistance += edge.length;
            }
            // 평균 걷는 속도 설정 (시속 5km)
            double speed = 5.0;
            double distance = totalDistance * 1000;
            int travelTimeInMinutes = (distance / (speed * 1000 / 60)).toInt();

            print('총 거리: ${(totalDistance * 1000).toInt()}m');
            print('예상시간: ${travelTimeInMinutes}분');

            // buildingInfo 리스트에 추가
            buildingInfo.add({
              'name': startNodeId + ' -> ' + endNodeId,
              'distance': '${(totalDistance * 1000).toInt()}m',
              'time': '${travelTimeInMinutes}분'
            });
          } else {
            print('No path found from $startNodeId to $endNodeId');
          }

          // 모든 간선 표시하기
          final List<Polyline> route = shortestPath.map((edge) {
            log('Edge: ${edge.startNodeId} to ${edge.endNodeId}');
            if (edge.endNodeId == startNodeId) colorIndex++;
            return Polyline(
              polylineId: PolylineId('${edge.startNodeId}-${edge.endNodeId}'),
              color: colors[colorIndex % colors.length],
              points: edge.coordinates,
              width: 8,
            );
          }).toList();
          polylines.addAll(route);
        }
      }
    }

    // 노드 마커 데이터 생성
    final List<Marker> nodeMarkers = getNodeMarkers(nodes);

    return MaterialApp(
      title: '지도',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 16.5,
              ),
              markers: Set<Marker>.from(nodeMarkers),
              polylines: Set<Polyline>.from(polylines),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: MediaQuery.of(context).size.width / 3,
                height: double.infinity,
                color: Colors.white,
                child: ListView.builder(
                  itemCount: buildingInfo.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(buildingInfo[index]['name']!),
                      subtitle: Text('거리: ${buildingInfo[index]['distance']!}, 예상 시간: ${buildingInfo[index]['time']!}'),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
}
