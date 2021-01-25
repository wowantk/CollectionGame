//
//  GameCell.swift
//  CollectionGame
//
//  Created by macbook on 24.01.2021.
//

import UIKit

class GameCell: UICollectionViewCell {

    @IBOutlet weak var textlablel: UILabel!
    override func awakeFromNib() {
        self.translatesAutoresizingMaskIntoConstraints = false
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func setUp(arr:[String],index :  Int){
        self.textlablel.text = arr[index]
    }

}
