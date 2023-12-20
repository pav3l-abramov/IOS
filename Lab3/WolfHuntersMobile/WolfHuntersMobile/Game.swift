import Foundation
import UIKit
public protocol Game {
    var name: String { get }
    func play()
}

// Delegates

public protocol GameDelegate {
    func gameDidStart(_ game: Game)
    func gameDidEnd(_ game: Game)
    
}

// Default Implementation

extension GameDelegate {
    
    public func gameDidStart(_ game: Game) {
        print("Started a new game of \(game.name)")
        //textView.text.append("Started a new game of \(game.name)")
    }
    
    func gameDidEnd(_ game: Game) {
        print("Game \"\(game.name)\" end")

        //textView.text.append("Game \"\(game.name)\" end")
    }
}
