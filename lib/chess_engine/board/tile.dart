import 'dart:collection';

import 'package:flutter_chess/chess_engine/pieces/piece.dart';

abstract class Tile {
  final int _tileCoordinate;

  Tile._(this._tileCoordinate);

  static Map<int, EmptyTile> _EMPTY_TILES_CACHE =
      _createAllPossibleEmptyTiles();

  ///Expects a bool, true if occupied
  get isTileOccupied;

  ///Expects a piece if occupied and null if not
  get getPiece;

  static Map<int, EmptyTile> _createAllPossibleEmptyTiles() {
    final Map<int, EmptyTile> emptyTileMap = HashMap<int, EmptyTile>();

    for (var i = 0; i < 64; i++) {
      emptyTileMap[i] = EmptyTile._(i);
    }

    return Map.unmodifiable(emptyTileMap);
  }

  static Tile createTile(final int tileCoordinate, final Piece? piece) {
    return piece != null
        ? OccupiedTile._(tileCoordinate, piece)
        : EmptyTile._(tileCoordinate);
  }
}

class EmptyTile extends Tile {
  EmptyTile._(final int _tileCoordinate) : super._(_tileCoordinate);

  @override
  get isTileOccupied => false;

  @override
  get getPiece => null;
}

class OccupiedTile extends Tile {
  OccupiedTile._(
    final int _tileCoordinate,
    this._pieceOnTile,
  ) : super._(_tileCoordinate);

  final Piece _pieceOnTile;

  @override
  get isTileOccupied => true;

  @override
  get getPiece => _pieceOnTile;
}
