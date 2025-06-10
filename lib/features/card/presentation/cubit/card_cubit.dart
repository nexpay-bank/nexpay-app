import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:nexpay/data/models/auth_token/auth_token.dart';
import 'package:nexpay/data/models/card/card.dart' as CardModel;
import 'package:nexpay/features/card/domain/usecases/create_card_use_case.dart';
import 'package:nexpay/features/card/domain/usecases/get_card_use_case.dart';
import 'package:meta/meta.dart';
part 'card_state.dart';

class CardCubit extends Cubit<CardState> {
  final CreateCardUseCase createCardUseCase;
  final GetCardUseCase getCardUseCase;
  final Isar isar;

  CardCubit(this.createCardUseCase, this.isar, this.getCardUseCase)
    : super(CardInitial());
  void createCard() async {
    emit(CardLoading());
    try {
      await createCardUseCase();
      final cards = await isar.cards.where().findAll();
      final holder = await isar.authTokens.where().findFirst();
      emit(CardSuccess(cards, holder?.username ?? "Nexpay"));
    } catch (e) {
      emit(CardFailure("Gagal: ${e.toString()}"));
    }
  }

  void getCard() async {
    emit(CardLoading());
    try {
      await getCardUseCase();
      final cards = await isar.cards.where().findAll();
      final holder = await isar.authTokens.where().findFirst();
      emit(CardSuccess(cards, holder?.username ?? "Nexpay"));
    } catch (e) {
      emit(CardFailure("Gagal: ${e.toString()}"));
    }
  }

  void resetState() {
    emit(CardInitial());
  }
}
