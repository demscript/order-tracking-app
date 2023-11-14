import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_tracking/authentication/data/model/user_model.dart';
import 'package:order_tracking/authentication/logic/authentication_states.dart';

class ProfileVM extends StateNotifier<AuthenticationState> {
  final Ref ref;
  final storeProfileVMModel = UserModel();

  ProfileVM (this.ref) : super(AuthenticationInitial());

  saveProfileInformation({required UserModel user}) {
    storeProfileVMModel.userPhoto = user.userPhoto;
    storeProfileVMModel.fullName = user.fullName;
    storeProfileVMModel.email = user.email;
  }
}

final profileVM = Provider((ref) => ProfileVM(ref));
final fetchProfileVM = FutureProvider((ref) => ProfileVM(ref).storeProfileVMModel);
