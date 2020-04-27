//
//  Player.swift
//  Tic-Tac-Toe
//
//  Created by Hector Delgado on 4/2/20.
//  Copyright © 2020 Hector Delgado. All rights reserved.
//

import Foundation

class Player : Equatable {
    var playerName: String
    var gamePieceType: GamePiece
    
    init(playerName: String, gamePiece: GamePiece) {
        self.playerName = playerName
        self.gamePieceType = gamePiece
    }
    
    func copyPlayer(player: Player) {
        self.playerName = player.playerName
        self.gamePieceType = player.gamePieceType
    }
    
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.gamePieceType.locationType == rhs.gamePieceType.locationType
    }
}
