//
//  SettingsController.swift
//  CollectionGame
//
//  Created by macbook on 25.01.2021.
//

import UIKit
import PKHUD

class SettingsController: UIViewController {
    
    
    @IBOutlet weak var personX: UITextField!
    @IBOutlet weak var personY: UITextField!
    @IBOutlet weak var boxX: UITextField!
    @IBOutlet weak var boxY: UITextField!
    @IBOutlet weak var targetX: UITextField!
    @IBOutlet weak var targetY: UITextField!
    
    private var textException:String = ""
    
    var delegate:MethodGame?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    @IBAction func newGameAction(_ sender: Any) {
        do {
            try checkSettings()
        } catch {
            HUD.flash(.labeledError(title: "Error", subtitle: textException), onView: self.view, delay: 3, completion: nil)
            return
            
        }
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    private func checkSettings() throws{
        let pX = Int(personX.text! ) ?? -1
        let pY = Int(personY.text! ) ?? -1
        let bX = Int(boxX.text! ) ?? -1
        let bY = Int(boxY.text! ) ?? -1
        let tX = Int(targetX.text!) ?? -1
        let tY = Int(targetY.text!) ?? -1
        if pX <= 0 || pY <= 0 || bX <= 0 || bY <= 0 || tX <= 0 || tY <= 0 {
            textException = SettingsEroor.textInCase.errorDescription
            throw SettingsEroor.textInCase
            
            
        }
        if pX == room.width || bX == room.width || tX == room.width || pY == room.height || bY == room.height || tY == room.height {
            textException = SettingsEroor.textInCase.errorDescription
            throw SettingsEroor.positionAfterSize
        }
        
        if pX == bX && pY == bY || pX == tX && pY == tY || bX == tY && bY == tX {
            textException = SettingsEroor.sameData.errorDescription
            throw SettingsEroor.sameData
            
        }
        
        if bX == 1 && bY == 1 || bY==1 && bX == room.width-1  || bX == 1 &&  bY == room.height-1 || bX == room.width-1 && bY == room.height-1{
            textException = SettingsEroor.cornerData.errorDescription
            throw SettingsEroor.cornerData
            
        }
        let  pl = PositionInRoom(positionX: pX, positionY: pY)
        let  bx = Box(positionX: bX, positionY: bY)
        let endGame = EndGame(positionX: tX, positionY: tY)
        delegate?.newGameForPerson(pl: pl, bx:bx, tr: endGame)
        self.dismiss(animated: true, completion: nil)
        
    }
}


enum SettingsEroor:Error{
    case textInCase
    case positionAfterSize
    case sameData
    case cornerData
    
    var errorDescription:String {
        switch self {
        case .positionAfterSize:
            return "Your data after size of game fields"
        case.textInCase:
            return "You set text or wrong dimensions in options field"
        case.sameData:
            return "You set same data for box or target or player"
        case.cornerData:
            return "You set wrong data for box you can't play"
        }
        
        
        
    }
}
