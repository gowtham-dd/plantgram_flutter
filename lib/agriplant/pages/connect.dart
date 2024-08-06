import 'package:flutter/material.dart';

class ConnectIOT extends StatefulWidget {
  const ConnectIOT({Key? key}) : super(key: key);

  @override
  State<ConnectIOT> createState() => _ConnectIOTState();
}

class _ConnectIOTState extends State<ConnectIOT> {
  bool _isToggleOn = false; // Manage the toggle state
  Map<String, bool> _connectedDevices = {}; // Manage connected devices
  TextEditingController _searchController =
      TextEditingController(); // Search controller
  bool _showSuccessAnimation = false; // To manage connection animation

  void _connectDevice(String deviceName) {
    setState(() {
      _connectedDevices[deviceName] = true;
      _showSuccessAnimation = true; // Show success animation
    });

    // Hide success animation after a delay
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _showSuccessAnimation = false;
      });
    });
  }

  void _disconnectDevice(String deviceName) {
    setState(() {
      _connectedDevices.remove(deviceName);
    });
  }

  void _showConnectionDialog(String deviceName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Connect to $deviceName'),
          content: Text('Are you sure you want to connect to this device?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _connectDevice(deviceName);
              },
              child: const Text('Connect'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Forget'),
            ),
          ],
        );
      },
    );
  }

  void _showDisconnectDialog(String deviceName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Disconnect $deviceName'),
          content:
              Text('Are you sure you want to disconnect from this device?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _disconnectDevice(deviceName);
              },
              child: const Text('Disconnect'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> devices = [
      'Ph detector',
      'Cattle tracker',
      'Asset tractor',
      'Driverless machine',
    ];

    // Filter devices based on search input
    final filteredDevices = devices
        .where((device) =>
            device.toLowerCase().contains(_searchController.text.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: const Color.fromARGB(255, 244, 245, 245),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Switch(
                      value: _isToggleOn,
                      onChanged: (value) {
                        setState(() {
                          _isToggleOn = value;
                        });
                      },
                    ),
                    if (!_isToggleOn)
                      const Expanded(
                        child: Text(
                          'Turn on the switch to connect to devices.',
                          style: TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                      ),
                  ],
                ),
              ),
              if (_isToggleOn) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search for devices',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    onChanged: (text) {
                      setState(() {}); // Update the UI on text change
                    },
                  ),
                ),
                const SizedBox(height: 16), // SizedBox to add space
                Expanded(
                  child: Column(
                    children: [
                      // Display connected devices
                      if (_connectedDevices.isNotEmpty)
                        Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              ..._connectedDevices.keys.map(
                                (device) => AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 16.0),
                                  color: Colors.lightGreen[50],
                                  child: ListTile(
                                    title: Text(device),
                                    trailing: TextButton(
                                      onPressed: () =>
                                          _showDisconnectDialog(device),
                                      child: const Text('Disconnect',
                                          style: TextStyle(color: Colors.red)),
                                    ),
                                  ),
                                ),
                              ),
                              const Divider(
                                  height: 10, thickness: 2), // Reduced space
                            ],
                          ),
                        ),
                      // Display non-connected devices
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            ...filteredDevices
                                .where((device) =>
                                    !_connectedDevices.containsKey(device))
                                .map(
                                  (device) => Card(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 16.0),
                                    child: ListTile(
                                      contentPadding:
                                          const EdgeInsets.all(16.0),
                                      title: Text(device),
                                      trailing: PopupMenuButton<String>(
                                        onSelected: (value) {
                                          if (value == 'Connect') {
                                            _showConnectionDialog(device);
                                          }
                                        },
                                        itemBuilder: (BuildContext context) {
                                          return ['Connect', 'Forget']
                                              .map((String choice) {
                                            return PopupMenuItem<String>(
                                              value: choice,
                                              child: Text(choice),
                                            );
                                          }).toList();
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
          if (_showSuccessAnimation)
            Positioned(
              left: 0,
              right: 0,
              top: MediaQuery.of(context).size.height / 2 -
                  100, // Adjust position as needed
              child: Center(
                child: AnimatedOpacity(
                  opacity: _showSuccessAnimation ? 1.0 : 0.0,
                  duration: const Duration(seconds: 1),
                  child: Container(
                    color: Colors.white.withOpacity(0.8),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle,
                            color: Colors.green, size: 100),
                        const SizedBox(height: 20),
                        Text('Connected Successfully',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
