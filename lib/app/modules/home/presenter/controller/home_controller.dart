import 'package:devnology_challenge/app/modules/home/presenter/store/home_store.dart';
import 'package:devnology_challenge/core/constants/app_constants_utils.dart';
import 'package:devnology_challenge/domain/use_case/module/home/get_event_use_case.dart';

class HomeController {
  final HomeStore homeStore;
  final GetEventUseCase getEventUseCase;

  HomeController({
    required this.homeStore,
    required this.getEventUseCase,
  }) {
    init();
  }

  void init() async {
    await getAEvent();
  }

  Future<void> getAEvent() async {
    await getEventUseCase.getEvent().then((value) {
      homeStore.addEvent(response: value);
    }, onError: (error) {
      homeStore.eventController.addError(error);
    });
  }

  Future<void> resetDialogData() async {
    homeStore.priceNotifier.value = AppConstantsUtils.minPriceValue;
    homeStore.accessibilityNotifier.value = AppConstantsUtils.minAccessibilityValue;
    homeStore.participantsNotifier.value = AppConstantsUtils.minParticipantsValue;
  }
}
