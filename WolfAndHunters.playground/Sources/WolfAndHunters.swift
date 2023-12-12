import Foundation

public protocol WolfAndHuntersDelegate:TwoPlayerBaseGameDelegate {} 


public class WolfAndHunters: BoardGame, TwoPlayerGame, BaseGame {

    
    public let name = "WolfAndHunters"
    
    public var delegate: WolfAndHuntersDelegate?
    
    public init() {
        
    }
    public var board = Board(boardsize: 8)
    
    public var players: [Player] = [WolfAndHuntersPlayer]()
    
    public func join(player: Player) {
        players.append(player)
        delegate?.player(player, didJoinTheGame: self)
    }
    
    private var numberOfTurns = 0
    
    public var turns: Int {
        get { return numberOfTurns }
    }
    
    public var hasEnded: Bool {
        get {
            if players.count == 0 {
                return true
            } else {
                for p in players {
                    if p.curPos.count == 0 {
                        return true
                    }
                }
            }
            return false
        }
    }
    
    
    public func start() {
        players[0].startPos = [
            Cell(x: cells["A8"]![0], y: cells["A8"]![1]),
            Cell(x: cells["C8"]![0], y: cells["C8"]![1]),
            Cell(x: cells["E8"]![0], y: cells["E8"]![1]),
            Cell(x: cells["G8"]![0], y: cells["G8"]![1])
        ]
        
        players[0].endPos = [
            Cell(x: cells["B1"]![0], y: cells["B1"]![1]),
            Cell(x: cells["D1"]![0], y: cells["D1"]![1]),
            Cell(x: cells["F1"]![0], y: cells["F1"]![1]),
            Cell(x: cells["H1"]![0], y: cells["H1"]![1])
        ]
        
        
        players[0].curPos = players[0].startPos
        
        players[1].startPos = [
            Cell(x: cells["D1"]![0], y: cells["D1"]![1])
        ]
        
        players[1].endPos = [
            Cell(x: cells["A8"]![0], y: cells["A8"]![1]),
            Cell(x: cells["C8"]![0], y: cells["C8"]![1]),
            Cell(x: cells["E8"]![0], y: cells["E8"]![1]),
            Cell(x: cells["G8"]![0], y: cells["G8"]![1])
        ]
        players[1].curPos = players[1].startPos
    }
    
    public func updateBoard() {
        board.cleanBoard()
        for p in players {
            p.curPos.forEach { cell in
                board.setField(data: p.side.rawValue, x: cell.x, y: cell.y)
            }
        }
        for i in 0...7 {
            for j in 0...7 {
                if board.getFullField(x: i, y: j) != 0 {
                    board.setField(data: board.getFullField(x: i, y: j), x: i, y: j)
                }
            }
        }
    }
    public func makeTurn() {
        numberOfTurns += 1
        delegate?.gameDidStartTurn(self)
        for var p in players {
            if numberOfTurns > 1000 {
                for var p in players {
                    p.curPos = []
                }
                break
            }
            //board.showBoard()
            playerMakeTurn(&p)
            if self.hasEnded {
                break
            }
        }
        delegate?.gameDidEndTurn(self)
    }
    
    public func end() {
        delegate?.player(players.filter({ p in p.curPos.count == 0 }).first!, didTakeAction: .win)
        delegate?.gameDidEnd(self)
    }
    
    public func playerMakeTurn( _ player: inout Player) {
        delegate?.playerDidStartTurn(player)
        turn(player: player.side.rawValue, moves: numberOfTurns, Player: player)
        board.showBoard()
    }
    
