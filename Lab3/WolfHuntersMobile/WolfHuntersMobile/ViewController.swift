//
//  ViewController.swift
//  WolfHuntersMobile
//
//  Created by user252252 on 12/19/23.
//

import UIKit


class ViewController: UIViewController {
    @IBAction func playButton(_ sender: UIButton) {
        textView.text="New Game"
        
        
        let board=Board(boardsize: 8)
        board.delegate=self
        
        
        let game = WolfAndHunters()
        game.delegate = WolfAndHuntersTracker()

        game.join(player: WolfAndHuntersPlayer(name: "Hunters", side: Side.white, achievedCells: 0))

        game.join(player: WolfAndHuntersPlayer(name: "Wolf", side: Side.black, achievedCells: 0))
        game.play()
        print(textView.text)

    }
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


}
extension ViewController:ChangeTextViewTextDelegate{
    func changeTextViewText(text: String) {
        textView.text.append(text)
    }
    
}
