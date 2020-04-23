//
//  GameboardCollectionViewCell.swift
//  Tic-Tac-Toe
//
//  Created by Hector Delgado on 4/1/20.
//  Copyright © 2020 Hector Delgado. All rights reserved.
//

import UIKit

class GameboardCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var gameboardImage: UIImageView! // 
    
    
    
    func switchImage() {
        gameboardImage.image = UIImage(named: "circlelocation")
    }
    
    func updateData(gameboardLocation: GamePiece) {
        //gameboardImage.image = gameboardLocation.backgroundImg
        switch gameboardLocation.locationType {
        case .emptylocation:
            gameboardImage.image = #imageLiteral(resourceName: "emptylocation")
        case .circlelocation:
            gameboardImage.image = #imageLiteral(resourceName: "circlelocation")
        case .crosslocation:
            gameboardImage.image = #imageLiteral(resourceName: "crosslocation")
        
        //update()
        }
    }
    
//    private func update() {
//        switch GameboardLocation. {
//        case .emptylocation:
//            gameboardImage.image = #imageLiteral(resourceName: "emptylocation")
//        case .circlelocation:
//            gameboardImage.image = #imageLiteral(resourceName: "circlelocation")
//        case .crosslocation:
//            gameboardImage.image = #imageLiteral(resourceName: "crosslocation")
//        }
//    }
}
