import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class RemoteControlScreen extends StatefulWidget {
  @override
  State<RemoteControlScreen> createState() => _RemoteControlScreenState();
}

class _RemoteControlScreenState extends State<RemoteControlScreen> {
  static const String DEVICE_ID = "ESP32-BLE-Server";
  static const String SERVICE_UUID = "4822cbbf-e2df-4561-8e7b-5c509df34a4f";
  static const String CHARACTERISTIC_UUID =
      "a882c5c0-ea6b-4e86-9316-84953fe444a3";

  BleConState bleConState = BleConState.searching;
  FlutterBlue flutterBlue = FlutterBlue.instance;

  Future<void> trackConnectionState(BluetoothDevice device) async {
    while (true) {
      if (!(await flutterBlue.isOn)) {
        setState(() {
          bleConState = BleConState.off;
        });
        return;
      }
      if (await getConnectedDevice() == null) {
        setState(() {
          bleConState = BleConState.disconnected;
        });
        return;
      }

      await Future.delayed(Duration(seconds: 2));
    }
  }

  Future<void> disconnectDevice() async {
    BluetoothDevice? device = await getConnectedDevice();
    await device!.disconnect();
  }

  Future<BluetoothDevice?> getConnectedDevice() async {
    List<BluetoothDevice> connectedDevices = await flutterBlue.connectedDevices;
    for (BluetoothDevice device in connectedDevices) {
      if (device.name == DEVICE_ID) {
        return device;
      }
    }
    return null;
  }

  Future<void> initServiceCharacteristic(BluetoothDevice device) async {
    List<BluetoothService> services = await device.discoverServices();
    for (BluetoothService service in services) {
      if (service.uuid.toString() == SERVICE_UUID) {
        List<BluetoothCharacteristic> characteristics = service.characteristics;
        for (BluetoothCharacteristic characteristic in characteristics) {
          if (characteristic.uuid.toString() == CHARACTERISTIC_UUID) {
            remoteCharacteristic = characteristic;
          }
        }
      }
    }
    trackConnectionState(device);
    setState(() {
      bleConState = BleConState.connected;
    });
  }

  Future<void> waitForBleOn() async {
    bool offFlag = false;
    while (true) {
      if (await flutterBlue.isOn) {
        return;
      } else {
        if (!offFlag) {
          offFlag = true;
          setState(() {
            bleConState = BleConState.off;
          });
        }
      }
      await Future.delayed(Duration(seconds: 2));
    }
  }

  Future<void> initBLE() async {
    await waitForBleOn();
    BluetoothDevice? device = await getConnectedDevice();
    if (device != null) {
      initServiceCharacteristic(device);
    } else {
      setState(() {
        bleConState = BleConState.searching;
      });

      bool found = false;

      flutterBlue.startScan(timeout: Duration(seconds: 4)).then((value) {
        if (!found) {
          setState(() {
            bleConState = BleConState.notFound;
          });
        }
      });

      flutterBlue.scanResults.listen((List<ScanResult> results) async {
        for (ScanResult result in results) {
          if (result.device.name == DEVICE_ID) {
            connectBLEDevice(result.device);
            flutterBlue.stopScan();
            found = true;
            return;
          }
        }
      });
    }
  }

  late BluetoothCharacteristic remoteCharacteristic;

  void connectBLEDevice(BluetoothDevice device) async {
    setState(() {
      bleConState = BleConState.connecting;
    });
    await device.connect(autoConnect: false);
    initServiceCharacteristic(device);
  }

  @override
  void initState() {
    initBLE();
    super.initState();
  }

  @override
  void dispose() {
    if (bleConState == BleConState.connected) {
      disconnectDevice();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF92A65F),
        centerTitle: true,
        title: Text(
          "Remote Control",
          style: TextStyle(
            fontFamily: "NunitoSans",
            color: Color(0xFF323232),
            fontWeight: FontWeight.w700,
          ),
        ),
        iconTheme: IconThemeData(
          color: Color(0xFF323232),
        ),
      ),
      body: AnimatedContainer(
        duration: Duration(seconds: 2),
        curve: Curves.easeIn,
        child: Column(
          mainAxisAlignment: bleConState == BleConState.connected
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 25, 0, 80),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(horizontal: 7, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Status: ",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    () {
                      switch (bleConState) {
                        case BleConState.connected:
                          return "Connected";
                        case BleConState.connecting:
                          return "Connecting...";
                        case BleConState.searching:
                          return "Searching...";
                        case BleConState.off:
                          return "Bluetooth OFF";
                        case BleConState.notFound:
                          return "Device not found";
                        case BleConState.disconnected:
                          return "Disconnected";
                      }
                    }(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            bleConState == BleConState.connected
                ? Container(
                    child: Column(
                      children: [
                        ArrowButton(
                          icon: Icons.arrow_upward,
                          onPressedCallback: () async {
                            await remoteCharacteristic.write("f".codeUnits);
                            print("up");
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ArrowButton(
                              icon: Icons.arrow_back,
                              onPressedCallback: () async {
                                await remoteCharacteristic.write("l".codeUnits);

                                print("left");
                              },
                            ),
                            ArrowButton(
                              icon: Icons.arrow_forward,
                              onPressedCallback: () {
                                print("right");
                              },
                            ),
                          ],
                        ),
                        ArrowButton(
                          icon: Icons.arrow_downward,
                          onPressedCallback: () {
                            print("down");
                          },
                        ),
                      ],
                    ),
                  )
                : Container(),
            bleConState == BleConState.connected
                ? TextButton(
                    onPressed: () {
                      disconnectDevice();
                    },
                    child: Text(
                      "Disconnect",
                    ),
                  )
                : TextButton(
                    onPressed: () {
                      initBLE();
                    },
                    child: Text(
                      "Refresh",
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class ArrowButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressedCallback;
  bool _pressState = false;

  ArrowButton({required this.icon, required this.onPressedCallback});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails val) async {
        _pressState = true;
        do {
          onPressedCallback();
          await Future.delayed(Duration(seconds: 1));
        } while (_pressState == true);
      },
      onTapCancel: () {
        _pressState = false;
      },
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.all(50),
          child: Icon(icon),
        ),
      ),
    );
  }
}

enum BleConState {
  connected,
  connecting,
  searching,
  off,
  notFound,
  disconnected
}