    public func turn(player: Int, moves: Int, Player: Player) {
        //print("numberOfTurns: \(numberOfTurns)")
        //print("Player curPos.count: \(Player.curPos.count)")
        if moves < 50 {
            var turnSeed:Int = 0
            while true {
                turnSeed = Int.random(in: 0..<Player.curPos.count)
                if checkMove(player: player, cell: Player.curPos[turnSeed]) {
                    break
                }
            }
            while makeTurn(player: player, cell: Player.curPos[turnSeed]) { break }
            checkCell(player: player, cell: Player.curPos[turnSeed], Player: Player)
            
        } else {
            var turnSeed:Int = 0
            var tryCount = 0
            while true {
                turnSeed = Int.random(in: 0..<Player.curPos.count)
                if checkMove(player: player, cell: Player.curPos[turnSeed]) {
                    while makeTurn(player: player, cell: Player.curPos[turnSeed]) {
                        break
                    }
                    checkCell(player: player, cell: Player.curPos[turnSeed], Player: Player)
                    break
                }
                tryCount+=1
                if tryCount > 5 {
                    makeTurn(player: player, cell: Player.curPos[turnSeed])
                    checkCell(player: player, cell: Player.curPos[turnSeed], Player: Player)
                    break
                }
            }
        }
    }

    
    public func makeTurn(player: Int, cell: Cell) -> Bool {
        var isMove = false
        let r = Int.random(in: 0...10)
        if r < 5 {
            while true {
                //wolf
                if (player<0) {
                    if (0...7).contains(cell.x+player) &&
                        (0...7).contains(cell.y+player) && board.getField(x: cell.x+player, y: cell.y+player) == 0  {
                        cell.setX(x: cell.x + player)
                        cell.setY(y: cell.y + player)
                        updateBoard()
                        isMove = true
                        continue
                    }
                    
                    else if (0...7).contains(cell.x+player) &&
                                (0...7).contains(cell.y-player) && board.getField(x: cell.x+player, y: cell.y-player) == 0  {
                        cell.setX(x: cell.x + player)
                        cell.setY(y: cell.y - player)
                        updateBoard()
                        isMove = true
                        continue
                    }
                    else if (0...7).contains(cell.x+2*player) &&
                                (0...7).contains(cell.y+2*player) && board.getField(x: cell.x+2*player, y: cell.y+2*player) == 0  {
                        cell.setX(x: cell.x + 2*player)
                        cell.setY(y: cell.y + 2*player)
                        updateBoard()
                        isMove = true
                        continue
                    }
                    else if (0...7).contains(cell.x+2*player) &&
                                (0...7).contains(cell.y-2*player) && board.getField(x: cell.x+2*player, y: cell.y-2*player) == 0  {
                        cell.setX(x: cell.x + 2*player)
                        cell.setY(y: cell.y - 2*player)
                        updateBoard()
                        isMove = true
                        continue
                    }else { return false }
                }
                if(player>0){
                    //hunters
                    if (0...7).contains(cell.x+player) &&
                        (0...7).contains(cell.y+player) && board.getField(x: cell.x+player, y: cell.y+player) == 0  {
                        cell.setX(x: cell.x + player)
                        cell.setY(y: cell.y + player)
                        updateBoard()
                        isMove = true
                        continue
                    }
                    
                    else if (0...7).contains(cell.x-player) &&
                                (0...7).contains(cell.y+player) && board.getField(x: cell.x-player, y: cell.y+player) == 0  {
                        cell.setX(x: cell.x - player)
                        cell.setY(y: cell.y + player)
                        updateBoard()
                        isMove = true
                        continue
                    }
                    if (0...7).contains(cell.x+player) &&
                        (0...7).contains(cell.y-player) && board.getField(x: cell.x+player, y: cell.y-player) == 0  {
                        cell.setX(x: cell.x + player)
                        cell.setY(y: cell.y - player)
                        updateBoard()
                        isMove = true
                        continue
                    }
                    
                    else if (0...7).contains(cell.x-player) &&
                                (0...7).contains(cell.y-player) && board.getField(x: cell.x-player, y: cell.y-player) == 0  {
                        cell.setX(x: cell.x - player)
                        cell.setY(y: cell.y - player)
                        updateBoard()
                        isMove = true
                        continue
                    }
                    else { return false }
                }
            }
        }
        else{
            while true {
                //wolf
                if (player<0) {
                    if (0...7).contains(cell.x+player) &&
                        (0...7).contains(cell.y-player) && board.getField(x: cell.x+player, y: cell.y-player) == 0  {
                        cell.setX(x: cell.x + player)
                        cell.setY(y: cell.y - player)
                        updateBoard()
                        isMove = true
                        break
                    }
                    
                    else if (0...7).contains(cell.x+player) &&
                                (0...7).contains(cell.y+player) && board.getField(x: cell.x+player, y: cell.y+player) == 0  {
                        cell.setX(x: cell.x + player)
                        cell.setY(y: cell.y + player)
                        updateBoard()
                        isMove = true
                        break
                    }
                    else if (0...7).contains(cell.x+2*player) &&
                                (0...7).contains(cell.y-2*player) && board.getField(x: cell.x+2*player, y: cell.y-2*player) == 0  {
                        cell.setX(x: cell.x + 2*player)
                        cell.setY(y: cell.y - 2*player)
                        updateBoard()
                        isMove = true
                        break
                    }
                    else if (0...7).contains(cell.x+2*player) &&
                                (0...7).contains(cell.y+2*player) && board.getField(x: cell.x+2*player, y: cell.y+2*player) == 0  {
                        cell.setX(x: cell.x + 2*player)
                        cell.setY(y: cell.y + 2*player)
                        updateBoard()
                        isMove = true
                        break
                    }else { return false }
                }
                if(player>0){
                    //hunters
                    if (0...7).contains(cell.x+player) &&
                        (0...7).contains(cell.y-player) && board.getField(x: cell.x+player, y: cell.y-player) == 0  {
                        cell.setX(x: cell.x + player)
                        cell.setY(y: cell.y - player)
                        updateBoard()
                        isMove = true
                        break
                    }
                    
                    else if (0...7).contains(cell.x-player) &&
                                (0...7).contains(cell.y-player) && board.getField(x: cell.x-player, y: cell.y-player) == 0  {
                        cell.setX(x: cell.x - player)
                        cell.setY(y: cell.y - player)
                        updateBoard()
                        isMove = true
                        break
                    }
                    if (0...7).contains(cell.x+player) &&
                        (0...7).contains(cell.y+player) && board.getField(x: cell.x+player, y: cell.y+player) == 0  {
                        cell.setX(x: cell.x + player)
                        cell.setY(y: cell.y + player)
                        updateBoard()
                        isMove = true
                        break
                    }
                    
                    else if (0...7).contains(cell.x-player) &&
                                (0...7).contains(cell.y+player) && board.getField(x: cell.x-player, y: cell.y+player) == 0  {
                        cell.setX(x: cell.x - player)
                        cell.setY(y: cell.y + player)
                        updateBoard()
                        isMove = true
                        break
                    }
                    
                    else { return false }
                }
            }
        }
        return true
    }
    
