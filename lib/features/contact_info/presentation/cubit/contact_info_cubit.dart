import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudanet_app/core/useCases/use_case.dart';

import '../../../../core/api/service_response.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/contact_info_entity.dart';
import '../../domain/use_cases/contact_info_use_case.dart';

part 'contact_info_state.dart';

class ContactInfoCubit extends Cubit<ContactInfoState> {
  ContactInfoCubit({required this.contactInfoUseCase})
      : super(ContactInfoInitial());
  final ContactInfoUseCase contactInfoUseCase;

  ContactInfoCubit get(context) => BlocProvider.of(context);

  Future<void> getContactInfo() async {
    emit(GetContactInfoLoadingState());
    Either<Failure, BaseResponseEntity<ContactInfoEntity>> response =
        await contactInfoUseCase.call(NoParams());

    response.fold(
      (failure) => emit(GetContactInfoErrorState(
          error: HandleFailure.mapFailureToMsg(failure))),
      (response) => emit(GetContactInfoSuccessState(response: response)),
    );
  }
}
