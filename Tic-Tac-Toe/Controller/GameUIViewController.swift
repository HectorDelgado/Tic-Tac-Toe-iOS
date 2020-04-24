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
    
    private let player1 = Player(playerName: "Player 1", gamePiece: GamePiece.PieceType.circlelocation)
    private let player2 = Player(playerName: "Player 2", gamePiece: GamePiece.PieceType.crosslocation)
    private var currentPlayer = Player(playerName: "", gamePiece: GamePiece.PieceType.emptylocation)
    private var player1Turn = false
    private var gameIsActive = true
    
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
    
    func initializeGame() {
        
    }
    
    func placeGamePiece(indexLocation: Int) {
        if (gameIsActive) {
            if (locationIsAvailable(atIndex: indexLocation)) {
                data[indexLocation].locationType = currentPlayer.gamePieceType
            }
            
            checkGameStatus()
        } else {
            print("Game not active. Time to reset")
        }
        
    }
    
    /**
     Checks if a location is available on the gameboard.
     - Parameter atIndex: The index that is being checked.
     
     - Returns: True if the location is "empty". False otherwise.
     */
    func locationIsAvailable(atIndex: Int) -> Bool {
        if (data[atIndex].locationType == GamePiece.PieceType.emptylocation) {
            print("Setting gamepiece at \(atIndex)")
            return true
        } else {
            print("Location is unavailable")
            return false
        }
    }
    
    func checkGameStatus() {
        // Player has won horizontally
        let playerWonHorizontally =
            (data[0].locationType == currentPlayer.gamePieceType && data[1].locationType == currentPlayer.gamePieceType && data[2].locationType == currentPlayer.gamePieceType) ||
                (data[3].locationType == currentPlayer.gamePieceType && data[4].locationType == currentPlayer.gamePieceType && data[5].locationType == currentPlayer.gamePieceType) ||
                (data[6].locationType == currentPlayer.gamePieceType && data[7].locationType == currentPlayer.gamePieceType && data[8].locationType == currentPlayer.gamePieceType)
        
        let playerWonVertically =
            (data[0].locationType == currentPlayer.gamePieceType && data[3].locationType == currentPlayer.gamePieceType && data[6].locationType == currentPlayer.gamePieceType) ||
                (data[1].locationType == currentPlayer.gamePieceType && data[4].locationType == currentPlayer.gamePieceType && data[7].locationType == currentPlayer.gamePieceType) ||
                (data[2].locationType == currentPlayer.gamePieceType && data[5].locationType == currentPlayer.gamePieceType && data[8].locationType == currentPlayer.gamePieceType)
        
        let playerWonDiagonally =
            (data[0].locationType == currentPlayer.gamePieceType && data[4].locationType == currentPlayer.gamePieceType && data[8].locationType == currentPlayer.gamePieceType) ||
                (data[2].locationType == currentPlayer.gamePieceType && data[4].locationType == currentPlayer.gamePieceType && data[6].locationType == currentPlayer.gamePieceType)
        
        if (playerWonHorizontally || playerWonVertically || playerWonDiagonally) {
            gameIsActive = false
            print("Game Over! \(currentPlayer.playerName) has won!")
        }
    }
    
    func switchPlayers() {
        currentPlayer.gamePieceType = player1Turn ? player1.gamePieceType : player2.gamePieceType
        player1Turn = !player1Turn
    }
}

extension GameUIViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
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


