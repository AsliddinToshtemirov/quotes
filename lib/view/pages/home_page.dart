import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quotes/view-model/quote_provider.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();

    getRandomQuote();
  }

  getRandomQuote() {
    Future.delayed(
        const Duration(
          seconds: 1,
        ), () {
      ref.refresh(getQuoteProvider);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final getQuote = ref.watch(getQuoteProvider);
    return Scaffold(
      body: BackgroundImageFb1(
        imageUrl:
            "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/backgrounds%2Fluke-chesser-3rWagdKBF7U-unsplash.jpg?alt=media&token=9c5fd84c-2d31-4772-91c5-6e2be82797ba",
        child: getQuote.when(
            data: (getQuote) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const Text(
                          ' " ',
                          style: TextStyle(fontSize: 60, color: Colors.white),
                        ),
                        Expanded(child: Container())
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15),
                      child: Text(
                        getQuote.content.toString(),
                        style:
                            const TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(child: Container()),
                        const Text(
                          ' " ',
                          style: TextStyle(fontSize: 60, color: Colors.white),
                        ),
                      ],
                    ),
                    TextButton.icon(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(
                                text: getQuote.content.toString()))
                            .then((_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Copied to your clipboard !')));
                        });
                      },
                      icon: const Icon(Icons.save),
                      label: const Text("copy"),
                    )
                  ],
                ),
            error: (error, stackTrace) => Text(error.toString()),
            loading: () => const Center(child: LinearProgressIndicator())),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => getRandomQuote(),
        child: const Icon(Icons.refresh),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class BackgroundImageFb1 extends StatelessWidget {
  final Widget child;
  final String imageUrl;
  const BackgroundImageFb1(
      {required this.child, required this.imageUrl, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Place as the child widget of a scaffold
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
