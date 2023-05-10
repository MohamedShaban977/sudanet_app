import 'package:equatable/equatable.dart';

class ForgetPasswordEntity extends Equatable {

  final String code;

  const ForgetPasswordEntity({required this.code});

  @override
  List<Object?> get props => [ code];
}


