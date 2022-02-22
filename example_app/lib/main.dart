import 'package:flutter/material.dart';
import 'package:witt/witt.dart';

void main() {
  WService.enableLog = true;
  WService.addLazySingleton(() => HomePageController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: WRouter.navigatorKey,
      title: "Example App",
      home: const HomePage(),
    );
  }
}

class HomePageController {
  final counter = ValueNotifier(0);

  void incrementCounter() {
    counter.value++;
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  void _navigate() {
    WRouter.pushMaterialPage(
      builder: (context) => WServiceBuilder(
        serviceBuilder: (context) =>
            WService.addLazySingleton(() => HomePageController()),
        child: const HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final homePageC = WService.get<HomePageController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Example App"),
        actions: [
          IconButton(
            onPressed: _navigate,
            icon: const Icon(Icons.add_to_photos_outlined),
          )
        ],
      ),
      body: WListener(
        notifier: homePageC.counter,
        builder: (context) => Center(
          child: Text(homePageC.counter.value.toString()),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: homePageC.incrementCounter,
        child: const Icon(Icons.add),
      ),
    );
  }
}
