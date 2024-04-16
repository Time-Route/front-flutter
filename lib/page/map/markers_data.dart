import 'package:google_maps_flutter/google_maps_flutter.dart';

//건물 마커 목록
List<Map<String, dynamic>> getMarkersData() {
  return [
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
      'position': LatLng(37.6301, 127.0799),
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
}

// 노드 클래스
class Node {
  final String id; // 노드 식별자
  final LatLng position; // 노드의 좌표

  Node({required this.id, required this.position});
}

// 간선 클래스
class Edge {
  final String id; // 간선 식별자
  final String startNodeId; // 시작 노드의 식별자
  final String endNodeId; // 끝 노드의 식별자
  final List<LatLng> coordinates; // 시작 노드부터 끝 노드까지의 좌표들

  Edge({required this.id, required this.startNodeId, required this.endNodeId, required this.coordinates});
}

// // 노드와 간선을 담는 데이터 구조
// class Graph {
//   final List<Node> nodes; // 노드 리스트
//   final List<Edge> edges; // 간선 리스트
//
//   Graph({required this.nodes, required this.edges});
// }

final List<Node> nodes = [
  Node(id: '어의관', position: LatLng(37.635339, 127.076869)),
  Node(id: '국제관', position: LatLng(37.634740, 127.077435)),
  Node(id: '정류장', position: LatLng(37.6341, 127.0779)),
  Node(id: '창학관1', position: LatLng(37.6327, 127.0788)),
  Node(id: "창학관2", position: LatLng(37.632089, 127.079380)),
  Node(id: '하이테크관', position: LatLng(37.631937, 127.077084)),
  Node(id: "향학로 끝", position: LatLng(37.633157, 127.077515)),
  Node(id: "프론티어관", position: LatLng(37.631301, 127.076853)),
  Node(id: "창학관 사거리", position: LatLng(37.631598, 127.079166)),
  Node(id: "계단", position: LatLng(37.631314, 127.079607)),
  Node(id: "혜성관", position: LatLng(37.631430, 127081931)),
  Node(id: "상상관", position: LatLng(37.631078, 127.079600)),
  Node(id: "테크노큐브", position: LatLng(37.630138, 127.079445)),
  Node(id: "미래관", position: LatLng(37.629455, 127.081018)),
  Node(id: "상상무궁사이", position: LatLng(37.631160, 127.080534)),
  Node(id: "무궁관", position: LatLng(37.631122, 127.080942)),
  Node(id: "아름관", position: LatLng(37.630108, 127.080280)),
  Node(id: "창학관", position: LatLng(37.633243, 127.080692)),
  // 나머지 노드 데이터 추가
];

// 간선 데이터 전달 함수
List<Edge> getEdgesData() {
  return [
    Edge(
      id: '어의관-국제관',
      startNodeId: '어의관',
      endNodeId: '국제관',
      coordinates: [
        LatLng(37.635339, 127.076869),
        LatLng(37.635164, 127.076899),
        LatLng(37.634915, 127.076816),
        LatLng(37.634740, 127.077435),
      ],
    ),
    Edge(
      id: '국제관-다빈치관',
      startNodeId: '국제관',
      endNodeId: '다빈치관',
      coordinates: [
        LatLng(37.634740, 127.077435),
        LatLng(37.634559, 127.078100),
      ],
    ),
    Edge(
      id: '다빈치관-창조관',
      startNodeId: '다빈치관',
      endNodeId: '창조관',
      coordinates: [
        LatLng(37.634559, 127.078100),
        LatLng(37.634387, 127.078875),
        LatLng(37.634474, 127.079266),
      ],
    ),
    Edge(
      id: '다빈치관-정류장',
      startNodeId: '다빈치관',
      endNodeId: '정류장',
      coordinates: [
        LatLng(37.634559, 127.078100),
        LatLng(37.6341, 127.077916),
      ],
    ),
    Edge(
      id: '정류장-향학로 끝',
      startNodeId: '정류장',
      endNodeId: '향학로 끝',
      coordinates: [
        LatLng(37.6341, 127.077916),
        LatLng(37.633157, 127.077515),
      ],
    ),
    Edge(
      id: '정류장-창학관',
      startNodeId: '정류장',
      endNodeId: '창학관1',
      coordinates: [
        LatLng(37.6341, 127.077916),
        LatLng(37.634, 127.07816),
        LatLng(37.6336, 127.07885),
        LatLng(37.6335, 127.07895),
        LatLng(37.6334, 127.079),
        LatLng(37.63325, 127.079),
        LatLng(37.6327, 127.0788),
      ],
    ),
    Edge(
      id: '향학로 끝-하이테크관',
      startNodeId: '향학로 끝',
      endNodeId: '하이테크관',
      coordinates: [
        LatLng(37.631937, 127.077084),
        LatLng(37.633157, 127.077515),
      ],
    ),
    Edge(
      id: '하이테크관-프론티어관',
      startNodeId: '하이테크관',
      endNodeId: '프론티어관',
      coordinates: [
        LatLng(37.631937, 127.077084),
        LatLng(37.631301, 127.076853),
      ],
    ),
    Edge(
      id: '창학관1-창학관 사거리',
      startNodeId: '창학관1',
      endNodeId: '창학관 사거리',
      coordinates: [
        LatLng(37.6327, 127.0788),
        LatLng(37.631812, 127.078466),
        LatLng(37.631598, 127.079166),
      ],
    ),
    Edge(
      id: '창학관 사거리-계단',
      startNodeId: '창학관 사거리',
      endNodeId: '계단',
      coordinates: [
        LatLng(37.631598, 127.079166),
        LatLng(37.631325, 127.079658),
      ],
    ),
    Edge(
      id: '계단-혜성관',
      startNodeId: '계단',
      endNodeId: '혜성관',
      coordinates: [
        LatLng(37.631325, 127.079658),
        LatLng(37.631430, 127.081931),
      ],
    ),
    Edge(
      id: '계단-상상관',
      startNodeId: '계단',
      endNodeId: '상상관',
      coordinates: [
        LatLng(37.631325, 127.079658),
        LatLng(37.631078, 127.079600),
      ],
    ),
    Edge(
      id: '상상관-테크노큐브동',
      startNodeId: '상상관',
      endNodeId: '테크노큐브동',
      coordinates: [
        LatLng(37.631078, 127.079600),
        LatLng(37.630138, 127.079445),
      ],
    ),
    Edge(
      id: '테크노큐브동-미래관',
      startNodeId: '테크노큐브동',
      endNodeId: '미래관',
      coordinates: [
        LatLng(37.630138, 127.079445),
        LatLng(37.629716, 127.079381),
        LatLng(37.629455, 127.081018),
      ],
    ),
    Edge(
      id: '상상관-상상무궁사이',
      startNodeId: '상상관',
      endNodeId: '상상무궁사이',
      coordinates: [
        LatLng(37.631078, 127.079600),
        LatLng(37.631160, 127.080534),
      ],
    ),
    Edge(
      id: '상상무궁사이-무궁관',
      startNodeId: '상상무궁사이',
      endNodeId: '무궁관',
      coordinates: [
        LatLng(37.631160, 127.080534),
        LatLng(37.631122, 127.080942),
      ],
    ),
    Edge(
      id: '상상무궁사이-아름관',
      startNodeId: '상상무궁사이',
      endNodeId: '아름관',
      coordinates: [
        LatLng(37.631160, 127.080534),
        LatLng(37.630108, 127.080280),
      ],
    ),
    Edge(
      id: '창학관 사거리-창학관2',
      startNodeId: '창학관 사거리',
      endNodeId: '창학관2',
      coordinates: [
        LatLng(37.631598, 127.079166),
        LatLng(37.632089, 127.079380),
      ],
    ),
    Edge(
      id: '창학관2-청운관',
      startNodeId: '창학관2',
      endNodeId: '청운관',
      coordinates: [
        LatLng(37.632089, 127.079380),
        LatLng(37.631981, 127.079916),
        LatLng(37.632515, 127.080423),
        LatLng(37.633243, 127.080692),
      ],
    ),
  ];
}

// 노드와 간선을 담은 데이터 구조 생성
// final Graph graph = Graph(nodes: nodes, edges: edges);