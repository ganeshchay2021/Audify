abstract class FavoriteButtonState {}
class FavoriteButtonInitial extends FavoriteButtonState {}
class FavoriteButtonUpdated extends FavoriteButtonState {
  final bool isFavorite;
  FavoriteButtonUpdated(this.isFavorite);
}