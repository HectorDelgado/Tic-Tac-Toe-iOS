//
//  GameUIViewController.swift
//  Tic-Tac-Toe
//
//  Created by Hector Delgado on 4/1/20.
//  Copyright © 2020 Hector Delgado. All rights reserved.
//

import UIKit

class GameUIViewController: UIViewController {

    @IBOutlet weak var gameboardCollectionView: UICollectionView!
    
    //var currentPlayer: Set<String> = ["circle]
    
    private let player1 = Player(gamePiece: GamePiece.PieceType.circlelocation)
    private let player2 = Player(gamePiece: GamePiece.PieceType.crosslocation)
    private var currentPlayer = Player(gamePiece: GamePiece.PieceType.emptylocation)
    private var player1Turn = false
    
    let gameboardData = ["circlelocation", "circlelocation", "circlelocation",
                         "circlelocation", "circlelocation", "circlelocation",
                         "circlelocation", "circlelocation", "circlelocation"]
    
    var data = [GamePiece(bgImage: "emptylocation"), GamePiece(bgImage: "emptylocation"), GamePiece(bgImage: "emptylocation"),
                GamePiece(bgImage: "emptylocation"), GamePiece(bgImage: "emptylocation"), GamePiece(bgImage: "emptylocation"),
                GamePiece(bgImage: "emptylocation"), GamePiece(bgImage: "emptylocation"), GamePiece(bgImage: "emptylocation")]
    
    let estimateWidth = 160.0
    let cellMarginSize = 16.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        gameboardCollectionView.delegate = self
        gameboardCollectionView.dataSource = self
        
        switchPlayers()
    }
    
    func placeGamePiece(indexLocation: Int) {
        data[indexLocation].locationType = currentPlayer.gamePieceType
        
        // check if game is active
        // check if location is available
    }
    
    func switchPlayers() {
        currentPlayer.gamePieceType = player1Turn ? player1.gamePieceType : player2.gamePieceType
        player1Turn = !player1Turn
    }
}

extension GameUIViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameboardData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mCell", for: indexPath) as! GameboardCollectionViewCell
        cell.updateData(gameboardLocation: data[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        
        placeGamePiece(indexLocation: indexPath.row)
        switchPlayers()
        
        gameboardCollectionView.reloadData()
    }
}

extension GameUIViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = CGFloat(self.view.frame.width / 3)
        return CGSize(width: width, height: width)
    }
}


