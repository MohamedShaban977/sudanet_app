import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app_manage/assets_manager.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  HomeCubit get(context) => BlocProvider.of(context);

  List<String> imageSlider() {
    return [
      ImageAssets.homeBanner1,
      ImageAssets.homeBanner2,
      ImageAssets.homeBanner3,
      ImageAssets.homeBanner1,
      ImageAssets.homeBanner2,
      ImageAssets.homeBanner3,
    ];
  }

  int yourActiveIndex = 0;

  onPageChanged(int index) {
    print(index);
    yourActiveIndex = index;
    emit(ChangeSliderState());
  }
}
