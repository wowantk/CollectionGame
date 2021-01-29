//
//  ViewController.swift
//  CollectionGame
//
//  Created by macbook on 24.01.2021.
//

import UIKit
import PKHUD
class ViewController: UIViewController, MethodGame {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    private var arr = field
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(UINib(nibName: "GameCell", bundle: nil), forCellWithReuseIdentifier: "GameCell")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "test", let vc = segue.destination as? SettingsController{
            vc.modalPresentationStyle = .fullScreen
            vc.delegate = self
        }
    }
    
    
    @IBAction func rightButoon(_ sender: Any) {
        arr =  game.moveOn(go: .right)
        label.text = "\(countOfMoves)"
        self.collectionView.reloadData()
        checkWin()
    }
    
    @IBAction func letButoon(_ sender: Any) {
        arr =  game.moveOn(go: .left)
        label.text = "\(countOfMoves)"
        self.collectionView.reloadData()
        checkWin()
    }
    
    @IBAction func upBUTTON(_ sender: Any) {
        arr =  game.moveOn(go: .up)
        label.text = "\(countOfMoves)"
        self.collectionView.reloadData()
        checkWin()
    }
    
    @IBAction func downButton(_ sender: Any) {
        arr =  game.moveOn(go: .down)
        label.text = "\(countOfMoves)"
        self.collectionView.reloadData()
        checkWin()
    }
    
    @IBAction func settings(_ sender: Any) {
    }
    
    @IBAction func newGame(_ sender: Any) {
        newGameForPerson(pl: startingPlayer, bx: startingBox)
        
    }
}

extension ViewController:UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout


{
    
    
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (room.height+1) * (room.width+1)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let c = UICollectionViewCell(frame: .zero)
//        c.contentView = UILabel(frame: .zero)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCell", for: indexPath) as! GameCell
        cell.setUp(arr: arr, index: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Int(collectionView.frame.size.width) / 11
        let height = Int(collectionView.frame.size.height) / 11
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    internal func newGameForPerson(pl: PositionInRoom, bx: Box) {
        countOfMoves = 0
        label.text = "\(countOfMoves)"
        player.positionX = pl.positionX
        box.positionX = bx.positionX
        player.positionY = pl.positionY
        box.positionY = bx.positionY
        self.arr = field
        self.collectionView.reloadData()
    }
    private  func checkWin()->Void{
        
        if box.positionX == endGame.positionX && box.positionY == endGame.positionY {
            HUD.flash(.labeledSuccess(title: "Win", subtitle: "New game started"), onView: self.view, delay: 1, completion: nil)
            box.positionX = startingBox.positionX
            box.positionY = startingBox.positionY
            player.positionX = startingPlayer.positionX
            player.positionY = startingPlayer.positionY
            newGameForPerson(pl: startingPlayer, bx: startingBox)
            
        }
        
    }
    
    
    
    
}

protocol MethodGame {
    func newGameForPerson(pl: PositionInRoom, bx: Box)
}







