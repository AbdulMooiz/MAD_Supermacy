import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Platform Channel Lab',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Arial',
        brightness: Brightness.light,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 10,
            shadowColor: Colors.black26,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 28),
          ),
        ),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final ButtonStyle btnStyle = ElevatedButton.styleFrom(
    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 28),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    textStyle: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
    elevation: 8,
    backgroundColor: Colors.white,
    foregroundColor: Colors.black87,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1e3c72), Color(0xFF2a5298)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedOpacity(
                    duration: Duration(seconds: 2),
                    opacity: 1,
                    child: Column(
                      children: [
                        Text(
                          'Developed by',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white70,
                            letterSpacing: 1.2,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Abdul Moiz Khan',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.white,
                            letterSpacing: 1.4,
                            shadows: [
                              Shadow(
                                  color: Colors.black45,
                                  blurRadius: 8,
                                  offset: Offset(1, 2)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),

                  // Buttons
                  _buildMenuButton(context, "Device Info", DeviceInfoPage()),
                  _buildMenuButton(context, "Gesture Detector", GestureDetectorPage()),
                  _buildMenuButton(context, "Draggable & DragTarget", DraggableDemoPage()),
                  _buildMenuButton(context, "Dismissible Widget", DismissiblePage()),
                  _buildMenuButton(context, "Tags / Chips", ChipsPage()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(context, title, page) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: AnimatedScale(
        duration: Duration(milliseconds: 300),
        scale: 1,
        child: ElevatedButton(
          style: btnStyle,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => page));
          },
          child: Text(title),
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////////
// DEVICE INFO PAGE (Improved UI only)
//////////////////////////////////////////////////////

class DeviceInfoPage extends StatefulWidget {
  @override
  _DeviceInfoPageState createState() => _DeviceInfoPageState();
}

class _DeviceInfoPageState extends State<DeviceInfoPage> {
  static const platform = MethodChannel('device/info');
  String battery = "Unknown";
  String model = "Unknown";

  Future<void> getBattery() async {
    try {
      final int result = await platform.invokeMethod("getBatteryLevel");
      setState(() => battery = "$result%");
    } catch (e) {
      setState(() => battery = "Error getting battery");
    }
  }

  Future<void> getModel() async {
    try {
      final String result = await platform.invokeMethod("getDeviceModel");
      setState(() => model = result);
    } catch (e) {
      setState(() => model = "Error getting model");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _styledAppBar("Device Info"),
      body: _gradientBackground(
        child: _glassCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Device Information",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.blue.shade700,
                ),
              ),
              Divider(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _actionBtn("Get Battery", getBattery, Colors.blue),
                  _actionBtn("Get Model", getModel, Colors.green),
                ],
              ),
              SizedBox(height: 20),
              Text("Battery: $battery", style: TextStyle(fontSize: 19)),
              Text("Model: $model", style: TextStyle(fontSize: 19)),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _styledAppBar(title) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF3a7bd5), Color(0xFF00d2ff)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }

  Widget _gradientBackground({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFdfe9f3), Color(0xFFffffff)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Center(child: child),
    );
  }

  Widget _glassCard({required Widget child}) {
    return Container(
      padding: EdgeInsets.all(28),
      margin: EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.black12, blurRadius: 15, spreadRadius: 4)
        ],
      ),
      child: child,
    );
  }

  Widget _actionBtn(String title, Function() onPressed, Color color) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF42A5F5),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      ),
      onPressed: onPressed,
      child: Text(title),
    );
  }
}

//////////////////////////////////////////////////////
// OTHER PAGES – Only UI polished, widgets same
//////////////////////////////////////////////////////

class GestureDetectorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar("Gesture Detector"),
      body: _gradient(
        child: Center(
          child: GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Tapped!")),
              );
            },
            onLongPress: () {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Long Press!")));
            },
            child: _fancyBox(),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _appBar(String title) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFfc4a1a), Color(0xFFf7b733)],
          ),
        ),
      ),
    );
  }

  Widget _gradient({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFfffcdc), Color(0xFFffe9e3)],
        ),
      ),
      child: child,
    );
  }

  Widget _fancyBox() {
    return Container(
      height: 90,
      width: 240,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: [Colors.orange.shade200, Colors.pink.shade100],
        ),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 12, offset: Offset(0, 4))
        ],
      ),
      child: Center(
        child: Text(
          "Tap or Long Press",
          style: TextStyle(fontSize: 19),
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////////
// DRAGGABLE / DRAG TARGET – only improved visuals
//////////////////////////////////////////////////////

class DraggableDemoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _styledAppBar(),
      body: _background(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Draggable<String>(
              data: "Dropped!",
              feedback: _dragBall(Colors.blue.shade300),
              child: _dragBall(Colors.blue.shade600),
            ),
            DragTarget<String>(
              builder: (_, __, ___) => _dropBox(),
              onAccept: (value) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("You dropped: $value")),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _styledAppBar() {
    return AppBar(
      title: Text('Draggable & DragTarget'),
      centerTitle: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient:
          LinearGradient(colors: [Color(0xFF43cea2), Color(0xFF185a9d)]),
        ),
      ),
    );
  }

  Widget _background({required child}) {
    return Container(
      decoration: BoxDecoration(
        gradient:
        LinearGradient(colors: [Color(0xFFd1c9ff), Color(0xFFb1ffe0)]),
      ),
      child: Center(child: child),
    );
  }

  Widget _dragBall(Color color) {
    return CircleAvatar(
      radius: 32,
      backgroundColor: color,
      child: Icon(Icons.drag_handle, size: 28, color: Colors.white),
    );
  }

  Widget _dropBox() {
    return Container(
      height: 110,
      width: 130,
      decoration: BoxDecoration(
        color: Colors.green.shade200,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 10),
        ],
      ),
      child: Center(
        child: Text("Drop Here", style: TextStyle(fontSize: 18)),
      ),
    );
  }
}

//////////////////////////////////////////////////////
// DISMISSIBLE PAGE (UI improved only)
//////////////////////////////////////////////////////

class DismissiblePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _styledBar(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFffd1d9), Color(0xFFffe7c7)],
          ),
        ),
        child: Center(
          child: Dismissible(
            key: UniqueKey(),
            background: Container(
              color: Colors.red.shade400,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 20),
              child: Icon(Icons.delete, color: Colors.white, size: 40),
            ),
            child: _dismissCard(),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _styledBar() {
    return AppBar(
      title: Text('Dismissible Widget'),
      centerTitle: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient:
          LinearGradient(colors: [Color(0xFFff512f), Color(0xFFdd2476)]),
        ),
      ),
    );
  }

  Widget _dismissCard() {
    return Container(
      padding: EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.pink.shade100,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 10),
        ],
      ),
      child: Text("Swipe to Dismiss", style: TextStyle(fontSize: 19)),
    );
  }
}

//////////////////////////////////////////////////////
// CHIPS PAGE (enhanced visuals)
//////////////////////////////////////////////////////

class ChipsPage extends StatelessWidget {
  final List<String> tags = ['Flutter', 'Platform Channels', 'Android', 'Kotlin'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _chipBar(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFe0ffe4), Color(0xFFfafffa)],
          ),
        ),
        child: Center(
          child: Wrap(
            spacing: 12,
            children: tags
                .map((tag) => Chip(
              label: Text(tag),
              backgroundColor: Colors.white,
              elevation: 4,
              shadowColor: Colors.black26,
              labelStyle: TextStyle(fontSize: 16),
            ))
                .toList(),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _chipBar() {
    return AppBar(
      title: Text('Tags / Chips'),
      centerTitle: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient:
          LinearGradient(colors: [Color(0xFF11998e), Color(0xFF38ef7d)]),
        ),
      ),
    );
  }
}
