//
//  GameModel.swift
//  CollectionGame
//
//  Created by macbook on 24.01.2021.
//

import Foundation
var  countOfMoves = 0

struct Room {
    var width: Int
    var height: Int
}

var room = Room(width: 10, height: 10)

let showEmpty = "💨"
let showHero = "✈️"
let showBox = "🏃‍♂️"
let wall = "🧨"
let endGameSymb = "💰"


var field:[String]{
    var text:[String] = [String]()
    for y in 0...room.height{
        for x in 0...room.width{
            var point = ""
            switch (x,y) {
            case (player.positionX,player.positionY):
                point = showHero
            case (box.positionX,box.positionY): point = showBox
            case(endGame.positionX,endGame.positionY): point = endGameSymb
            default:
                point = 1...room.width - 1  ~= x && 1...room.height - 1 ~= y ? showEmpty : wall
            }
        text.append(point)
        }
    }
    return text
}
    



class PositionInRoom {
    var positionX: Int
    var positionY: Int
    
    
    init(positionX: Int, positionY: Int) {
        self.positionX = positionX
        self.positionY = positionY
    }
}



class Box: PositionInRoom {
}

var box = Box(positionX: Int.random(in: 1...9), positionY: Int.random(in: 1...9))

let startingBox = Box(positionX: 2, positionY: 2)




class EndGame: PositionInRoom {
}

var endGame = EndGame(positionX: Int.random(in: 1...9), positionY: Int.random(in: 1...9))




var player = PositionInRoom(positionX: Int.random(in: 1...9), positionY: Int.random(in: 1...9))

let startingPlayer = PositionInRoom(positionX: 1, positionY: 1)
class Player {
    enum Steps {
        case left, right, down, up
        
        var stepPosition: (x: Int, y: Int) {
            switch self {
            case .left: return (-1, 0)
            case .right: return (1, 0)
            case .down: return (0, 1)
            case .up: return (0, -1)
            }
        }
    }
    
    func moveOn(go: Steps) -> [String] {
        
        switch (player.positionX, player.positionY, go) {
        
        case(1, _, .left): countOfMoves -= 1
            break
        case(_, 1, .up): countOfMoves -= 1
            break
        case(room.width-1, _, .right): countOfMoves -= 1
            break
        case(_, room.height-1, .down): countOfMoves -= 1
            break
           
            
        case (box.positionX, (box.positionY + 1), .up) :
            if box.positionY == 1 {
                break }

            box.positionX += go.stepPosition.x
            box.positionY += go.stepPosition.y
            player.positionX += go.stepPosition.x
            player.positionY += go.stepPosition.y
            
            


        case ((box.positionX - 1), box.positionY, .right) :
            if box.positionX == room.height { break }

            box.positionX += go.stepPosition.x
            box.positionY += go.stepPosition.y
            player.positionX += go.stepPosition.x
            player.positionY += go.stepPosition.y
            

        case ((box.positionX + 1), box.positionY, .left) :
            if box.positionX == 1 {break }

            box.positionX += go.stepPosition.x
            box.positionY += go.stepPosition.y
            player.positionX += go.stepPosition.x
            player.positionY += go.stepPosition.y
           
            


        case (box.positionX, (box.positionY - 1), .down) :
            if box.positionY == room.width { break}

            box.positionX += go.stepPosition.x
            box.positionY += go.stepPosition.y
            player.positionX += go.stepPosition.x
            player.positionY += go.stepPosition.y
            
           



        default : player.positionX += go.stepPosition.x
            player.positionY += go.stepPosition.y
        }
        countOfMoves += 1
        return field
    }
    
    
    
}

var game = Player()
