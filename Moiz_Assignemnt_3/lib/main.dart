import 'package:flutter/material.dart';

void main() {
  runApp(const SmartHomeApp());
}

class SmartHomeApp extends StatelessWidget {
  const SmartHomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Smart Home Dashboard",
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),

        cardTheme: const CardThemeData(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        ),
      ),

      home: const DashboardScreen(),
    );
  }
}

// ------------------------------- MODEL ------------------------------

class SmartDevice {
  String name;
  IconData icon;
  bool status;
  String room;

  SmartDevice({
    required this.name,
    required this.icon,
    required this.status,
    required this.room,
  });
}

// ------------------------------- DASHBOARD SCREEN ------------------------------

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<SmartDevice> devices = [
    SmartDevice(name: "Living Room Light", icon: Icons.lightbulb, status: false, room: "Living Room"),
    SmartDevice(name: "Bedroom Fan", icon: Icons.toys, status: true, room: "Bedroom"),
    SmartDevice(name: "Air Conditioner", icon: Icons.ac_unit, status: false, room: "Lounge"),
    SmartDevice(name: "Security Camera", icon: Icons.videocam, status: true, room: "Entrance"),
  ];

  // ------------------------------- ADD NEW DEVICE ------------------------------

  void _showAddDeviceDialog() {
    String deviceName = "";
    String room = "";
    IconData selectedIcon = Icons.lightbulb;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text("Add New Device"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) => deviceName = value,
                decoration: const InputDecoration(labelText: "Device Name"),
              ),
              TextField(
                onChanged: (value) => room = value,
                decoration: const InputDecoration(labelText: "Room Name"),
              ),
              const SizedBox(height: 10),
              DropdownButton<IconData>(
                value: selectedIcon,
                items: const [
                  DropdownMenuItem(value: Icons.lightbulb, child: Text("Light")),
                  DropdownMenuItem(value: Icons.toys, child: Text("Fan")),
                  DropdownMenuItem(value: Icons.ac_unit, child: Text("AC")),
                  DropdownMenuItem(value: Icons.videocam, child: Text("Camera")),
                ],
                onChanged: (value) {
                  setState(() => selectedIcon = value!);
                },
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  devices.add(SmartDevice(
                    name: deviceName,
                    icon: selectedIcon,
                    status: false,
                    room: room,
                  ));
                });
                Navigator.pop(context);
              },
              child: const Text("Add Device"),
            ),
          ],
        );
      },
    );
  }

  // ------------------------------- UI ------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Smart Home Dashboard", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: Colors.blue.shade200,
              child: const Icon(Icons.person),
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDeviceDialog,
        child: const Icon(Icons.add),
      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.only(top: 100, left: 15, right: 15),
        child: GridView.builder(
          itemCount: devices.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.9,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
          ),
          itemBuilder: (context, index) {
            return _buildDeviceCard(devices[index]);
          },
        ),
      ),
    );
  }

  // ------------------------------- DEVICE CARD ------------------------------

  Widget _buildDeviceCard(SmartDevice device) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => DeviceDetailsScreen(device: device)),
        ).then((_) => setState(() {}));
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: device.status ? Colors.blueAccent.withOpacity(0.7) : Colors.white.withOpacity(0.25),
          boxShadow: [
            BoxShadow(
              color: device.status ? Colors.blueAccent.withOpacity(0.4) : Colors.black45,
              blurRadius: 12,
              spreadRadius: 2,
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(device.icon, size: 40, color: Colors.white),
            const SizedBox(height: 10),
            Text(
              device.name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Switch(
              value: device.status,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() => device.status = value);
              },
            ),
            Text(
              device.status ? "Status: ON" : "Status: OFF",
              style: const TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------------------- DEVICE DETAILS SCREEN ------------------------------

class DeviceDetailsScreen extends StatefulWidget {
  final SmartDevice device;

  const DeviceDetailsScreen({super.key, required this.device});

  @override
  State<DeviceDetailsScreen> createState() => _DeviceDetailsScreenState();
}

class _DeviceDetailsScreenState extends State<DeviceDetailsScreen> {
  double controlValue = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.device.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(widget.device.icon, size: 120),
            const SizedBox(height: 20),
            Text(
              widget.device.status ? "Device is ON" : "Device is OFF",
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 40),
            Slider(
              value: controlValue,
              min: 0,
              max: 100,
              label: "${controlValue.toInt()}%",
              onChanged: (value) {
                setState(() => controlValue = value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
