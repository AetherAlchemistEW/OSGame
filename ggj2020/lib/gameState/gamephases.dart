import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

class GameStateModel{

}

abstract class GamePhase {
  Stream<GameStateModel> gameState();
}

class PhaseOne implements GamePhase {
  Stream<GameStateModel> gameState(){
    StreamBuilder(
      //builder: ,
    );
  }
}