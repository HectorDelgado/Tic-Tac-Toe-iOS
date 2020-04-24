//
//  Player.swift
//  Tic-Tac-Toe
//
//  Created by Hector Delgado on 4/2/20.
//  Copyright © 2020 Hector Delgado. All rights reserved.
//

import Foundation

struct Player {
    var playerName: String
    var gamePieceType: GamePiece.PieceType
    
    init(playerName: String, gamePiece: GamePiece.PieceType) {
        self.playerName = playerName
        self.gamePieceType = gamePiece
    }
    
    mutating func copyPlayer(player: Player) {
        self.playerName = player.playerName
        self.gamePieceType = player.gamePieceType
    }
}
