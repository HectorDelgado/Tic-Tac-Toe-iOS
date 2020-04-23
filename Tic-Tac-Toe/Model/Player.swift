//
//  Player.swift
//  Tic-Tac-Toe
//
//  Created by Hector Delgado on 4/2/20.
//  Copyright © 2020 Hector Delgado. All rights reserved.
//

import Foundation

struct Player {
    var gamePieceType: GamePiece.PieceType
    
    init(gamePiece: GamePiece.PieceType) {
        self.gamePieceType = gamePiece
    }
}
