import 'package:efoot/secondscreen.dart';
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:window_manager/window_manager.dart';
 // Import stop_watch_timer

void main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
// Must add this line.
await windowManager.ensureInitialized();

// Use it only after calling `hiddenWindowAtLaunch`
windowManager.waitUntilReadyToShow().then((_) async {
// Hide window title bar
await windowManager.setFullScreen(true);
await windowManager.center();
await windowManager.show();
await windowManager.setSkipTaskbar(false);
});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  double _shadow = 0.0;
  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countDown,
    presetMillisecond:
        StopWatchTimer.getMilliSecFromMinute(1), // millisecond => minute.
  ); // Create instance.

  final displayTime = StopWatchTimer.getDisplayTime(30000); // 00:00:03.00

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
      _shadow++;
      _stopWatchTimer.onStartTimer();
    });
  }

  void _restartCounter() {
    setState(() {
      _counter = 0;
      _shadow = 0.0;
      _stopWatchTimer.onResetTimer();
    });
  }

  void onEnd() {
    _restartCounter();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        backgroundColor: const Color(0xFF111731),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                  flex: 1,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Container(
                          margin: const EdgeInsets.all(30),
                          alignment: Alignment.centerLeft,
                          child: Text(""),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          margin: const EdgeInsets.all(30),
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: const Icon(
                              Icons.refresh,
                              size: 40,
                            ),
                            alignment: Alignment.topCenter,
                            color: Colors.white,
                            onPressed: _restartCounter,
                          ),
                        ),
                      )
                    ],
                  )),
              Flexible(
                flex: 3,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: const Color(0xFF111731),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white38,
                            blurRadius: 25.0, // soften the shadow
                            spreadRadius: _shadow,
                            //extend the shadow
                          ),
                        ],
                        border: Border.all(color: Colors.white38, width: 1.0)),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      width: 500,
                      child: Text(
                        '$_counter',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 60,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                  flex: 3,
                  child: Container(
                    margin: const EdgeInsets.all(100),
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0.0)),
                          minimumSize: Size(200, 60),
                        ),
                        onPressed: _incrementCounter,
                        child: const Text(
                          "Go",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        )),
                  )),
              Flexible(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      icon: const Icon(
                        Icons.navigate_next,
                        size: 50.0,
                      ),
                      color: Colors.white,
                      onPressed: () {
                        // Navigator.push(
                        // context,
                        //MaterialPageRoute(
                        //builder: (context) => const SecondRoute()),
                        //);
                      },
                    ),
                  ))
            ],
          ),
        ));
  }
}
