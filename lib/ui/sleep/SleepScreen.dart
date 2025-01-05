import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

void main() {
  runApp(SleepApp());
}

class SleepApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: SleepScreen(),
    );
  }
}

class SleepScreen extends StatefulWidget {
  @override
  _SleepScreenState createState() => _SleepScreenState();
}

class _SleepScreenState extends State<SleepScreen> {
  double _bedtime = 22; // 10:00 PM
  double _alarm = 6;   // 6:00 AM

  /// Định dạng thời gian từ giá trị double thành chuỗi HH:MM AM/PM
  String formatTime(double value) {
    int hours = value.floor();
    int minutes = ((value - hours) * 60).round();
    String suffix = hours >= 12 ? "PM" : "AM";
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
        SizedBox(height: 8),
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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 19, 7, 83), 
              Color.fromARGB(255, 17, 17, 39)// Xanh đen
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Tiêu đề
              Text(
                'Set Your Sleep Schedule',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),

              // Biểu đồ Sleep Schedule
              SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                    minimum: 0,
                    maximum: 24,
                    interval: 6,
                    startAngle: 270,
                    endAngle: 270,
                    showLabels: true,
                    showTicks: true,
                    axisLabelStyle: GaugeTextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                    ranges: <GaugeRange>[
                      GaugeRange(
                        startValue: _bedtime,
                        endValue: _alarm,
                        color: Colors.blueAccent.withOpacity(0.8),
                      )
                    ],
                    pointers: <GaugePointer>[
                      // Pointer cho Bedtime
                      MarkerPointer(
                        value: _bedtime,
                        markerType: MarkerType.circle,
                        color: Colors.lightBlueAccent,
                        onValueChanged: (value) {
                          setState(() {
                            _bedtime = value;
                          });
                        },
                        enableDragging: true,
                      ),
                      // Pointer cho Alarm
                      MarkerPointer(
                        value: _alarm,
                        markerType: MarkerType.circle,
                        color: Colors.redAccent,
                        onValueChanged: (value) {
                          setState(() {
                            _alarm = value;
                          });
                        },
                        enableDragging: true,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),

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
              SizedBox(height: 30),

              // Nút Sleep Now
              ElevatedButton(
                onPressed: () {
                  final sleepDuration = (24 + _alarm - _bedtime) % 24;
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.grey[900],
                      title: Text(
                        'Good Night!',
                        style: TextStyle(color: Colors.white),
                      ),
                      content: Text(
                        'You will sleep for ${sleepDuration.toStringAsFixed(1)} hours.',
                        style: TextStyle(color: Colors.white70),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'OK',
                            style: TextStyle(color: Colors.lightBlueAccent),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                child: Text(
                  'Sleep Now',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
