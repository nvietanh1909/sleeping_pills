import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart'; // Thêm package này để vẽ biểu đồ

class StatisticScreen extends StatefulWidget {
  @override
  _StatisticScreenState createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  List<SleepData> _sleepDataWeek = [
    SleepData('Mon', 8.0),
    SleepData('Tue', 7.5),
    SleepData('Wed', 8.5),
    SleepData('Thu', 7.0),
    SleepData('Fri', 6.5),
    SleepData('Sat', 9.0),
    SleepData('Sun', 7.8),
  ];

  List<SleepData> _sleepDataMonth = [
    SleepData('Week 1', 55.0),
    SleepData('Week 2', 60.0),
    SleepData('Week 3', 65.0),
    SleepData('Week 4', 55.0),
  ];

  bool isWeekView = true; // Điều khiển việc xem tuần hay tháng

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weekly Sleep Statistics'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dòng lựa chọn tuần hoặc tháng
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isWeekView = true;
                    });
                  },
                  child: Text("Week View"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isWeekView ? Colors.deepPurple : Colors.grey,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isWeekView = false;
                    });
                  },
                  child: Text("Month View"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: !isWeekView ? Colors.deepPurple : Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Biểu đồ cột thống kê giấc ngủ hàng tuần hoặc tháng
            Container(
              height: 300,
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                primaryYAxis: NumericAxis(
                    minimum: 0, maximum: 10, interval: 1, labelFormat: '{value} hrs'),
                series: <CartesianSeries>[
                  ColumnSeries<SleepData, String>(
                    dataSource: isWeekView ? _sleepDataWeek : _sleepDataMonth,
                    xValueMapper: (SleepData data, _) => data.day,
                    yValueMapper: (SleepData data, _) => data.sleepHours,
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Tổng thời gian ngủ trong tuần hoặc tháng
            Text(
              'Total Sleep Time: ${_calculateTotalSleep()} hours',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),

            // Thời gian ngủ trung bình mỗi ngày
            Text(
              'Average Sleep Time: ${_calculateAverageSleep()} hours',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 30),

            // Sleep Quality section
            Text(
              'Sleep Quality',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            // Placeholder for Sleep Quality (could be a chart or a value)
            Text(
              'Quality Score: 85%',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 30),

            // Sleep Stages section
            Text(
              'Sleep Stages',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            // Placeholder for Sleep Stages (could be a chart or details)
            Text(
              'Deep Sleep: 60%\nLight Sleep: 30%\nREM: 10%',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Tính tổng thời gian ngủ
  double _calculateTotalSleep() {
    List<SleepData> data = isWeekView ? _sleepDataWeek : _sleepDataMonth;
    return data.fold(0.0, (sum, item) => sum + item.sleepHours);
  }

  // Tính thời gian ngủ trung bình
  double _calculateAverageSleep() {
    List<SleepData> data = isWeekView ? _sleepDataWeek : _sleepDataMonth;
    return (data.fold(0.0, (sum, item) => sum + item.sleepHours) / data.length);
  }
}

class SleepData {
  final String day;
  final double sleepHours;

  SleepData(this.day, this.sleepHours);
}
