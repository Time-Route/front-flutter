import 'package:flutter/material.dart';

List<String> week = [
  '월',
  '화',
  '수',
  '목',
  '금'
];
const double kTableWidth = 700;
const double kTimeColumnWidth = 30;
const int kColumnLength = 22;
const double kFirstColumnHeight = 20;
const double kBoxSize = 70;

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  List<Positioned> _item = [];

  // 왼쪽 사이드
  String _selectedTitle = week[0]; // Default title
  int _startNumber = 0;
  int _endNumber = 0;

  // Function to handle title selection
  void _onTitleSelected(String? title) {
    setState(() {
      _selectedTitle = title!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildSelection(),
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(16),
                width: kTableWidth,
                height: kColumnLength / 2 * kBoxSize + kColumnLength,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Stack(children: [
                  Row(
                    children: [
                      buildTimeColumn(),
                      ...buildDayColumn(0),
                      ...buildDayColumn(1),
                      ...buildDayColumn(2),
                      ...buildDayColumn(3),
                      ...buildDayColumn(4),
                    ],
                  ),
                  ..._item
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSelection() {
    return Container(
      margin: EdgeInsets.all(16),
      width: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '시작 교시',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                _startNumber = int.tryParse(value) ?? 0;
              });
            },
          ),
          SizedBox(height: 10),
          Text(
            '종료 교시',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                _endNumber = int.tryParse(value) ?? 0;
              });
            },
          ),
          SizedBox(height: 10),
          Text(
            '제목:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          DropdownButton<String>(
            value: _selectedTitle,
            onChanged: _onTitleSelected,
            items: week.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          TextButton(
            onPressed: () {
              addItem(
                dayOfWeek: week.indexOf(_selectedTitle),
                startPeriod: _startNumber - 1,
                endPeriod: _endNumber - 1,
              );
            },
            child: Text('추가하기'),
          )
        ],
      ),
    );
  }

  Container buildTimeColumn() {
    return Container(
      width: kTimeColumnWidth,
      child: Column(
        children: [
          SizedBox(
            height: kFirstColumnHeight,
          ),
          ...List.generate(
            kColumnLength,
            (index) {
              if (index % 2 == 0) {
                return const Divider(
                  color: Colors.grey,
                  height: 0,
                );
              }
              return SizedBox(
                height: kBoxSize,
                child: Center(child: Text('${index ~/ 2 + 9}')),
              );
            },
          ),
        ],
      ),
    );
  }

  List<Widget> buildDayColumn(int index) {
    return [
      const VerticalDivider(
        color: Colors.grey,
        width: 0,
      ),
      Expanded(
        flex: 4,
        child: Column(
          children: [
            SizedBox(
              height: 20,
              child: Text(
                '${week[index]}',
              ),
            ),
            ...List.generate(
              kColumnLength,
              (index) {
                if (index % 2 == 0) {
                  return const Divider(
                    color: Colors.grey,
                    height: 0,
                  );
                }
                return SizedBox(
                  height: kBoxSize,
                  child: Container(),
                );
              },
            ),
          ],
        ),
      ),
    ];
  }

  void addItem({required int dayOfWeek, required int startPeriod, required int endPeriod}) {
    setState(() {
      _item.add(
        Positioned(
          top: kFirstColumnHeight + kBoxSize * startPeriod,
          left: kTimeColumnWidth + (kTableWidth - kTimeColumnWidth) / 5 * dayOfWeek,
          height: kBoxSize * (endPeriod - startPeriod + 1),
          width: (kTableWidth - kTimeColumnWidth) / 5,
          child: Container(
            color: Colors.green,
          ),
        ),
      );
    });
  }
}
