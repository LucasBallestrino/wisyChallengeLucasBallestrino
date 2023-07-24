import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wisy_challenge/app/screens/home/providers.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wisy Challenge by Lucas Ballestrino'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.camera),
        onPressed: () {
          Navigator.pushNamed(context, '/camera');
        },
      ),
      body: FutureBuilder(
          future: ref.watch(databaseProvider)!.getImages(),
          builder: (context, snapShot) {
            if (snapShot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapShot.connectionState == ConnectionState.done) {
              return RefreshIndicator(
                onRefresh: () async {
                  setState(() {});
                },
                child: GridView.builder(
                  itemCount: snapShot.data!
                      .map(
                        (e) => Column(
                          children: [
                            Image.network(e.url),
                            Text(e.timeStamp),
                          ],
                        ),
                      )
                      .toList()
                      .length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.5,
                      crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    return snapShot.data!
                        .map(
                          (e) => Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Image.network(e.url),
                                Text(e.timeStamp),
                              ],
                            ),
                          ),
                        )
                        .toList()[index];
                  },
                ),
              );
            }
            return const Center(
              child: Icon(
                Icons.error,
                color: Colors.red,
              ),
            );
          }),
    );
  }
}
