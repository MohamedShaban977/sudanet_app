import 'package:flutter/material.dart';
import 'package:sudanet_app/features/main_layout_home/presentation/cubit/nav_bar_cubit.dart';

import '../widgets/slider_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = NavBarCubit.get(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const AlwaysScrollableScrollPhysics(
            parent: ClampingScrollPhysics()),
        child: Column(
          children: [
            const SizedBox(height: 20.0),
            const SliderWidget(),
            ElevatedButton(
              onPressed: () {
                cubit.changeIndex(1);
              },
              child: const Text('ggg'),
            ),
          ],
        ),
      ),
    );
  }
}
