import '../../../constants/consts.dart';

double animatedPositionedLeftValueTest(int currentIndex) {
  switch (currentIndex) {
    case 0:
      return AppSizes().getBlockSizeHorizontal(7.5);
    case 1:
      return AppSizes().getBlockSizeHorizontal(28.5);
    case 2:
      return AppSizes().getBlockSizeHorizontal(49.8);
    case 3:
      return AppSizes().getBlockSizeHorizontal(71.5);
    default:
      return 0;
  }
}
