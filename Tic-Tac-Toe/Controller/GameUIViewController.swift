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
    
    private var player1 = Player(playerName: "", gamePiece: GamePiece(boardPieceType: GamePiece.PieceType.emptylocation))
    private var player2 = Player(playerName: "", gamePiece: GamePiece(boardPieceType: GamePiece.PieceType.emptylocation))
    private var currentPlayer = Player(playerName: "", gamePiece: GamePiece(boardPieceType: GamePiece.PieceType.emptylocation))
    private var player1Turn = (Int.random(in: 0...100) > 50 ? true : false)
    private var gameIsActive = true
    private var player1Score = 0
    private var player2Score = 0
    private var data: [GamePiece] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        gameboardCollectionView.delegate = self
        gameboardCollectionView.dataSource = self
        
        initializeSettings()
        createPlayers()
    }
    
    private func initializeSettings() {
        let myAttributes = [NSAttributedString.Key.font: UIFont(name: "Avenir-Book", size: 18.0)]
        self.navigationController?.navigationBar.titleTextAttributes = myAttributes as [NSAttributedString.Key : Any]
    }
    
    /**
     
     */
    private func createPlayers() {
        let alert = UIAlertController(title: "Name for Players?", message: nil, preferredStyle: .alert)
        let acceptAction = UIAlertAction(title: "OK", style: .default, handler: { action in
            
            // Initialize player 1
            if let name = alert.textFields?[0].text {
                if (name.count > 0) {
                    self.player1 = Player(playerName: name, gamePiece: GamePiece(boardPieceType: GamePiece.PieceType.circlelocation))
                } else {
                    self.player1 = Player(playerName: "Player 1", gamePiece: GamePiece(boardPieceType: GamePiece.PieceType.circlelocation))
                }
            }
            
            // Initialize player 2
            if let name = alert.textFields?[1].text {
                if (name.count > 0) {
                    self.player2 = Player(playerName: name, gamePiece: GamePiece(boardPieceType: GamePiece.PieceType.crosslocation))
                } else {
                    self.player2 = Player(playerName: "Player 2", gamePiece: GamePiece(boardPieceType: GamePiece.PieceType.crosslocation))
                }
            }
            
            self.initializeGame()
            self.gameboardCollectionView.reloadData()
        })
        
        // Create TextFields for player 1 & 2 names
        alert.addTextField { playerName in
            playerName.placeholder = "Player 1 name"
        }
        alert.addTextField { playerName in
            playerName.placeholder = "Player 2 name"
        }
        
        alert.addAction(acceptAction)
        self.present(alert, animated: true)
    }
    
    /**
     Removes then initializes any data from the game board.
     */
    func initializeGame() {
        data.removeAll()
        data = [GamePiece(boardPieceType: GamePiece.PieceType.emptylocation), GamePiece(boardPieceType: GamePiece.PieceType.emptylocation), GamePiece(boardPieceType: GamePiece.PieceType.emptylocation), GamePiece(boardPieceType: GamePiece.PieceType.emptylocation), GamePiece(boardPieceType: GamePiece.PieceType.emptylocation), GamePiece(boardPieceType: GamePiece.PieceType.emptylocation), GamePiece(boardPieceType: GamePiece.PieceType.emptylocation), GamePiece(boardPieceType: GamePiece.PieceType.emptylocation), GamePiece(boardPieceType: GamePiece.PieceType.emptylocation)]
        
        switchPlayers()
    }
    
    /**
     Attempts to place a game piece at a specified index if its available.
     Resets the game if it's not active.
     - Parameter indexLocation: The index to place a GamePiece at.
     */
    func placeGamePiece(indexLocation: Int, gamePiece: GamePiece) {
        if (gameIsActive) {
            if (locationIsAvailable(atIndex: indexLocation)) {
                data[indexLocation].locationType = gamePiece.locationType
                checkGameStatus()
            } else {
                print("Location is unavailable")
            }
            
        } else {
            self.initializeGame()
            self.gameIsActive = true
        }
    }
    
    /**
     Checks if a location is available on the gameboard.
     - Parameter atIndex: The index that is being checked.
     
     - Returns: True if the location is "empty". False otherwise.
     */
    func locationIsAvailable(atIndex: Int) -> Bool {
        if (data[atIndex].locationType == GamePiece.PieceType.emptylocation) {
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
            self.navigationItem.title = "Game Over"
            self.present(simpleAlert(alertTitle: "\(currentPlayer.playerName) has won",alertMessage: "Click the board to reset",actionTitle: "OK",handler: nil),animated: true)
            
        } else if (gameIsDraw) {
            gameIsActive = false
            self.navigationItem.title = "Game Over"
            self.present(simpleAlert(alertTitle: "Game is a bust. Draw",alertMessage: "Click the board to reset",actionTitle: "OK",handler: nil),animated: true)
        } else {
            switchPlayers()
        }
    }
    
    func switchPlayers() {
        currentPlayer.copyPlayer(player: player1Turn ? player1 : player2)
        player1Turn = !player1Turn
        
        self.navigationItem.title = "\(currentPlayer.playerName)'s Turn (\(currentPlayer.gamePieceType.getPieceTypeAsString()))"
    }
    
    /**
     Instantiates and returns a UIAlertController that displays a simple action.
     */
    private func simpleAlert(alertTitle: String?, alertMessage: String?, actionTitle: String?, handler: (() -> Void)?) -> UIAlertController {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        
        let simpleAction = UIAlertAction(title: actionTitle, style: .default) { action in
            handler
        }
        alert.addAction(simpleAction)
        return alert
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
        placeGamePiece(indexLocation: indexPath.row, gamePiece: currentPlayer.gamePieceType)
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


