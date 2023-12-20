import Foundation

public protocol BaseGame: Game {
    var turns: Int { get }
    var hasEnded: Bool { get }
    func start()
    func makeTurn()
    func end()
}

// Delegate

public protocol BaseGameDelegate: GameDelegate {
    func gameDidStartTurn(_ game: BaseGame)
    func gameDidEndTurn(_ game: BaseGame)
}

// Default Implementation

extension BaseGame {
    public func play() {
        start()
        while !self.hasEnded {
            makeTurn()
        }
        end()
    }
}

extension BaseGameDelegate {
    public func gameDidStartTurn(_ game: BaseGame) {
        
    }
    public func gameDidEndTurn(_ game: BaseGame) {}
    
    public func gameDidEnd(_ game: Game) {
        print("The game lasted for \((game as! BaseGame).turns) turns")
    }
}
