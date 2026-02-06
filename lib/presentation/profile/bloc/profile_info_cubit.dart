import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_two/domain/usecases/auth/get_user.dart';
import 'package:flutter_two/presentation/profile/bloc/profile_info_state.dart';

import '../../../service_locator.dart';

class ProfileInfoCubit  extends Cubit<ProfileInfoState>{

  ProfileInfoCubit() : super(ProfileInfoLoading());

  Future<void> getUser() async {
    var user = await sl<GetUserUseCase>().call(null);
    user.fold((l){
      emit(ProfileInfoFailure());
    },(userEntity) {
      emit(ProfileInfoLoaded(userEntity:userEntity));
    });
  }
}