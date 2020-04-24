//
//  GameUIViewController.swift
//  Tic-Tac-Toe
//
//  Created by Hector Delgado on 4/1/20.
//  Copyright © 2020 Hector Delgado. All rights reserved.
//

import UIKit

class GameUIViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var gameboardCollectionView: UICollectionView!
    
    private var player1 = Player(playerName: "", gamePiece: GamePiece(boardPieceType: GamePiece.PieceType.emptylocation))
    private var player2 = Player(playerName: "", gamePiece: GamePiece(boardPieceType: GamePiece.PieceType.emptylocation))
    private var currentPlayer = Player(playerName: "", gamePiece: GamePiece(boardPieceType: GamePiece.PieceType.emptylocation))
    private var player1Turn = (Int.random(in: 0...100) > 50 ? true : false)
    private var gameIsActive = true
    
    var data: [GamePiece] = []
    
//    let estimateWidth = 160.0
//    let cellMarginSize = 16.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        gameboardCollectionView.delegate = self
        gameboardCollectionView.dataSource = self
        createPlayer1()
    }
    
    func createPlayer1() {
        let alert = UIAlertController(title: "Name for Player 1?", message: nil, preferredStyle: .alert)
        alert.addTextField { playerName in
            playerName.placeholder = "Enter your name"
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            let playerName = alert.textFields?.first?.text ?? "Player 1"
            self.player1 = Player(playerName: playerName, gamePiece: GamePiece(boardPieceType: GamePiece.PieceType.circlelocation))
            self.createPlayer2()
        
        }))
        
        self.present(alert, animated: true)
    }
    
    func createPlayer2() {
        let alert = UIAlertController(title: "Name for Player 2?", message: nil, preferredStyle: .alert)
        alert.addTextField { playerName in
            playerName.placeholder = "Enter your name"
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            let playerName = alert.textFields?.first?.text ?? "Player 1"
            self.player2 = Player(playerName: playerName, gamePiece: GamePiece(boardPieceType: GamePiece.PieceType.crosslocation))
            
            self.initializeGame()
            self.gameboardCollectionView.reloadData()
        }))
        
        
        self.present(alert, animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("return pressed")
        textField.resignFirstResponder()
        return true
    }
    
    /**
     Removes then initializes any data from the game board.
     */
    func initializeGame() {
        data.removeAll()
        data = [GamePiece(boardPieceType: GamePiece.PieceType.emptylocation), GamePiece(boardPieceType: GamePiece.PieceType.emptylocation), GamePiece(boardPieceType: GamePiece.PieceType.emptylocation), GamePiece(boardPieceType: GamePiece.PieceType.emptylocation), GamePiece(boardPieceType: GamePiece.PieceType.emptylocation), GamePiece(boardPieceType: GamePiece.PieceType.emptylocation), GamePiece(boardPieceType: GamePiece.PieceType.emptylocation), GamePiece(boardPieceType: GamePiece.PieceType.emptylocation), GamePiece(boardPieceType: GamePiece.PieceType.emptylocation)]
        
        switchPlayers()
    }
    
    func placeGamePiece(indexLocation: Int) {
        if (gameIsActive) {
            if (locationIsAvailable(atIndex: indexLocation)) {
                data[indexLocation].locationType = currentPlayer.gamePieceType.locationType
                checkGameStatus()
            } else {
                print("Location is unavailable")
            }
            
        } else {
            print("Game not active. Time to reset")
            initializeGame()
            gameIsActive = true
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
            return false
        }
    }
    
    /**
     Checks if the game is over, a draw, or still running.
     */
    func checkGameStatus() {
        let gamePiece = currentPlayer.gamePieceType.locationType
        
        let playerWonHorizontally =
            (data[0].locationType == gamePiece && data[1].locationType == gamePiece && data[2].locationType == gamePiece) ||
                (data[3].locationType == gamePiece && data[4].locationType == gamePiece && data[5].locationType == gamePiece) ||
                (data[6].locationType == gamePiece && data[7].locationType == gamePiece && data[8].locationType == gamePiece)
        
        let playerWonVertically =
            (data[0].locationType == gamePiece && data[3].locationType == gamePiece && data[6].locationType == gamePiece) ||
                (data[1].locationType == gamePiece && data[4].locationType == gamePiece && data[7].locationType == gamePiece) ||
                (data[2].locationType == gamePiece && data[5].locationType == gamePiece && data[8].locationType == gamePiece)
        
        let playerWonDiagonally =
            (data[0].locationType == gamePiece && data[4].locationType == gamePiece && data[8].locationType == gamePiece) ||
            (data[2].locationType == gamePiece && data[4].locationType == gamePiece && data[6].locationType == gamePiece)
        
        var gameIsDraw = true
        
        for item in data {
            if item.locationType == GamePiece.PieceType.emptylocation {
                gameIsDraw = false
            }
        }
        
        if (playerWonHorizontally || playerWonVertically || playerWonDiagonally) {
            gameIsActive = false
            self.navigationItem.title = "Click to reset"
            print("Game Over! \(currentPlayer.playerName) has won!")
        } else if (gameIsDraw) {
            self.navigationItem.title = "Click to reset"
            print("Game is a bust. Draw.")
        } else {
            switchPlayers()
        }
    }
    
    func switchPlayers() {
        currentPlayer.copyPlayer(player: player1Turn ? player1 : player2)
        player1Turn = !player1Turn
        self.navigationItem.title = "\(currentPlayer.playerName)'s Turn (\(currentPlayer.gamePieceType.getPieceTypeAsString()))"
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
        placeGamePiece(indexLocation: indexPath.row)
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


