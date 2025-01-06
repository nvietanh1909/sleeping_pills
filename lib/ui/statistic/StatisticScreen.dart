import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart'; // Thêm package này để vẽ biểu đồ

class StatisticScreen extends StatefulWidget {
  const StatisticScreen({super.key});

  @override
  _StatisticScreenState createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  final List<SleepData> _sleepDataWeek = [
    SleepData('Mon', 8),
    SleepData('Tue', 7.5),
    SleepData('Wed', 8.5),
    SleepData('Thu', 7),
    SleepData('Fri', 6.5),
    SleepData('Sat', 9),
    SleepData('Sun', 7.8),
  ];

  final List<SleepData> _sleepDataMonth = [
    SleepData('Week 1', 55),
    SleepData('Week 2', 60),
    SleepData('Week 3', 65),
    SleepData('Week 4', 55),
  ];

  bool isWeekView = true; // Điều khiển việc xem tuần hay tháng

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weekly Sleep Statistics'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isWeekView ? Colors.deepPurple : Colors.grey,
                  ),
                  child: const Text('Week View'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isWeekView = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: !isWeekView ? Colors.deepPurple : Colors.grey,
                  ),
                  child: const Text('Month View'),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Biểu đồ cột thống kê giấc ngủ hàng tuần hoặc tháng
            SizedBox(
              height: 300,
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                primaryYAxis: NumericAxis(
                    minimum: 0, maximum: 10, interval: 1, labelFormat: '{value} hrs',),
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
            const SizedBox(height: 20),

            // Tổng thời gian ngủ trong tuần hoặc tháng
            Text(
              'Total Sleep Time: ${_calculateTotalSleep()} hours',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),

            // Thời gian ngủ trung bình mỗi ngày
            Text(
              'Average Sleep Time: ${_calculateAverageSleep()} hours',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),

            // Sleep Quality section
            const Text(
              'Sleep Quality',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            // Placeholder for Sleep Quality (could be a chart or a value)
            const Text(
              'Quality Score: 85%',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),

            // Sleep Stages section
            const Text(
              'Sleep Stages',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            // Placeholder for Sleep Stages (could be a chart or details)
            const Text(
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
    final data = isWeekView ? _sleepDataWeek : _sleepDataMonth;
    return data.fold(0, (sum, item) => sum + item.sleepHours);
  }

  // Tính thời gian ngủ trung bình
  double _calculateAverageSleep() {
    final data = isWeekView ? _sleepDataWeek : _sleepDataMonth;
    return data.fold(0.0, (sum, item) => sum + item.sleepHours) / data.length;
  }
}

class SleepData {

  SleepData(this.day, this.sleepHours);
  final String day;
  final double sleepHours;
}
