import UIKit

let game = WolfAndHunters()

game.delegate = WolfAndHuntersTracker()

game.join(player: WolfAndHuntersPlayer(name: "Hunters", side: Side.white, achievedCells: 0))

game.join(player: WolfAndHuntersPlayer(name: "Wolf", side: Side.black, achievedCells: 0))

game.play()
