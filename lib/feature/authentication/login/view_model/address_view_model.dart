import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_repo/product/base/model/latlong.dart';

part 'address_view_model.g.dart';

@riverpod
final class AddressViewModel extends _$AddressViewModel {
  @override
  Future<String> build() {
    return Future.delayed(const Duration(seconds: 2), () => 'Address');
  }

  Future<void> getAddress(LatLong lt) async {
    state = const AsyncLoading();
    final address = await Future.value('Address');
    Future.delayed(const Duration(seconds: 2), () {
      state = AsyncData(address);
    });
  }

  void changeAddress(String address) {
    state = AsyncData(address);
  }
}
