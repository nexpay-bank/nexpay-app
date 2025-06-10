part of 'card_cubit.dart';

@immutable
abstract class CardState {}

class CardInitial extends CardState {}

class CardLoading extends CardState {}

class CardSuccess extends CardState {
  final List<CardModel.Card> cards;
  final String holder;
  CardSuccess(this.cards, this.holder);
}

class CardFailure extends CardState {
  final String error;
  CardFailure(this.error);
}
