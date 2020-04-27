//
//  GameboardLocation.swift
//  Tic-Tac-Toe
//
//  Created by Hector Delgado on 4/2/20.
//  Copyright © 2020 Hector Delgado. All rights reserved.
//

import Foundation
import UIKit

class GamePiece : Equatable{
    
    enum PieceType {
        case emptylocation
        case circlelocation
        case crosslocation
    }
    
    var backgroundImg: UIImage = #imageLiteral(resourceName: "emptylocation")
    var locationType: PieceType {
        didSet {
            print("Value updating!")
            setBackgroundImg()
        }
    }
    
    init(boardPieceType: PieceType) {
        self.locationType = boardPieceType
    }
    
    func getPieceTypeAsString() -> String {
        switch locationType {
        case .circlelocation:
            return "O"
        case .crosslocation:
            return "X"
        default:
            return "nil"
        }
    }
    
    private func setBackgroundImg() {
        switch locationType {
        case PieceType.circlelocation:
            self.backgroundImg = UIImage(named: "circlelocation") ?? #imageLiteral(resourceName: "emptylocation")
        case PieceType.crosslocation:
            self.backgroundImg = UIImage(named: "crosslocation") ?? #imageLiteral(resourceName: "emptylocation")
        default:
            self.backgroundImg = UIImage(named: "emptylocation") ?? #imageLiteral(resourceName: "emptylocation")
        }
    }
    
    static func == (lhs: GamePiece, rhs: GamePiece) -> Bool {
        return lhs.locationType == rhs.locationType
    }
}
