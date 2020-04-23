//
//  GameboardLocation.swift
//  Tic-Tac-Toe
//
//  Created by Hector Delgado on 4/2/20.
//  Copyright © 2020 Hector Delgado. All rights reserved.
//

import Foundation
import UIKit

struct GamePiece {
    enum PieceType {
        case emptylocation
        case circlelocation
        case crosslocation
    }
    
    var backgroundImg: UIImage
    var locationType: PieceType
    
    init(bgImage: String) {
        self.backgroundImg = UIImage(named: bgImage) ?? #imageLiteral(resourceName: "emptylocation")
        self.locationType = PieceType.emptylocation
    }
}
