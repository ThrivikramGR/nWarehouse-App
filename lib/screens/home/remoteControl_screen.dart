import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    try {
      await device!.disconnect();
    } catch (e) {
      return;
    }
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
    HapticFeedback.heavyImpact();
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
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
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
      body: Column(
        mainAxisAlignment: bleConState == BleConState.connected
            ? MainAxisAlignment.start
            : MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 25, 0, 80),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.grey[400]!,
                width: 1,
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 7, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Status: ",
                  style: TextStyle(
                    fontFamily: "NunitoSans",
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
                    fontFamily: "NunitoSans",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          bleConState == BleConState.connected
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Container(
                    child: Column(
                      children: [
                        NeuArrowButton(
                          icon: Icons.arrow_upward,
                          onPressedCallback: () async {
                            await remoteCharacteristic.write("f".codeUnits);
                          },
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            NeuArrowButton(
                              icon: Icons.arrow_back,
                              onPressedCallback: () async {
                                await remoteCharacteristic.write("l".codeUnits);
                              },
                            ),
                            NeuArrowButton(
                              icon: Icons.arrow_forward,
                              onPressedCallback: () async {
                                await remoteCharacteristic.write("r".codeUnits);
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        NeuArrowButton(
                          icon: Icons.arrow_downward,
                          onPressedCallback: () async {
                            await remoteCharacteristic.write("b".codeUnits);
                          },
                        ),
                      ],
                    ),
                  ),
                )
              : Container(),
          SizedBox(
            height: 80,
          ),
          bleConState == BleConState.connected
              ? NeuTextButton(
                  child: Text(
                    "Disconnect",
                    style: TextStyle(
                      fontFamily: "NunitoSans",
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      fontSize: 18,
                    ),
                  ),
                  onPressed: () {
                    disconnectDevice();

                    HapticFeedback.heavyImpact();
                  },
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                )
              : NeuTextButton(
                  child: Text(
                    "Refresh",
                    style: TextStyle(
                      fontFamily: "NunitoSans",
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontSize: 18,
                    ),
                  ),
                  onPressed: () {
                    initBLE();
                    HapticFeedback.heavyImpact();
                  },
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                ),
        ],
      ),
    );
  }
}

class NeuArrowButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressedCallback;

  NeuArrowButton({required this.icon, required this.onPressedCallback});

  @override
  State<NeuArrowButton> createState() => _NeuArrowButtonState();
}

class _NeuArrowButtonState extends State<NeuArrowButton> {
  bool pressState = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails val) async {
        HapticFeedback.lightImpact();

        setState(() {
          pressState = true;
        });

        do {
          widget.onPressedCallback();

          await Future.delayed(Duration(seconds: 1));
        } while (pressState == true);
      },
      onTapCancel: () {
        HapticFeedback.lightImpact();
        setState(() {
          pressState = false;
        });
      },
      onTapUp: (TapUpDetails val) {
        HapticFeedback.lightImpact();
        setState(() {
          pressState = false;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 175),
        curve: Curves.decelerate,
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: pressState ? Colors.grey[400]! : Colors.grey[300]!,
            width: 0.5,
          ),
          boxShadow: pressState
              ? []
              : [
                  BoxShadow(
                    color: Colors.grey[500]!,
                    offset: Offset(4, 4),
                    spreadRadius: 1,
                    blurRadius: 10,
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-4, -4),
                    spreadRadius: 1,
                    blurRadius: 10,
                  ),
                ],
        ),
        child: Icon(
          widget.icon,
          size: pressState ? 24 : 25,
        ),
      ),
    );
  }
}

class NeuTextButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry? padding;
  NeuTextButton({required this.child, required this.onPressed, this.padding});

  @override
  State<NeuTextButton> createState() => _NeuTextButtonState();
}

class _NeuTextButtonState extends State<NeuTextButton> {
  bool pressState = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails val) async {
        setState(() {
          pressState = true;
        });
        widget.onPressed();
      },
      onTapCancel: () {
        setState(() {
          pressState = false;
        });
      },
      onTapUp: (TapUpDetails val) {
        setState(() {
          pressState = false;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        curve: Curves.linear,
        padding: widget.padding,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: pressState ? Colors.grey[400]! : Colors.grey[300]!,
            width: 0.5,
          ),
          boxShadow: pressState
              ? []
              : [
                  BoxShadow(
                    color: Colors.grey[400]!,
                    offset: Offset(4, 4),
                    spreadRadius: 1,
                    blurRadius: 10,
                  ),
                  BoxShadow(
                    color: Colors.white70,
                    offset: Offset(-4, -4),
                    spreadRadius: 1,
                    blurRadius: 10,
                  ),
                ],
        ),
        child: widget.child,
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
