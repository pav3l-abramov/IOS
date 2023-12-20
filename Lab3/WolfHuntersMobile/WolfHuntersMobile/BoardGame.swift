import Foundation

public protocol BoardGame: Game {
    var board: Board { get }
}
