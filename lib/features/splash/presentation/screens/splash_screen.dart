import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../../app/injection_container.dart';
import '../../../../core/app_manage/assets_manager.dart';
import '../../../../core/app_manage/contents_manager.dart';
import '../../../../core/cache/cache_data_shpref.dart';
import '../../../../core/routes/magic_router.dart';
import '../../../../core/routes/routes_name.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;

  _startDelay() async {
    _timer =
        Timer(const Duration(seconds: Constants.splashDelay), () => _goNext());
  }

  _goNext() =>
      MagicRouterName.navigateReplacementTo(sl<CacheHelper>().getToken() == null
          ? RoutesNames.loginRoute
          : RoutesNames.mainLayoutApp);

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _buildLottieAsset(),
      ),
    );
  }



  _buildLottieAsset() => Lottie.asset(
        JsonAssets.splash,
        animate: true,
      );
}
