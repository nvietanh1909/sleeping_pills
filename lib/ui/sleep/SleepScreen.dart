import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

void main() {
  runApp(const SleepApp());
}

class SleepApp extends StatelessWidget {
  const SleepApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const SleepScreen(),
    );
  }
}

class SleepScreen extends StatefulWidget {
  const SleepScreen({super.key});

  @override
  _SleepScreenState createState() => _SleepScreenState();
}

class _SleepScreenState extends State<SleepScreen> {
  double _bedtime = 22; // 10:00 PM
  double _alarm = 6;   // 6:00 AM

  /// Định dạng thời gian từ giá trị double thành chuỗi HH:MM AM/PM
  String formatTime(double value) {
    var hours = value.floor();
    final minutes = ((value - hours) * 60).round();
    final suffix = hours >= 12 ? 'PM' : 'AM';
    hours = hours % 12 == 0 ? 12 : hours % 12;
    return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')} $suffix";
  }

  /// Widget tái sử dụng cho hiển thị Bedtime và Alarm
  Widget buildTimeCard(String label, String time, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          time,
          style: TextStyle(
            fontSize: 16,
            color: color,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 13, 5, 59),
              Color.fromARGB(255, 17, 17, 39),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Tiêu đề
              const Text(
                'Set Your Sleep Schedule',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),

              // Biểu đồ Sleep Schedule
              SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                    minimum: 0,
                    maximum: 24,
                    interval: 6,
                    startAngle: 270,
                    endAngle: 270,
                    radiusFactor: 0.9,
                    axisLineStyle: AxisLineStyle(
                      thickness: 30,
                      color: Colors.grey[800],
                    ),
                    showLabels: true,
                    showTicks: true,
                    axisLabelStyle: GaugeTextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                    ),
                    minorTicksPerInterval: 4, // Thêm 4 vạch nhỏ giữa mỗi vạch lớn
                    majorTickStyle: MajorTickStyle(
                      length: 15,
                      thickness: 2,
                      color: Colors.white,
                    ),
                    minorTickStyle: MinorTickStyle(
                      length: 10,
                      thickness: 1.5,
                      color: Colors.white70,
                    ),
                    ranges: <GaugeRange>[
                      GaugeRange(
                        startValue: _bedtime,
                        endValue: _alarm,
                        gradient: const SweepGradient(
                          colors: [Colors.deepPurple, Color.fromARGB(255, 22, 34, 146)],
                          stops: [0.0, 1.0],
                        ),
                        startWidth: 30,
                        endWidth: 30,
                      ),
                    ],
                    pointers: <GaugePointer>[
                      // Pointer cho Bedtime (Vòng tròn biểu tượng cho Bedtime)
                      MarkerPointer(
                        value: _bedtime,
                        markerType: MarkerType.circle,
                        color: Colors.lightBlueAccent, // Màu cho vòng tròn biểu tượng Bedtime
                        markerHeight: 28,
                        markerWidth: 28,
                        onValueChanged: (value) {
                          setState(() {
                            _bedtime = value;
                          });
                        },
                        enableDragging: true,
                      ),
                      // Pointer cho Alarm (Vòng tròn biểu tượng cho Alarm)
                      MarkerPointer(
                        value: _alarm,
                        markerType: MarkerType.circle,
                        color: Colors.redAccent, // Màu cho vòng tròn biểu tượng Alarm
                        markerHeight: 28,
                        markerWidth: 28,
                        onValueChanged: (value) {
                          setState(() {
                            _alarm = value;
                          });
                        },
                        enableDragging: true,
                      ),
                    ],
                    onAxisTapped: (value) {
                      setState(() {
                        if ((value - _bedtime).abs() < (value - _alarm).abs()) {
                          _bedtime = value; // Cập nhật giá trị nếu gần _bedtime
                        } else {
                          _alarm = value; // Cập nhật giá trị nếu gần _alarm
                        }
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Hiển thị Bedtime và Alarm
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildTimeCard(
                    'Bedtime',
                    formatTime(_bedtime),
                    Colors.lightBlueAccent,
                  ),
                  buildTimeCard(
                    'Alarm',
                    formatTime(_alarm),
                    Colors.redAccent,
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Nút Sleep Now
              ElevatedButton(
                onPressed: () {
                  final sleepDuration = (24 + _alarm - _bedtime) % 24;
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.grey[900],
                      title: const Text(
                        'Good Night!',
                        style: TextStyle(color: Colors.white),
                      ),
                      content: Text(
                        'You will sleep for ${sleepDuration.toStringAsFixed(1)} hours.',
                        style: const TextStyle(color: Colors.white70),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            'OK',
                            style: TextStyle(color: Colors.lightBlueAccent),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Sleep Now',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
