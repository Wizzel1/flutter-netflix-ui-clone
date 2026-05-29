import 'package:flutter/material.dart';
import 'package:flutter_netflix_responsive_ui/cubits/cubits.dart';
import 'package:flutter_netflix_responsive_ui/smooth_scroll/scroll_config.dart';
import 'package:flutter_netflix_responsive_ui/smooth_scroll/smooth_scroll.dart';
import 'package:flutter_netflix_responsive_ui/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        // context.bloc<AppBarCubit>().setOffset(_scrollController.offset);
      });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[850],
        child: const Icon(Icons.cast),
        onPressed: () => print("Cast"),
      ),
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 50),
        child: BlocBuilder<AppBarCubit, double>(
          builder: (context, scrollOffset) {
            return CustomAppBar(scrollOffset: scrollOffset);
          },
        ),
      ),
      body: SmoothScrollWeb(
        controller: _scrollController,
        config: SmoothScrollConfig.native(
          scrollSpeed: 0.8, // Standard browser speed
          enableMomentum: true,
          momentumFactor: 0.6, // Natural momentum
        ),
        child: ListView(
          controller: _scrollController,
          children: [
            ContentHeader(featuredContent: sintelContent),
            Preview(
              key: PageStorageKey("previews"),
              title: "Previews",
              contentList: previews,
            ),
            ContentList(
              key: PageStorageKey("myList"),
              title: "My List",
              contentList: myList,
            ),
            ContentList(
              key: PageStorageKey("originals"),
              title: "Netflix Originals",
              contentList: originals,
              isOriginals: true,
            ),
            ContentList(
              key: PageStorageKey("trending"),
              title: "Trending",
              contentList: myList,
            ),
          ],
        ),
      ),
    );
  }
}