    public func checkMove(player: Int, cell: Cell) -> Bool {
        
            //wolf
            if (player<0) {
                if ((0...7).contains(cell.x+player) && (0...7).contains(cell.y+player) && board.getField(x: cell.x+player, y: cell.y+player) == 0)  {
                    return true
                }
                
                else if (0...7).contains(cell.x+player) &&
                            (0...7).contains(cell.y-player) && board.getField(x: cell.x+player, y: cell.y-player) == 0  {
                    return true
                }
                else if (0...7).contains(cell.x+2*player) &&
                            (0...7).contains(cell.y+2*player) && board.getField(x: cell.x+2*player, y: cell.y+2*player) == 0  {
                    return true
                }
                else if (0...7).contains(cell.x+2*player) &&
                            (0...7).contains(cell.y-2*player) && board.getField(x: cell.x+2*player, y: cell.y-2*player) == 0  {
                    return true
                }
            }
            if(player>0){
                
                    //hunters
                    if (0...7).contains(cell.x+player) &&
                        (0...7).contains(cell.y-player) && board.getField(x: cell.x+player, y: cell.y-player) == 0  {
                        return true
                    }
                    
                    else if (0...7).contains(cell.x-player) &&
                                (0...7).contains(cell.y-player) && board.getField(x: cell.x-player, y: cell.y-player) == 0  {
                        return true
                    }
                    if (0...7).contains(cell.x+player) &&
                        (0...7).contains(cell.y+player) && board.getField(x: cell.x+player, y: cell.y+player) == 0  {
                        return true
                    }
                    
                    else if (0...7).contains(cell.x-player) &&
                                (0...7).contains(cell.y+player) && board.getField(x: cell.x-player, y: cell.y+player) == 0  {
                        return true
                    }
            } 
        return false

        }
            
    
    public func checkCell(player: Int, cell: Cell, Player: Player) {
        //print("checkCell")
        var isMove = false
        var isFinish = false
        isMove = checkMove(player: player, cell: cell)
        //print(Player.endPos)
        //print("cell.x \(cell.x), cell.y \(cell.y)")
        for el in Player.endPos {
            //print("el.x \(el.x), el.y \(el.y)")
            if (cell.x == el.x && cell.y == el.y) {
                //print("isFinish")
                isFinish = true
            }
        }
        if (!isMove && isFinish) {
            Player.removeCurPos(cell: cell)
            board.setFullField(full: Player.side.rawValue, x: cell.x, y: cell.y)
        }
    }
}
